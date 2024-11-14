// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';
// import 'package:syncfusion_flutter_core/theme.dart';

// import '../../modules/all_products/controller/all_product_cubit.dart';
// import '../../modules/all_products/model/product_model.dart';
// import '../../modules/all_products/view/widgets/update_product_dialog.dart';
// import '../../modules/all_products/view/widgets/view_images.dart';
// import '../constant/app_colors.dart';

// class ProductsTable extends StatefulWidget {
//   const ProductsTable({Key? key, required this.controller, this.isAll})
//       : super(key: key);
//   final AllProductCubit controller;
//   final bool? isAll;

//   @override
//   ProuctsTableState createState() => ProuctsTableState();
// }

// class ProuctsTableState extends State<ProductsTable> {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: SfDataGridTheme(
//           data: SfDataGridThemeData(),
//           child: SfDataGrid(
//             isScrollbarAlwaysShown: true, 
//             horizontalScrollPhysics: const AlwaysScrollableScrollPhysics(),
//             columnWidthMode: ColumnWidthMode.auto,
//             source: widget.controller.productsDataSource!,
//             columns: <GridColumn>[
//               GridColumn(
//                   columnName: 'id',
//                   label: Container(
//                     padding: const EdgeInsets.all(4.0),
//                     alignment: Alignment.center,
//                     child: const AutoSizeText(
//                       'Product Id',
//                       maxLines: 1,
//                       maxFontSize: 16,
//                       minFontSize: 8,
//                       style: TextStyle(
//                           fontFamily: "AvenirLTStd",
//                           fontSize: 16,
//                           color: AppColor.primaryColor,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   )),
//               GridColumn(
//                 columnName: 'title',
//                 width: 150,
//                 label: Container(
//                   padding: const EdgeInsets.all(4.0),
//                   alignment: Alignment.center,
//                   child: const AutoSizeText(
//                     'Title',
//                     maxLines: 1,
//                     maxFontSize: 16,
//                     minFontSize: 8,
//                     style: TextStyle(
//                         fontFamily: "AvenirLTStd",
//                         fontSize: 16,
//                         color: AppColor.primaryColor,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//               GridColumn(
//                   width: 250,
//                   columnName: 'description',
//                   label: Container(
//                     padding: const EdgeInsets.all(4.0),
//                     alignment: Alignment.center,
//                     child: const AutoSizeText(
//                       'Description',
//                       maxLines: 1,
//                       maxFontSize: 16,
//                       minFontSize: 8,
//                       style: TextStyle(
//                           fontFamily: "AvenirLTStd",
//                           fontSize: 16,
//                           color: AppColor.primaryColor,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   )),
//               GridColumn(
//                   columnName: 'price',
//                   label: Container(
//                     padding: const EdgeInsets.all(4.0),
//                     alignment: Alignment.center,
//                     child: const AutoSizeText(
//                       'Price',
//                       maxLines: 1,
//                       maxFontSize: 16,
//                       minFontSize: 8,
//                       style: TextStyle(
//                           fontFamily: "AvenirLTStd",
//                           fontSize: 16,
//                           color: AppColor.primaryColor,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   )),
//               GridColumn(
//                   columnName: 'is_on_sale',
//                   label: Container(
//                     padding: const EdgeInsets.all(4.0),
//                     alignment: Alignment.center,
//                     child: const AutoSizeText(
//                       'Is On Sale',
//                       maxLines: 1,
//                       maxFontSize: 16,
//                       minFontSize: 8,
//                       style: TextStyle(
//                           fontFamily: "AvenirLTStd",
//                           fontSize: 16,
//                           color: AppColor.primaryColor,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   )),
//               GridColumn(
//                   columnName: 'saleprice',
//                   label: Container(
//                     padding: const EdgeInsets.all(4.0),
//                     alignment: Alignment.center,
//                     child: const AutoSizeText(
//                       'Sale Price',
//                       maxLines: 1,
//                       maxFontSize: 16,
//                       minFontSize: 8,
//                       style: TextStyle(
//                           fontFamily: "AvenirLTStd",
//                           fontSize: 16,
//                           color: AppColor.primaryColor,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   )),
//               GridColumn(
//                   columnName: 'category',
//                   label: Container(
//                     padding: const EdgeInsets.all(4.0),
//                     alignment: Alignment.center,
//                     child: const AutoSizeText(
//                       'Category',
//                       maxLines: 1,
//                       maxFontSize: 16,
//                       minFontSize: 8,
//                       style: TextStyle(
//                           fontFamily: "AvenirLTStd",
//                           fontSize: 16,
//                           color: AppColor.primaryColor,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   )),
//               GridColumn(
//                   width: 80,
//                   columnName: 'image',
//                   label: Container(
//                     padding: const EdgeInsets.all(4.0),
//                     alignment: Alignment.center,
//                     child: const AutoSizeText(
//                       'Main Image',
//                       maxLines: 1,
//                       maxFontSize: 16,
//                       minFontSize: 8,
//                       style: TextStyle(
//                           fontFamily: "AvenirLTStd",
//                           fontSize: 16,
//                           color: AppColor.primaryColor,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   )),
//               GridColumn(
//                   columnName: 'action1',
//                   label: Container(
//                     padding: const EdgeInsets.all(4.0),
//                     alignment: Alignment.center,
//                     child: const AutoSizeText(
//                       'Images',
//                       maxLines: 1,
//                       maxFontSize: 16,
//                       minFontSize: 8,
//                       style: TextStyle(
//                           fontFamily: "AvenirLTStd",
//                           fontSize: 16,
//                           color: AppColor.primaryColor,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   )),
//               GridColumn(
//                   columnName: 'action2',
//                   label: Container(
//                     padding: const EdgeInsets.all(4.0),
//                     alignment: Alignment.center,
//                     child: const AutoSizeText(
//                       'Update',
//                       maxLines: 1,
//                       maxFontSize: 16,
//                       minFontSize: 8,
//                       style: TextStyle(
//                           fontFamily: "AvenirLTStd",
//                           fontSize: 16,
//                           color: AppColor.primaryColor,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   )),
//             ],
//           )),
//     );
//   }
// }

// class ProductsDataSource extends DataGridSource {
//   List<ProductsModel> _paginatedProduct = [];

//   /// Creates the user data source class with required details.
//   ProductsDataSource({required List<ProductsModel> configStudentData}) {
//     _paginatedProduct = configStudentData;

//     _subSyndicateData = _paginatedProduct
//         .map<DataGridRow>((e) => DataGridRow(cells: [
//               DataGridCell<String>(columnName: 'id', value: e.productId),
//               DataGridCell<String>(
//                   columnName: 'title', value: e.title.toString()),
//               DataGridCell<String>(
//                   columnName: 'description', value: e.description.toString()),
//               DataGridCell<String>(
//                   columnName: 'price', value: e.price.toString()),
//               DataGridCell<String>(
//                   columnName: 'is_on_sale', value: e.isOnSale.toString()),
//               DataGridCell<String>(
//                   columnName: 'saleprice', value: e.onSalePrice.toString()),
//               DataGridCell<String>(
//                   columnName: 'category', value: e.category.toString()),
//               DataGridCell<String>(
//                   columnName: 'image', value: e.mainImage.toString()),
//               const DataGridCell<String>(columnName: 'action1', value: 'View'),
//               const DataGridCell<String>(
//                   columnName: 'action2', value: 'Update'),
//             ]))
//         .toList();
//   }

//   List<DataGridRow> _subSyndicateData = [];

//   @override
//   List<DataGridRow> get rows => _subSyndicateData;

//   @override
//   DataGridRowAdapter buildRow(
//     DataGridRow row,
//   ) {
//     Color getRowBackgroundColor() {
//       final int index = effectiveRows.indexOf(row);
//       if (index % 2 != 1) {
//         return const Color.fromARGB(255, 245, 245, 245);
//       }

//       return Colors.transparent;
//     }

//     return DataGridRowAdapter(
//         cells: row.getCells().map<Widget>((e) {
//       return Container(
//         color: getRowBackgroundColor(),
//         alignment: Alignment.center,
//         padding: const EdgeInsets.all(4.0),
//         child: e.columnName == 'image'
//             ? Image.network(e.value)
//             : e.columnName == 'action1'
//                 ? ViewImageContainer(
//                     e: e,
//                     product: _paginatedProduct[effectiveRows.indexOf(row)],
//                   )
//                 : e.columnName == 'action2'
//                     ? UpdateContainer(
//                         e: e,
//                         product: _paginatedProduct[effectiveRows.indexOf(row)],
//                       )
//                     : AutoSizeText(
//                         e.value.toString(),
//                         maxLines: (e.columnName == 'description') ? 6 : 1,
//                         maxFontSize: 16,
//                         minFontSize: 10,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontFamily: "AvenirLTStd",
//                           fontSize: 14,
//                           color: AppColor.greyTextColor,
//                         ),
//                       ),
//       );
//     }).toList());
//   }
// }

// class UpdateContainer extends StatelessWidget {
//   const UpdateContainer({Key? key, required this.product, required this.e})
//       : super(key: key);
//   final DataGridCell<dynamic> e;
//   final ProductsModel product;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         showDialog(
//           builder: (context) => Container(
//             alignment: Alignment.center,
//             child: Container(
//                  height: 650,
//                 width: 900,
//                 color: Colors.white,
//                 child: UpdateProduct(
//                   product: product,
//                 )),
//           ),
//           context: context,
//         );
//       },
//       child: Container(
//           padding: const EdgeInsets.all(4),
//           width: 70,
//           height: 35,
//           decoration: BoxDecoration(
//             color: AppColor.primaryColor,
//             borderRadius: BorderRadius.circular(5),
//           ),
//           child: Center(
//             child: Text(
//               e.value.toString(),
//               style: TextStyle(color: Colors.white),
//             ),
//           )),
//     );
//   }
// }

// class ViewImageContainer extends StatelessWidget {
//   const ViewImageContainer({Key? key, required this.product, required this.e})
//       : super(key: key);
//   final DataGridCell<dynamic> e;
//   final ProductsModel product;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         showDialog(
//           builder: (context) => Container(
//             alignment: Alignment.center,
//             child: Container(
//                 height:450,
//                 width: 800,
//                 color: Colors.white,
//                 child: ViewProductImagesDialog(
//                   product: product,
//                 )),
//           ),
//           context: context,
//         );
//       },
//       child: Container(
//           padding: const EdgeInsets.all(4),
//           width: 70,
//           height: 35,
//           decoration: BoxDecoration(
//             color: AppColor.primaryColor,
//             borderRadius: BorderRadius.circular(5),
//           ),
//           child: Center(
//             child: Text(
//               e.value.toString(),
//               style: TextStyle(color: Colors.white),
//             ),
//           )),
//     );
//   }
// }
