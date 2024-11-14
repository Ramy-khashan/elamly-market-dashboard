import 'package:expandable_datatable/expandable_datatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/drawer_item.dart';
import '../../../core/widgets/head_title.dart';
import '../../../core/widgets/loading_item.dart';
import '../controller/category_cubit.dart';
import 'widgets/add_edit_category.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit(),
      child: Scaffold(
        appBar: AppBar(),
        drawer: const DrawerItem(),
        body: Column(
          children: [
            HeadTitleItem(
              title: "Categories",
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => const AddEditCategoryDilaog());
              },
            ),
            Expanded(
              child: BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
                  final controller = CategoryCubit.get(context);
                  return controller.isLoading
                      ? const LoadingItem()
                      : controller.isFailed
                          ? const Text("Failed To Get Categories",
                              style: TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.bold))
                          : controller.categoriesItems.isEmpty
                              ? const Center(
                                  child: Text(
                                  "No Categories Exist",
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                ))
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
                                    headerSortIconColor:
                                        const Color(0xFF6c59cf),
                                    paginationSelectedFillColor:
                                        const Color(0xFF6c59cf),
                                    paginationSelectedTextColor: Colors.white,
                                  ),
                                  child: ExpandableDataTable(
                                    headers: controller.headers,
                                    rows: controller.rows,
                                    multipleExpansion: false,
                                    isEditable: true,
                                    visibleColumnCount:
                                        controller.headers.length,
                                    renderEditDialog: (row, onSuccess) {
                                      return AddEditCategoryDilaog(
                                        category: controller.categoriesItems[
                                            controller.rows.indexOf(row)],
                                        isAddCategory: false,
                                      );
                                    },
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
