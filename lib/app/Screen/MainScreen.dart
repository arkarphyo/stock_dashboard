library essential;

import 'dart:developer';
import 'dart:html' as html;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_dashboard/app/Screen/Components/SideBar.dart';
import 'package:stock_dashboard/app/Screen/ManageStock/ManageStock.dart';
import 'package:stock_dashboard/app/Utils/ResponsiveBuilder.dart';
import 'package:stock_dashboard/app/Utils/Service/auth_service.dart';
import 'package:stock_dashboard/app/Utils/Service/local_storage_service.dart';
import 'package:stock_dashboard/app/Utils/Widgets/AppDialogWidget.dart';
import 'package:stock_dashboard/app/Utils/Widgets/LoadingWidget.dart';
import '../Config/AppConstant.dart';
import '../Config/AppPage.dart';
import '../Config/assets_path.dart';
import '../Model/Profile.dart';
import 'Components/ProjectCard.dart';
import 'Dashboard/DashboardContent.dart';
//WEB ONLY
import 'package:window_location_href/window_location_href.dart';
import 'package:shimmer/shimmer.dart';

import 'LeftSidebar.dart';
part '../Bind/dashboard_binding.dart';
part '../Controller/dashboard_controller.dart';

class MainScreen extends GetView<DashboardController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthService.checkConnection(),
        builder: (BuildContext context, updateSnapshot) {
          if (updateSnapshot.hasData) {
            if (updateSnapshot.data!) {
              print("-----${updateSnapshot.data!}");
              return StreamBuilder(
                stream: AuthService.alreadyLogged(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data);
                    if (snapshot.data!) {
                      controller.initGet();
                      return Scaffold(
                        key: controller.scaffoldKey,
                        resizeToAvoidBottomInset: false,
                        endDrawer: (ResponsiveBuilder.isDesktop(context)
                            ? null
                            : LayoutBuilder(
                                builder: (context, constraints) => Drawer(
                                  width: MediaQuery.of(context).size.width / 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: kSpacing / 2),
                                    child: GetBuilder<DashboardController>(
                                        builder: (controller) =>
                                            controller.rightSidebarData),
                                  ),
                                ),
                              )),
                        drawerEnableOpenDragGesture: false,
                        drawer: (ResponsiveBuilder.isDesktop(context))
                            ? null
                            : LayoutBuilder(
                                builder: (context, constraints) {
                                  return Drawer(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(top: kSpacing),
                                      child: GetBuilder<DashboardController>(
                                          builder: (controller) => Sidebar(
                                                data: controller
                                                    .getSelectedUser(),
                                                initSelected:
                                                    controller.initSelected(),
                                                constraints: constraints,
                                              )),
                                    ),
                                  );
                                },
                              ),
                        body: SafeArea(child: GetBuilder<DashboardController>(
                            builder: (controller) {
                          Widget rightSidebar = Flexible(
                            child: Column(
                              children: [
                                const SizedBox(height: kSpacing / 2),
                                BuildProfile(data: controller.getProfile()),
                                const Divider(thickness: 1),
                                Expanded(
                                  child: controller.rightSidebarData,
                                ),
                              ],
                            ),
                          );

                          return ResponsiveBuilder(
                            mobileBuilder: (context, constraints) {
                              controller.responsiveMobile = true;
                              controller.responsiveTablet = false;
                              controller.responsiveDesktop = false;

                              log("Responsive Size Mobile ${controller.responsiveMobile}");
                              return StreamBuilder<Widget>(
                                stream: controller.mainPageStateController(
                                  context,
                                  controller,
                                  constraints,
                                ),
                                builder: (context, snapshot) {
                                  Widget content = Flexible(
                                      flex: 9, child: controller.contentData);
                                  return Row(
                                    children: [
                                      controller.isLoading
                                          ? const ContentWaitLoader()
                                          : content,
                                    ],
                                  );
                                },
                              );
                            },
                            tabletBuilder: (context, constraints) {
                              Widget content = Flexible(
                                  flex: 9, child: controller.contentData);
                              controller.responsiveMobile = false;
                              controller.responsiveTablet = true;
                              controller.responsiveDesktop = false;
                              log("Responsive Size Table ${controller.responsiveTablet}");

                              return StreamBuilder<Widget>(
                                  stream: controller.mainPageStateController(
                                    context,
                                    controller,
                                    constraints,
                                  ),
                                  builder:
                                      (context, AsyncSnapshot snapshotWidget) {
                                    Widget content = Flexible(
                                        flex: 9, child: controller.contentData);
                                    return Row(
                                      children: [
                                        //LeftSidebar(constraints: constraints, controller: controller),
                                        controller.isLoading
                                            ? const ContentWaitLoader()
                                            : content,
                                        //controller.isLoading ? const ContentWaitLoader(flexSize: 4) : rightSidebar,
                                      ],
                                    );
                                  });
                            },
                            desktopBuilder: (context, constraints) {
                              Widget content = Flexible(
                                  flex: 9, child: controller.contentData);
                              controller.responsiveMobile = false;
                              controller.responsiveMobile = false;
                              controller.responsiveDesktop = true;
                              log("Responsive Size Desktop ${controller.responsiveDesktop}");
                              controller.mainPageStateController(
                                  context, controller, constraints);
                              return StreamBuilder<Widget>(
                                  stream: controller.mainPageStateController(
                                    context,
                                    controller,
                                    constraints,
                                  ),
                                  builder:
                                      (context, AsyncSnapshot snapshotWidget) {
                                    Widget content = Flexible(
                                        flex: 9, child: controller.contentData);
                                    return Row(
                                      children: [
                                        LeftSidebar(
                                            constraints: constraints,
                                            controller: controller),
                                        controller.isLoading
                                            ? const ContentWaitLoader()
                                            : content,
                                        controller.isLoading
                                            ? const ContentWaitLoader(
                                                flexSize: 4)
                                            : rightSidebar,
                                      ],
                                    );
                                  });
                            },
                          );
                        })),
                      );
                    } else {
                      Get.offAllNamed(Routes.login);
                      return const Scaffold(
                        body: const Text("Logout"),
                      );
                    }
                  } else if (snapshot.hasError) {
                    return Scaffold(
                      key: controller.scaffoldKey,
                      resizeToAvoidBottomInset: false,
                      body: Center(child: Text("${snapshot.error.toString()}")),
                    );
                  } else {
                    return const LoadingWidget();
                  }
                },
              );
            } else {
              return Center(
                child: SizedBox(
                    child: Column(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                            Icons.signal_wifi_connected_no_internet_4_outlined))
                  ],
                )),
              );
            }
          } else {
            return const LoadingWidget();
          }
        });
  }
}

class ContentWaitLoader extends StatelessWidget {
  const ContentWaitLoader({
    Key? key,
    this.flexSize = 9,
  }) : super(key: key);

  final int flexSize;

  @override
  Widget build(BuildContext context) {
    return Flexible(
        flex: flexSize,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("Please wait ..."),
                    Shimmer.fromColors(
                      child: Text("....."),
                      baseColor: Colors.white,
                      highlightColor: Colors.transparent,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
