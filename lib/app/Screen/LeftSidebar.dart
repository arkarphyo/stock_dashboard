import 'package:flutter/material.dart';
import 'package:stock_dashboard/app/Screen/Components/SideBar.dart';
import 'package:stock_dashboard/app/Screen/MainScreen.dart';

import '../Config/AppConstant.dart';

class LeftSidebar extends StatelessWidget {
  const LeftSidebar({
    Key? key,
    required this.constraints,
    required this.controller,
  }) : super(key: key);
  final BoxConstraints constraints;
  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: (constraints.maxWidth < 1360) ? 4 : 3,
      child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(kBorderRadius),
            bottomRight: Radius.circular(kBorderRadius),
          ),
          child: Sidebar(
              constraints: constraints,
              initSelected: controller.initSelected(),
              data: controller.getSelectedUser())),
    );
  }
}
