import 'package:elamlymarket_dashboard/core/widgets/loading_item.dart';
import 'package:expandable_datatable/expandable_datatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/drawer_item.dart';
import '../controller/report_cubit.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportCubit()..getReports(),
      child: Scaffold(
        drawer: const DrawerItem(),
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Reports',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
              ),
            ),
            Expanded(
              child: BlocBuilder<ReportCubit, ReportState>(
                builder: (context, state) {
                  final controller = ReportCubit.get(context);
                  return controller.isLoading
                      ? const LoadingItem()
                      :  controller.reportstems.isEmpty?const Center(child: 
                      Text(
                      "No Reports Exists",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic),
                                      ),):ExpandableTheme(
                          data: ExpandableThemeData(
                            context,
                            contentPadding: const EdgeInsets.all(20),
                            expandedBorderColor: Colors.transparent,
                            paginationSize: 48,
                            headerHeight: 56,
                            headerColor: Colors.grey.shade300,
                            headerBorder: const BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            rowBorder: const BorderSide(
                              color: Colors.black,
                              width: 0.3,
                            ),
                            headerTextMaxLines: 4,
                            headerSortIconColor: const Color(0xFF6c59cf),
                            paginationSelectedFillColor:
                                const Color(0xFF6c59cf),
                            paginationSelectedTextColor: Colors.white,
                          ),
                          child: ExpandableDataTable(
                            headers: controller.headers,
                            rows: controller.rows,
                            multipleExpansion: true,
                            isEditable: false,
                            onRowChanged: (newRow) {
                              debugPrint(newRow.cells[01].value);
                            },
                            onPageChanged: (page) {
                              debugPrint(page.toString());
                            },
                            visibleColumnCount:
                                MediaQuery.of(context).size.width > 500
                                    ? controller.headers.length
                                    : 3,
                          ),
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
