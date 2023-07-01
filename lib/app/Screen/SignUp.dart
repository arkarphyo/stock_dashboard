import 'dart:ui';

import 'package:cool_alert/cool_alert.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_dashboard/app/Config/AppConstant.dart';
import 'package:stock_dashboard/app/Screen/AuthLogin.dart';
import 'package:stock_dashboard/app/Screen/MainScreen.dart';
import 'package:stock_dashboard/app/Utils/ResponsiveBuilder.dart';
import 'package:stock_dashboard/app/Utils/Widgets/AppDialogWidget.dart';
import 'package:stock_dashboard/app/Utils/Widgets/UiWidget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Config/AppPage.dart';
import '../Utils/Service/auth_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late TextEditingController _usernameController,
      _passwordController,
      _confirmPasswordController,
      _firstnameController,
      _lastnameController;

  FocusNode _firstnameFocus = FocusNode();
  FocusNode _lastnameFoucs = FocusNode();
  FocusNode _usernameFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
  FocusNode _confirmPasswordFocus = FocusNode();
  FocusNode _loginFocus = FocusNode();
  FocusNode _signUpFocus = FocusNode();
  bool _usernameValidate = false;
  bool _passwordValidate = false;
  RxBool _showErrorMessage = false.obs;
  RxString _errorMessage = "".obs;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firstnameController = TextEditingController();
    _lastnameController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  final supabase = Supabase.instance.client;
  Future<Map<String, dynamic>> authSignUp(String firstname, String lastname,
      String username, String password) async {
    var result = Map<String, dynamic>();

    Encrypted encryptedPassword = AuthService.encrypt(key, password);
    print(encryptedPassword.base64);
    final registerFetch = await supabase.from('users').insert({
      "firstname": firstname,
      "lastname": lastname,
      "username": username,
      "password": encryptedPassword.base64
    }).select();
    if (registerFetch[0]["username"] == username) {
      result = {
        "success": true,
        "message": "Successfully registred.",
        "data": registerFetch[0]
      };
    } else {
      result = {
        "success": false,
        "message": "Register failed",
        "data": registerFetch[0],
      };
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ResponsiveBuilder(
      mobileBuilder: (context, constraints) {
        return desktopLoginPage(supabase);
      },
      tabletBuilder: (context, constraints) {
        return desktopLoginPage(supabase);
      },
      desktopBuilder: (context, constraints) {
        return desktopLoginPage(supabase);
      },
    ));
  }

  Widget desktopLoginPage(SupabaseClient supabase) {
    bool usernameExpression(String username) {
      var regExp = RegExp('^[a-z]\\w[a-z0-9]{4,19}\$');
      if (regExp.matchAsPrefix(username) == null) {
        return false;
      }
      return true;
    }

    bool passwordExpression(String password) {
      var regExp = RegExp('^\\w[a-zA-Z0-9.@\$]{8,25}\$');
      if (regExp.matchAsPrefix(password) == null) {
        return false;
      }
      return true;
    }

    bool passwordMatch(String password, String confirmPassword) {
      if (confirmPassword != password) {
        return false;
      }
      return true;
    }

    Map<String, dynamic> doubleCheck(username, password, confirmPassword) {
      if (!usernameExpression(username)) {
        return {
          "success": false,
          "message": "Username မှာ သတ်မှတ် ချက်အတိုင်း မကိုက်ညီပါ။"
        };
      } else if (!passwordExpression(password)) {
        return {
          "success": false,
          "message": "Password မှာ သတ်မှတ် ချက်အတိုင်း‌ မကိုက်ညီပါ။"
        };
      } else if (!passwordMatch(password, confirmPassword)) {
        return {
          "success": false,
          "message": "Confirm Password မှာ Password ဖြင့် မကိုက်ညီပါ။"
        };
      }
      return {"success": true, "message": "သတ်မှတ်ချက်အတိုင်း ပြည့်စုံပါတယ်။"};
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: kSpacing / 2, vertical: kSpacing / 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Left Logo and Language Rows
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kSpacing / 4, vertical: kSpacing / 4),
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/images/logo.png",
                        width: 48,
                        height: 48,
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Center(
                          child: Text(
                            "Stock",
                            style: GoogleFonts.timmana(
                                color: Colors.white, fontSize: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {},
                  child: Ink(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: kSpacing / 4, vertical: kSpacing / 4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.language_outlined,
                            size: 32,
                          ),
                          Text("Language"),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //Login Container
          Container(
            padding: ResponsiveBuilder.isMobile(context)
                ? EdgeInsets.symmetric(horizontal: kSpacing, vertical: kSpacing)
                : EdgeInsets.symmetric(
                    horizontal: kSpacing * 4, vertical: kSpacing),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kSpacing / 3),
                border: Border.all(
                  color: Colors.white,
                  width: 0.1,
                  style: BorderStyle.solid,
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: kSpacing),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            "assets/images/logo.png",
                            width: 63,
                            height: 63,
                          ),
                          Positioned(
                            left: 4,
                            top: 13,
                            child: Center(
                              child: Text(
                                "Stock",
                                style: GoogleFonts.timmana(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Stock Management",
                        style: GoogleFonts.abel(
                            color: Colors.orangeAccent, fontSize: 20),
                      ),
                      Text(
                        "Sign Up",
                        style: GoogleFonts.abel(
                            color: Colors.orangeAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: kSpacing / 4),
                  width: 300,
                  child: CustomTextInputField(
                    icon: Icons.person,
                    hint: "Firstname",
                    focusNode: _firstnameFocus,
                    controller: _firstnameController,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter firstname';
                      }
                      return null;
                    },
                    valCallback: (val) {},
                    nextFocus: _lastnameFoucs,
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(vertical: kSpacing / 4),
                  width: 300,
                  child: CustomTextInputField(
                    icon: Icons.person,
                    hint: "Lastname",
                    focusNode: _lastnameFoucs,
                    controller: _lastnameController,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter lastname.';
                      }
                      return null;
                    },
                    valCallback: (val) {},
                    nextFocus: _usernameFocus,
                  ),
                ),
                //Username & Password Input
                Container(
                  padding: const EdgeInsets.symmetric(vertical: kSpacing / 4),
                  width: 300,
                  child: CustomTextInputField(
                      icon: Icons.person,
                      hint: "Username",
                      focusNode: _usernameFocus,
                      controller: _usernameController,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please enter username';
                        } else if (usernameExpression(val) == false) {
                          return 'start : a-z,allow a-z 0-9, min 6, max : 19';
                        }
                        return null;
                      },
                      valCallback: (val) {
                        _usernameValidate = usernameExpression(val);
                        print(_usernameValidate);
                      },
                      nextFocus: _passwordFocus),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: kSpacing / 4),
                  width: 300,
                  child: CustomPasswordTextInputField(
                    icon: Icons.password,
                    hint: "Password",
                    controller: _passwordController,
                    focusNode: _passwordFocus,
                    nextFocusNode: _confirmPasswordFocus,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter password.';
                      } else if (!passwordExpression(val)) {
                        return 'Min : 8, Only : [a-zA-Z0-9@\$]';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: kSpacing / 4),
                  width: 300,
                  child: CustomPasswordTextInputField(
                    icon: Icons.password,
                    hint: "Confirm Password",
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please type confirm password';
                      } else if (!passwordMatch(
                          _passwordController.text, val)) {
                        return 'Does not match Password!';
                      }
                      return null;
                    },
                    valCallback: (val) {},
                    controller: _confirmPasswordController,
                    focusNode: _confirmPasswordFocus,
                    nextFocusNode: _loginFocus,
                  ),
                ),

                Container(
                    padding: EdgeInsets.symmetric(vertical: kSpacing / 4),
                    width: 300,
                    child: Obx(
                      () => Visibility(
                          visible: _showErrorMessage.value,
                          child: Text(
                            _errorMessage.value,
                            style: TextStyle(color: Colors.red),
                          )),
                    )),

                //SignUp Button
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: kSpacing / 2, horizontal: kSpacing / 4),
                  width: 300,
                  child: MaterialButton(
                    onPressed: () async {
                      AppDialog.showLoading(context);

                      var exitsUsername = "";

                      var reCheck = doubleCheck(
                          _usernameController.text,
                          _passwordController.text,
                          _confirmPasswordController.text);

                      await supabase.from("users").select("username").match(
                          {"username": _usernameController.text}).then((value) {
                        if (value.length > 0) {
                          exitsUsername = value[0]['username'];
                        }
                      });
                      //print(exitsUsername[0]['username']);
                      if (!reCheck['success']) {
                        _errorMessage.value = reCheck['message'];
                        _showErrorMessage.value = true;
                      } else if (exitsUsername == _usernameController.text) {
                        _errorMessage.value =
                            "${_usernameController.text} is already exits!";
                        _showErrorMessage.value = true;
                        print(_errorMessage);
                      } else {
                        _showErrorMessage.value = false;
                        authSignUp(
                                _firstnameController.text,
                                _lastnameController.text,
                                _usernameController.text,
                                _passwordController.text)
                            .then((value) async {
                          if (value['success']) {
                            CoolAlert.show(
                              width: 250,
                              context: context,
                              animType: CoolAlertAnimType.slideInUp,
                              type: CoolAlertType.success,
                              barrierDismissible: true,
                              title: value['message'],
                              text:
                                  "${value['data']['username']} ${infoMessages[0]['registerSuccessInfo']}",
                              confirmBtnText: "OK",
                            );
                          } else {
                            CoolAlert.show(
                              width: 250,
                              context: context,
                              animType: CoolAlertAnimType.slideInUp,
                              type: CoolAlertType.success,
                              title: value['message'],
                              text: "${infoMessages[0]['registerFailedInfo']}",
                              confirmBtnText: "Login",
                            );
                          }
                        });
                      }
                      Navigator.of(context).pop();
                      isLoading = false;
                    },
                    child: Text("SignUp"),
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black87,
                    padding: EdgeInsets.all(18),
                    clipBehavior: Clip.antiAlias,
                    color: Colors.blueAccent.withOpacity(0.9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),

                //OR Divider
                Container(
                    padding: EdgeInsets.symmetric(vertical: kSpacing * 2),
                    width: 250,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Divider(color: Colors.white, height: 1)),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kSpacing * 4),
                            child: Text("OR",
                                style: TextStyle(
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                )),
                          ),
                        )
                      ],
                    )),

                //Login Button
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: kSpacing / 4, horizontal: kSpacing / 4),
                  width: 250,
                  child: MaterialButton(
                    onPressed: () async {
                      Get.toNamed("login");
                    },
                    child: Text("Login"),
                    padding: EdgeInsets.all(18),
                    clipBehavior: Clip.antiAlias,
                    color: Colors.green.withOpacity(0.9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //Bottom Info
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("@2023 All rights reserved and developed by Arkar."),
            ),
          )
        ],
      ),
    );
  }
}
