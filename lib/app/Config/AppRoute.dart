part of 'AppPage.dart';

/// used to switch pages
class Routes {
  static const dashboard = _Paths.dashboard;
  static const reports = _Paths.reports;
  static const orders = _Paths.orders;
  static const products = _Paths.products;
  static const profile = _Paths.products;
  static const settings = _Paths.settings;
  static const login = _Paths.login;
  static const signup = _Paths.signup;
  static const splash = _Paths.splash;
  static const add_product = _Paths.add_product;
}

/// contains a list of route names.
// made separately to make it easier to manage route naming
class _Paths {
  DashboardController controller = DashboardController();
  static const dashboard = '/dashboard';
  static const add_product = '/add-product';
  static const login = '/login';
  static const signup = '/signup';
  static const products = '/products';
  static const reports = '/reports';
  static const orders = '/orders';
  static const profile = '/profile';
  static const settings = '/settings';
  static const splash = '/';

  // Example :
  // static const index = '/';
  // static const splash = '/splash';
  // static const product = '/product';
}
