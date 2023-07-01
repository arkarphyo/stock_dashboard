import 'package:get/get.dart';
import '../Screen/AuthLogin.dart';
import '../Screen/MainScreen.dart';
import '../Screen/SignUp.dart';
import '../Splash.dart';

part 'AppRoute.dart';

/// contains all configuration pages
class AppPages {
  /// when the app is opened, this page will be the first to be shown
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: _Paths.dashboard,
      page: () => const MainScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.reports,
      page: () => const MainScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.orders,
      page: () => const MainScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.products,
      page: () => const MainScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.profile,
      page: () => const MainScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.settings,
      page: () => const MainScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => const AuthLogin(),
    ),
    GetPage(
      name: _Paths.signup,
      page: () => const SignUp(),
    ),
    GetPage(
      name: _Paths.splash,
      page: () => const Splash(),
    ),
  ];
}
