import 'package:expandable_datatable/expandable_datatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/drawer_item.dart';
import '../../../core/widgets/head_title.dart';
import '../../../core/widgets/loading_item.dart';
import '../controller/admins_cubit.dart';
import 'widgets/add_edit_admin.dart';

class AdminsScreen extends StatelessWidget {
  const AdminsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdminsCubit>.value(
      value: BlocProvider.of<AdminsCubit>(context)..getAdmins(),
      child: Scaffold(
        drawer: const DrawerItem(),
        appBar: AppBar(),
        body: BlocBuilder<AdminsCubit, AdminsState>(
          builder: (context, state) {
            final controller = AdminsCubit.get(context);
            return Column(
              children: [
                HeadTitleItem(
                  title: "Admins",
                  onTap: () {
                     showDialog(
                    context: context,
                    builder: (context) => const AddEditAdmin());
                   
                  },
                ),
                Expanded(
                  child: controller.isLoading
                      ? const LoadingItem()
                      : controller.admins.isEmpty
                          ? const Center(
                              child: Text("No admins exist",
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold)),
                            )
                          : ExpandableTheme(
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
                            ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
