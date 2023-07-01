import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_dashboard/app/Screen/MainScreen.dart';
import 'package:stock_dashboard/app/Utils/Service/auth_service.dart';

import '../../Config/AppConstant.dart';
import '../../Config/AppPage.dart';
import '../../Utils/Widgets/AppDialogWidget.dart';
import 'ProjectCard.dart';
import 'SelectionButton.dart';

class Sidebar extends StatelessWidget {
  final ProjectCardData data;
  final int initSelected;
  final BoxConstraints constraints;

  const Sidebar(
      {super.key,
      required this.data,
      required this.initSelected,
      required this.constraints});

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.put(DashboardController());

    return Container(
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(kSpacing / 4),
            child: ProjectCard(data: data),
          ),
          const Divider(thickness: 1),
          Expanded(
              child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            controller: ScrollController(),
            child: Column(
              children: [
                SelectionButton(
                  initialSelected: initSelected,
                  data: [
                    SelectionButtonData(
                      activeIcon: Icons.grid_view_rounded,
                      icon: Icons.grid_view_outlined,
                      label: "Dashboard",
                    ),
                    SelectionButtonData(
                      activeIcon: Icons.account_tree_rounded,
                      icon: Icons.account_tree_outlined,
                      label: "Manage Stock",
                    ),
                    SelectionButtonData(
                      activeIcon: Icons.category_rounded,
                      icon: Icons.category_outlined,
                      label: "Category",
                    ),
                    SelectionButtonData(
                      activeIcon: Icons.location_city_rounded,
                      icon: Icons.location_city_outlined,
                      label: "Location",
                    ),
                  ],
                  onSelected: (index, value) {
                    log("index : $index | label : ${value.label}");
                    switch (index) {
                      case 0:
                        controller.contentHeader = value.label;
                        controller.subUrl = controller.subUrlList[0];
                        break;
                      case 1:
                        controller.contentHeader = value.label;
                        controller.subUrl = controller.subUrlList[1];
                        break;
                      case 2:
                        controller.contentHeader = value.label;
                        controller.subUrl = controller.subUrlList[2];
                        break;
                      case 3:
                        controller.contentHeader = value.label;
                        controller.subUrl = controller.subUrlList[3];
                        break;
                      default:
                    }

                    log("Controller Header ${controller.contentHeader}");
                    //log(html.window.location.href.split('/')[3]);
                    controller.setUrl();
                    controller.closeDrawer();
                    controller.fetchContentData();
                  },
                ),
                MaterialButton(
                  onPressed: () async {
                    AppDialog.showLoading(context);
                    AuthService.logout().then(
                      (value) async => await Get.offAndToNamed(Routes.login),
                    );
                    Navigator.of(context).pop();
                  },
                  child: Text("Logout"),
                  padding: EdgeInsets.all(18),
                  clipBehavior: Clip.antiAlias,
                  color: Colors.redAccent.withOpacity(0.9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
