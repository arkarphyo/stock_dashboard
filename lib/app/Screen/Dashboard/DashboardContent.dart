import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:stock_dashboard/app/Config/AppConstant.dart';
import 'package:stock_dashboard/app/Screen/MainScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../Utils/Widgets/PieChartData.dart';

class Dashboard {
  Widget dashboardContent(BuildContext context, BoxConstraints constraints,
      DashboardController controller) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: kSpacing),
          controller.responsiveDesktop
              ? BuildHeader(controller.contentHeader)
              : BuildHeader(controller.contentHeader,
                  onPressedMenu: () => controller.openDrawer()),
          const SizedBox(height: kSpacing / 3),
          const Divider(thickness: 1),
          Column(
            children: [
              Flex(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                clipBehavior: Clip.antiAlias,
                direction: controller.responsiveMobile
                    ? Axis.vertical
                    : Axis.horizontal,
                children: [
                  controller.responsiveMobile
                      ? SizedBox(child: itemProcessCountPieChart())
                      : Flexible(
                          fit: FlexFit.loose,
                          child: itemProcessCountPieChart()),
                  controller.responsiveMobile
                      ? SizedBox(
                          child: departmentProcessCountPieChart(),
                        )
                      : Flexible(
                          fit: FlexFit.loose,
                          child: departmentProcessCountPieChart()),
                ],
              ),
              Flex(
                direction: Axis.vertical,
                children: [
                  FutureBuilder(
                      future: getFixAssets(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          //snapshot.data![0].forEach((key, val) => print(key));
                          //print(snapshot.data!);
                          return AspectRatio(
                            aspectRatio: 4 / 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: PlutoGrid(
                                  columns: columns,
                                  rows: rows,
                                  configuration: const PlutoGridConfiguration(
                                    scrollbar: PlutoGridScrollbarConfig(
                                      isAlwaysShown: true,
                                      scrollbarThickness: 8,
                                      scrollbarThicknessWhileDragging: 10,
                                    ),
                                    style: PlutoGridStyleConfig(
                                      enableGridBorderShadow: true,
                                    ),
                                  ),
                                  onChanged: (PlutoGridOnChangedEvent event) {
                                    print(event);
                                  },
                                  onLoaded: (PlutoGridOnLoadedEvent event) {
                                    print(event);
                                  }),
                            ),
                          );
                        } else {
                          return PlutoLoading();
                        }
                      }),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

SupabaseClient supabase = Supabase.instance.client;
Future<List<Map<String, dynamic>>> getFixAssets() async {
  List<Map<String, dynamic>> list = [];
  list = await supabase.from("users").select("*");
  print(list);
  return list;
}

List<PlutoColumn> columns = [
  /// Number Column definition
  PlutoColumn(
    title: 'No',
    field: 'no',
    type: PlutoColumnType.number(),
  ),

  /// Text Column definition
  PlutoColumn(
    title: 'Item',
    field: 'text_field',
    type: PlutoColumnType.text(),
  ),

  /// Select Column definition
  PlutoColumn(
    title: 'Department',
    field: 'select_field',
    type: PlutoColumnType.select(['Finance', 'Admin', 'M&E']),
  ),

  /// Datetime Column definition
  PlutoColumn(
    title: 'Date',
    field: 'date_field',
    type: PlutoColumnType.date(),
  ),

  /// Time Column definition
  PlutoColumn(
    title: 'Time',
    field: 'time_field',
    type: PlutoColumnType.time(),
  ),
];

List<PlutoRow> rows = [
  PlutoRow(
    cells: {
      'no': PlutoCell(value: 1),
      'text_field': PlutoCell(value: "ITEM NAME"),
      'select_field': PlutoCell(value: 'item1'),
      'date_field': PlutoCell(value: '2020-08-06'),
      'time_field': PlutoCell(value: '12:30'),
    },
  ),
  PlutoRow(
    cells: {
      'no': PlutoCell(value: 2),
      'text_field': PlutoCell(value: "ITEM NAME"),
      'select_field': PlutoCell(value: 'item2'),
      'date_field': PlutoCell(value: '2020-08-07'),
      'time_field': PlutoCell(value: '18:45'),
    },
  ),
  PlutoRow(
    cells: {
      'no': PlutoCell(value: 3),
      'text_field': PlutoCell(value: "ITEM NAME"),
      'select_field': PlutoCell(value: 'item3'),
      'date_field': PlutoCell(value: '2020-08-08'),
      'time_field': PlutoCell(value: '23:59'),
    },
  ),
];

PieChartData itemProcessCountPieChart() {
  return PieChartData(
    data: [
      {'domain': 'Damage', 'measure': 27},
      {'domain': 'Service', 'measure': 20},
      {'domain': 'Pending', 'measure': 15},
    ],
    fillColor: (pieData, index) {
      switch (pieData['domain']) {
        case 'Damage':
          return Colors.red;
        case 'Service':
          return Colors.blue;
        case 'Pending':
          return Colors.yellow;
      }
    },
    pieLabel: (pieData, index) =>
        "${pieData['domain']} - ${pieData['measure']}",
  );
}

PieChartData departmentProcessCountPieChart() {
  return PieChartData(
    data: [
      {'domain': 'Finance', 'measure': 27},
      {'domain': 'M&E', 'measure': 20},
      {'domain': 'Admin', 'measure': 15},
      {'domain': 'HR', 'measure': 4},
    ],
    fillColor: (pieData, index) {
      switch (pieData['domain']) {
        case 'Finance':
          return Colors.red;
        case 'M&E':
          return Colors.blue;
        case 'Admin':
          return Colors.yellow;
        case 'HR':
          return Colors.purple;
      }
    },
    pieLabel: (pieData, index) =>
        "${pieData['domain']} - ${pieData['measure']}",
    donutWidth: 30,
  );
}
