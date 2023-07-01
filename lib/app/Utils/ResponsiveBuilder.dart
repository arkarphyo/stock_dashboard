import 'package:flutter/material.dart';
import '../Screen/MainScreen.dart';

class ResponsiveBuilder extends StatelessWidget {
  DashboardController controller = DashboardController();
  ResponsiveBuilder({
    required this.mobileBuilder,
    required this.tabletBuilder,
    required this.desktopBuilder,
    Key? key,
  }) : super(key: key);

  final Widget Function(
    BuildContext context,
    BoxConstraints constraints,
  ) mobileBuilder;

  final Widget Function(
    BuildContext context,
    BoxConstraints constraints,
  ) tabletBuilder;

  final Widget Function(
    BuildContext context,
    BoxConstraints constraints,
  ) desktopBuilder;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1250 &&
      MediaQuery.of(context).size.width >= 650;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1250;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1250) {
          controller.responsiveMobile = false;
          controller.responsiveTablet = false;
          controller.responsiveDesktop = true;
          return desktopBuilder(context, constraints);
        } else if (constraints.maxWidth >= 650) {
          controller.responsiveMobile = false;
          controller.responsiveTablet = true;
          controller.responsiveDesktop = false;
          return tabletBuilder(context, constraints);
        } else {
          controller.responsiveMobile = true;
          controller.responsiveTablet = false;
          controller.responsiveDesktop = false;
          return mobileBuilder(context, constraints);
        }
      },
    );
  }
}
