import 'dart:convert';
import 'dart:ui';

import 'package:cool_alert/cool_alert.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_dashboard/app/Config/AppConstant.dart';
import 'package:stock_dashboard/app/Screen/MainScreen.dart';
import 'package:stock_dashboard/app/Screen/SignUp.dart';
import 'package:stock_dashboard/app/Utils/ResponsiveBuilder.dart';
import 'package:stock_dashboard/app/Utils/Service/auth_service.dart';
import 'package:stock_dashboard/app/Utils/Service/local_storage_service.dart';
import 'package:stock_dashboard/app/Utils/Widgets/AppDialogWidget.dart';
import 'package:stock_dashboard/app/Utils/Widgets/LoadingWidget.dart';
import 'package:stock_dashboard/app/Utils/Widgets/UiWidget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Config/AppPage.dart';

class AuthLogin extends StatefulWidget {
  const AuthLogin({super.key});

  @override
  State<AuthLogin> createState() => _AuthLoginState();
}

class _AuthLoginState extends State<AuthLogin> {
  final supabase = Supabase.instance.client;
  Map<String, dynamic> result = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<bool?>(
            stream: AuthService.alreadyLogged(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!) {
                  return const Text("Already Logged");
                } else {
                  return ResponsiveBuilder(
                    mobileBuilder: (context, constraints) {
                      return desktopLoginPage();
                    },
                    tabletBuilder: (context, constraints) {
                      return desktopLoginPage();
                    },
                    desktopBuilder: (context, constraints) {
                      return desktopLoginPage();
                    },
                  );
                }
              } else {
                return LoadingWidget();
              }
            }));
  }

  Widget desktopLoginPage() {
    TextEditingController _usernameController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    FocusNode _usernameFocus = FocusNode();
    FocusNode _passwordFocus = FocusNode();
    FocusNode _loginFocus = FocusNode();
    FocusNode _signUpFocus = FocusNode();
    bool isLoading = false;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
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
          Container(
            padding: EdgeInsets.symmetric(
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
                            left: 0,
                            top: 0,
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
                        "LogIn",
                        style: GoogleFonts.abel(
                            color: Colors.orangeAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),

                //Username & Password Input
                Container(
                  padding: EdgeInsets.symmetric(vertical: kSpacing / 4),
                  width: 300,
                  child: CustomTextInputField(
                      icon: Icons.person,
                      hint: "Username",
                      focusNode: _usernameFocus,
                      controller: _usernameController,
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
                    nextFocusNode: _loginFocus,
                    onSubmit: (v) async {
                      setState(() {
                        //isLoading = true;
                        //AppDialog.showLoading(context);
                      });
                    },
                  ),
                ),

                //Forget Password
                Padding(
                  padding:
                      EdgeInsets.only(left: 0, right: 130, top: 2, bottom: 10),
                  child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 2),
                        child: Text("Forget password?"),
                      )),
                ),

                //Login Button
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: kSpacing / 4, horizontal: kSpacing / 4),
                  width: 250,
                  child: MaterialButton(
                    onPressed: () async {
                      AppDialog.showLoading(context);
                      await AuthService.login(
                        supabase,
                        _usernameController.text,
                        _passwordController.text,
                      ).then((value) async {
                        Navigator.of(context).pop();
                        print("Return $value");
                        if (value['success']) {
                          LocalStorageServices localStorage =
                              LocalStorageServices();

                          Get.lazyPut(() => DashboardController());
                          await Get.offAllNamed(Routes.dashboard);
                        } else {
                          CoolAlert.show(
                            width: 250,
                            context: context,
                            loopAnimation: true,
                            type: CoolAlertType.error,
                            animType: CoolAlertAnimType.slideInUp,
                            title: "Login failed!",
                            text: "${value['message']}",
                            barrierDismissible: true,
                          );
                        }
                      });
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

                //SignUp Button
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: kSpacing / 4, horizontal: kSpacing / 4),
                  width: 250,
                  child: MaterialButton(
                    onPressed: () async {
                      Get.toNamed("signup");
                    },
                    child: Text("SignUp"),
                    padding: EdgeInsets.all(18),
                    clipBehavior: Clip.antiAlias,
                    color: Colors.blueAccent.withOpacity(0.9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
