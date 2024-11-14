import 'package:expandable_datatable/expandable_datatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/drawer_item.dart';
import '../../../core/widgets/head_title.dart';
import '../../../core/widgets/loading_item.dart';
import '../controller/product_cubit.dart';
import 'widgets/add_edit_product.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => ProductCubit()
        ..getProducts()
        ..getCategories(),
      child: Scaffold(
        appBar: AppBar(),
        drawer: const DrawerItem(),
        body: Column(
          children: [
            HeadTitleItem(
              title: "Products",
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddEditProductDilaog()));
              },
            ),
            Expanded(
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  final controller = ProductCubit.get(context);
                  return Center(
                    child: controller.isLoading
                        ? const LoadingItem()
                        : controller.isFailed
                            ? const Text("Failed To Get Products",
                                style: TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.bold))
                            : controller.productsItems.isEmpty
                                ? const Text("No Products Exist",
                                    style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold))
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
                                      multipleExpansion: true,
                                      isEditable: false,
                                      onRowChanged: (newRow) {
                                        debugPrint(newRow.cells[01].value);
                                      },
                                      onPageChanged: (page) {
                                        debugPrint(page.toString());
                                      },
                                      visibleColumnCount:
                                          MediaQuery.of(context).size.width >
                                                  500
                                              ? controller.headers.length
                                              : 3,
                                    ),
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
