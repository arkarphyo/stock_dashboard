// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:stock_dashboard/app/Screen/MainScreen.dart';
// import 'package:stock_dashboard/app/Utils/ResponsiveBuilder.dart';

// import '../../Config/AppConstant.dart';
// import '../Components/SideBar.dart';
// import 'DashboardContent.dart';

// class DashboardBuilder extends StatelessWidget {
//   DashboardBuilder({super.key});

//   DashboardController controller = Get.put(DashboardController());

//   @override
//   Widget build(BuildContext context) {
//     return DashboardView();
//   }

//   Widget DashboardView() {
//     Dashboard dashboard = Dashboard();
//     return ResponsiveBuilder(
//       mobileBuilder: (context, constraints) {
//         return GetBuilder<DashboardController>(
//           builder: (controller) {
//             return Column(
//               children: [
//                 const SizedBox(height: kSpacing * (kIsWeb ? 1 : 2)),
//                 BuildHeader(
//                   controller.contentHeader,
//                   onPressedMenu: () => controller.openDrawer(),
//                 ),
//                 const SizedBox(height: kSpacing / 2),
//                 const Divider(),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.vertical,
//                     child: Column(
//                       children: [
//                         Text("Dashboard"),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             );
//           },
//         );
//       },
//       tabletBuilder: (context, constraints) {
//         return GetBuilder<DashboardController>(
//           builder: (controller) {
//             return Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Flexible(
//                   flex: (constraints.maxWidth < 950) ? 6 : 9,
//                   child: Column(
//                     children: [
//                       const SizedBox(height: kSpacing * (kIsWeb ? 1 : 2)),
//                       BuildHeader(
//                         controller.contentHeader,
//                         onPressedMenu: () => controller.openDrawer(),
//                       ),
//                       const SizedBox(height: kSpacing / 3),
//                       const Divider(thickness: 1),
//                       Expanded(
//                         child: SingleChildScrollView(
//                           scrollDirection: Axis.vertical,
//                           child: Column(children: [
//                             Text("Dashboard"),
//                           ]),
//                         ),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             );
//           },
//         );
//       },
//       desktopBuilder: (context, constraints) {
//         return GetBuilder<DashboardController>(
//           builder: (_controller) => Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Flexible(
//                 flex: ResponsiveBuilder.isDesktop(context) ? 3 : 4,
//                 child: ClipRRect(
//                     borderRadius: const BorderRadius.only(
//                       topRight: Radius.circular(kBorderRadius),
//                       bottomRight: Radius.circular(kBorderRadius),
//                     ),
//                     child: Sidebar(
//                         constraints: constraints,
//                         initSelected: controller.initSelected(),
//                         data: controller.getSelectedUser())),
//               ),
//               Flexible(
//                 fit: FlexFit.tight,
//                 flex: 9,
//                 child: dashboard.dashboardContent(
//                     context, constraints, controller),
//               ),

//               // Flexible(
//               //   flex: 4,
//               //   child: SingleChildScrollView(
//               //     child: Column(
//               //       children: [
//               //         const SizedBox(height: kSpacing / 2),
//               //         Text("Dashboard"),
//               //       ],
//               //     ),
//               //   ),
//               // )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
