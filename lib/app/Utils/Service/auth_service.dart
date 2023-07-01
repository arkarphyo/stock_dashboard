import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:get/get.dart';
import 'package:stock_dashboard/app/Screen/MainScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../Config/AppConstant.dart';
import '../../Config/AppPage.dart';
import 'local_storage_service.dart';

class AuthService {
  //Check Logged
  static Stream<bool?> alreadyLogged() async* {
    SupabaseClient supabase = Supabase.instance.client;
    LocalStorageServices localStorage = LocalStorageServices();
    bool loggedStatus = false;
    String token;
    String Uid;
    token = localStorage.readData('token');
    Uid = localStorage.readData('uid');
    if (token.isNotEmpty && Uid.isNotEmpty) {
      var response_id =
          await supabase.from("users").select("id").eq("token", token).limit(1);
      print("TOKEN : $token");
      print("UID : $Uid");
      if (Uid == response_id[0]['id'].toString()) {
        loggedStatus = true;
        Get.lazyPut(() => DashboardController());
        await Get.toNamed(Routes.dashboard);
      } else {
        loggedStatus = false;
      }
    } else {
      loggedStatus = false;
    }
    // print('LOGGED : ${response.body.toString()}');
    print("LOGGED STATUS : $loggedStatus");
    print("TOKEN : $token");
    yield loggedStatus;
  }

  static Future<bool?> checkConnection() async {
    SupabaseClient supabase = Supabase.instance.client;
    var locationFetch = await supabase.from("users").select();
    if (locationFetch.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  static String decrypt(String keyString, Encrypted encryptedData) {
    final key = Key.fromUtf8(keyString);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final initVector = IV.fromUtf8(keyString.substring(0, 16));
    return encrypter.decrypt(encryptedData, iv: initVector);
  }

  static Encrypted encrypt(String keyString, String plainText) {
    final key = Key.fromUtf8(keyString);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final initVector = IV.fromUtf8(keyString.substring(0, 16));
    Encrypted encryptedData = encrypter.encrypt(plainText, iv: initVector);
    return encryptedData;
  }

  static Future<Map<String, dynamic>> login(
      SupabaseClient supabase, String username, String password) async {
    Map<String, dynamic> result = {};
    try {
      final fetchUserId =
          await supabase.from("users").select("id").eq("username", username);

      final fetchPassword = await supabase
          .from("users")
          .select("password")
          .eq("id", fetchUserId[0]['id']);

      String decryptedPassword = AuthService.decrypt(
          key, Encrypted(base64.decode(fetchPassword[0]['password'])));
      if (decryptedPassword == password) {
        var data = {"id": fetchUserId[0]['id'], "password": decryptedPassword};
        var userData = await supabase
            .from("users")
            .select()
            .eq("id", fetchUserId[0]['id']);
        if (userData[0]['active'] != 1) {
          result = {
            "success": false,
            "message": "${infoMessages[0]['requestAdminApprove']}"
          };
        } else {
          var token = "";
          await generateToken(supabase, data).then((value) {
            token = value;
            print(value);
          });
          result = {
            "success": true,
            "message": "Login successfully.",
            "token": token,
            "data": data
          };
        }
      } else {
        result = {"success": false, "message": "Invalid username or password!"};
      }
      print(result);
    } catch (e) {
      print(e.toString());
      result = {"success": false, "message": "Invalid username or password!"};
    }

    return result;
  }

  static Future<void> loginData(resultData) async {
    LocalStorageServices localStorage = LocalStorageServices();
    localStorage.writeData("uid", resultData[0]['id'].toString());
    localStorage.writeData("token", resultData[0]['token']);
    localStorage.writeData("firstname", resultData[0]['firstname']);
    localStorage.writeData("lastname", resultData[0]['lastname']);
    localStorage.writeData("userlevel", resultData[0]['level'].toString());
  }

  static Future<void> logoutData() async {
    LocalStorageServices localStorage = LocalStorageServices();
    localStorage.removeData("uid");
    localStorage.removeData("token");
    localStorage.removeData("firstname");
    localStorage.removeData("lastname");
    localStorage.removeData("userlevel");
  }

  static Future<String> generateToken(
      SupabaseClient supabase, Map<String, dynamic> resultData) async {
    var uuid = Uuid();
    String token = uuid.v1(options: resultData);
    final insertToken = await supabase
        .from("users")
        .update({"token": token})
        .eq("id", resultData['id'])
        .select();
    if (insertToken[0]['token'] == token) {
      loginData(insertToken);
    }

    return token;
  }

  static Future<void> logout() async {
    LocalStorageServices localStorageServices = LocalStorageServices();
    SupabaseClient supabase = Supabase.instance.client;

    await supabase
        .from("users")
        .update({"token": ""})
        .eq("id", localStorageServices.readData("uid"))
        .then((value) {
          AuthService.logoutData();
        });
  }
}
