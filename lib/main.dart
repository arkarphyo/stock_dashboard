import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stock_dashboard/app/Config/AppPage.dart';
import 'package:stock_dashboard/app/Splash.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app/Config/AppTheme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Supabase.initialize(
  //     url: "https://bomcwkuohmtqljgnsfrm.supabase.co",
  //     anonKey:
  //         "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJvbWN3a3VvaG10cWxqZ25zZnJtIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY4ODE5MTk5MSwiZXhwIjoyMDAzNzY3OTkxfQ.P6Z1jauWGqwiPhRQYK_ToFsnNYOXM1GoGWstOCSpWJc");
  await Supabase.initialize(
    url:
        "http://localhost:8000", //"postgres://postgres:D@nger0us99@db.localhost:5432/postgres",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.ewogICAgInJvbGUiOiAiYW5vbiIsCiAgICAiaXNzIjogInN1cGFiYXNlIiwKICAgICJpYXQiOiAxNjg5NDQyMjAwLAogICAgImV4cCI6IDE4NDcyOTUwMDAKfQ.0dLn6aYlTjEUuQHVQce3cBKSr6-0kx9kh4SZ75CVFgg",
  );
  setPathUrlStrategy();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      title: 'Stock Management',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const Splash(),
        );
      },
      theme: AppTheme.basic,
      themeMode: ThemeMode.dark,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
