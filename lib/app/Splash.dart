import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Config/AppPage.dart';
import 'Utils/Service/auth_service.dart';
import 'Utils/Widgets/LoadingWidget.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late bool logged;

  @override
  void initState() {
    logged = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(border: Border.all(width: 0.2, color: Colors.white)),
        child: FutureBuilder(
            future: AuthService.checkConnection(),
            builder: (context, AsyncSnapshot internetSnapshot) {
              if (internetSnapshot.hasData) {
                if (internetSnapshot.data!) {
                  return StreamBuilder<bool?>(
                    stream: AuthService.alreadyLogged(),
                    builder: (context, AsyncSnapshot<bool?> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!) {
                          WidgetsBinding.instance
                              .addPostFrameCallback((_) async {
                            await Get.offAllNamed(Routes.dashboard);
                          });
                        } else {
                          WidgetsBinding.instance
                              .addPostFrameCallback((_) async {
                            await Get.offAllNamed(Routes.login);
                          });
                        }
                        return Scaffold(
                          body: Center(
                              child: snapshot.data!
                                  ? const Center(
                                      child: Text("Already Logged"),
                                    )
                                  : const Center(
                                      child: Text("LOGIN"),
                                    )),
                        );
                      } else if (snapshot.hasError) {
                        return Scaffold(
                            body: Text("${snapshot.error.toString()}"));
                      } else {
                        return const LoadingWidget();
                      }
                    },
                  );
                } else {
                  return const RetryWidget();
                }
              } else {
                return const LoadingWidget();
              }
            }));
  }
}

class RetryWidget extends StatelessWidget {
  const RetryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "No Internet Connection!",
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: MaterialButton(
              onPressed: () {},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Retry"),
                  Icon(
                    Icons.refresh_outlined,
                    size: 32,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
