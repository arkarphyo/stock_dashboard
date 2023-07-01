import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:stock_dashboard/app/Screen/MainScreen.dart';
import 'package:stock_dashboard/app/Utils/ResponsiveBuilder.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ManageStock {
  Widget content(BuildContext context, DashboardController controller) {
    DashboardController controller = Get.put(DashboardController());
    SupabaseClient supabase = Supabase.instance.client;
    Future<List<dynamic>> getFixAssetsData() async {
      var dataList = await supabase.from("items").select("*");
      return dataList;
    }

    List<PlutoColumn> columns = [];
    List<PlutoRow> rows = [];
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CustomIconButton(
                  label: "ADD ITEM",
                  icon: Icons.add,
                  onTap: () {},
                ),
                CustomIconButton(
                  label: "ADD Demage",
                  icon: Icons.water_damage_sharp,
                  onTap: () {},
                ),
                CustomIconButton(
                  label: "ADD Service",
                  icon: Icons.settings,
                  onTap: () {},
                ),
                CustomIconButton(
                  label: "Update Service",
                  icon: Icons.settings_accessibility,
                  onTap: () {},
                ),
              ],
            ),
          ),
          DataTableWidget(
              title: "Fix Asset Info",
              controller: controller,
              columns: columns,
              getFutureData: getFixAssetsData()),
        ],
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
  });
  final String label;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      child: Row(children: [Icon(icon), Text(label)]),
    );
  }
}

class DataTableWidget extends StatelessWidget {
  DataTableWidget({
    super.key,
    required this.controller,
    required this.columns,
    required this.getFutureData,
    required this.title,
  });

  final DashboardController controller;
  final List<PlutoColumn> columns;
  final Future<List<dynamic>> getFutureData;
  final String title;

  List<PlutoColumn> defaultColumns = [
    PlutoColumn(title: "No", field: "no", type: PlutoColumnType.number()),
    PlutoColumn(title: "Name", field: "name", type: PlutoColumnType.text()),
    PlutoColumn(
        title: "Description",
        field: "description",
        type: PlutoColumnType.text()),
    PlutoColumn(title: "Status", field: "status", type: PlutoColumnType.text()),
    PlutoColumn(
        title: "Department", field: "department", type: PlutoColumnType.text()),
    PlutoColumn(title: "Location", field: "no", type: PlutoColumnType.text()),
    PlutoColumn(
        title: "Modified", field: "modified", type: PlutoColumnType.date()),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        FutureBuilder(
          future: getFutureData,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                print(snapshot.data!.length);
                snapshot.data![0].forEach((key, value) {
                  print(key);
                  columns.add(PlutoColumn(
                      title: key, field: key, type: PlutoColumnType.text()));
                });
                return const Column(
                  children: [
                    Text(
                      "items found",
                    ),
                  ],
                );
              } else {
                defaultColumns;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // PlutoGrid(columns: defaultColumns, rows: [
                    //   PlutoRow(cells: {
                    //     "no": PlutoCell(value: 1),
                    //     "name": PlutoCell(value: "Laptop"),
                    //     "description": PlutoCell(value: "Acear i3 4Gen"),
                    //     "status": PlutoCell(value: "In Use"),
                    //     "department": PlutoCell(value: "Finance"),
                    //     "location": PlutoCell(value: "ND-001"),
                    //     "modified": PlutoCell(value: "2023-07-09")
                    //   })
                    // ]),
                    Container(
                      height: ResponsiveBuilder.isMobile(context) ? 300 : 500,
                      color: Colors.white54.withOpacity(0.5),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Icon(Icons.info),
                          ),
                          Center(child: const Text("Item not foucnt!")),
                        ],
                      ),
                    ),
                  ],
                );
              }
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return const PlutoLoading();
            }
          },
        ),
      ],
    );
  }
}
