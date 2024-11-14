// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';
// import 'package:syncfusion_flutter_core/theme.dart';

// import '../../modules/all_order/controller/all_orders_cubit.dart';
// import '../../modules/all_order/model/order_model.dart';
// import '../constant/app_colors.dart';

// class OrderTable extends StatefulWidget {
//   const OrderTable({Key? key, required this.controller, this.isAll})
//       : super(key: key);
//   final AllOrdersCubit controller;
//   final bool? isAll;

//   @override
//   ProuctsTableState createState() => ProuctsTableState();
// }

// class ProuctsTableState extends State<OrderTable> {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: SfDataGridTheme(
//           data: SfDataGridThemeData(),
//           child: SfDataGrid(
//             isScrollbarAlwaysShown: true,
//             horizontalScrollPhysics: const AlwaysScrollableScrollPhysics(),
//             columnWidthMode: ColumnWidthMode.auto,
//             source: widget.controller.orderDataSource!,
//             columns: <GridColumn>[
//               GridColumn(
//                   columnName: 'id',
//                   label: Container(
//                     padding: const EdgeInsets.all(4.0),
//                     alignment: Alignment.center,
//                     child: const AutoSizeText(
//                       'Order Id',
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
//                 columnName: 'name',
//                 width: 150,
//                 label: Container(
//                   padding: const EdgeInsets.all(4.0),
//                   alignment: Alignment.center,
//                   child: const AutoSizeText(
//                     'User Name',
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
//                   columnName: 'email',
//                   label: Container(
//                     padding: const EdgeInsets.all(4.0),
//                     alignment: Alignment.center,
//                     child: const AutoSizeText(
//                       'E-mail',
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
//                   width: 250,
//                   columnName: 'userId',
//                   label: Container(
//                     padding: const EdgeInsets.all(4.0),
//                     alignment: Alignment.center,
//                     child: const AutoSizeText(
//                       'User Id',
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
//                   columnName: 'phone',
//                   label: Container(
//                     padding: const EdgeInsets.all(4.0),
//                     alignment: Alignment.center,
//                     child: const AutoSizeText(
//                       'Phone Number',
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
//                   columnName: 'address',
//                   label: Container(
//                     padding: const EdgeInsets.all(4.0),
//                     alignment: Alignment.center,
//                     child: const AutoSizeText(
//                       'Address',
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
//                   columnName: 'city',
//                   label: Container(
//                     padding: const EdgeInsets.all(4.0),
//                     alignment: Alignment.center,
//                     child: const AutoSizeText(
//                       'City',
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
//                   columnName: 'street',
//                   label: Container(
//                     padding: const EdgeInsets.all(4.0),
//                     alignment: Alignment.center,
//                     child: const AutoSizeText(
//                       'Street;',
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
//                   columnName: 'building',
//                   label: Container(
//                     padding: const EdgeInsets.all(4.0),
//                     alignment: Alignment.center,
//                     child: const AutoSizeText(
//                       'Building Number',
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
//                   columnName: 'floor',
//                   label: Container(
//                     padding: const EdgeInsets.all(4.0),
//                     alignment: Alignment.center,
//                     child: const AutoSizeText(
//                       'Floor Number',
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
//                   columnName: 'apartment',
//                   label: Container(
//                     padding: const EdgeInsets.all(4.0),
//                     alignment: Alignment.center,
//                     child: const AutoSizeText(
//                       'Apartment',
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
//                   columnName: 'createdAt',
//                   label: Container(
//                     padding: const EdgeInsets.all(4.0),
//                     alignment: Alignment.center,
//                     child: const AutoSizeText(
//                       'created At',
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
//                   columnName: 'totalPrice',
//                   label: Container(
//                     padding: const EdgeInsets.all(4.0),
//                     alignment: Alignment.center,
//                     child: const AutoSizeText(
//                       'Total Price',
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
//                   columnName: 'payment',
//                   label: Container(
//                     padding: const EdgeInsets.all(4.0),
//                     alignment: Alignment.center,
//                     child: const AutoSizeText(
//                       'Payment',
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
//                   columnName: 'products',
//                   label: Container(
//                     padding: const EdgeInsets.all(4.0),
//                     alignment: Alignment.center,
//                     child: const AutoSizeText(
//                       'Products',
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
//               // GridColumn(
//               //     columnName: 'action1',
//               //     label: Container(
//               //       padding: const EdgeInsets.all(4.0),
//               //       alignment: Alignment.center,
//               //       child: const AutoSizeText(
//               //         'Images',
//               //         maxLines: 1,
//               //         maxFontSize: 16,
//               //         minFontSize: 8,
//               //         style: TextStyle(
//               //             fontFamily: "AvenirLTStd",
//               //             fontSize: 16,
//               //             color: AppColor.primaryColor,
//               //             fontWeight: FontWeight.bold),
//               //       ),
//               //     )),
//               // GridColumn(
//               //     columnName: 'action2',
//               //     label: Container(
//               //       padding: const EdgeInsets.all(4.0),
//               //       alignment: Alignment.center,
//               //       child: const AutoSizeText(
//               //         'Update',
//               //         maxLines: 1,
//               //         maxFontSize: 16,
//               //         minFontSize: 8,
//               //         style: TextStyle(
//               //             fontFamily: "AvenirLTStd",
//               //             fontSize: 16,
//               //             color: AppColor.primaryColor,
//               //             fontWeight: FontWeight.bold),
//               //       ),
//               //     )),
//             ],
//           )),
//     );
//   }
// }

// class OrderDataSource extends DataGridSource {
//   List<OrderModel> _paginatedProduct = [];

//   /// Creates the user data source class with required details.
//   OrderDataSource({required List<OrderModel> configStudentData}) {
//     _paginatedProduct = configStudentData;

//     _subSyndicateData = _paginatedProduct
//         .map<DataGridRow>((e) => DataGridRow(cells: [
//               DataGridCell<String>(columnName: 'id', value: e.orderId),
//               DataGridCell<String>(
//                   columnName: 'name',
//                   value: e.firstName.toString() + e.lastName.toString()),
//               DataGridCell<String>(columnName: 'email', value: e.email),
//               DataGridCell<String>(columnName: 'userId', value: e.userId),
//               DataGridCell<String>(columnName: 'phone', value: e.phoneNumber),
//               DataGridCell<String>(columnName: 'address', value: e.address),
//               DataGridCell<String>(columnName: 'city', value: e.city),
//               DataGridCell<String>(columnName: 'street', value: e.street),
//               DataGridCell<String>(columnName: 'building', value: e.building),
//               DataGridCell<String>(columnName: 'floor', value: e.floor),
//               DataGridCell<String>(columnName: 'apartment', value: e.apartment),
//               DataGridCell<String>(columnName: 'createdAt', value: e.createdAt),
//               DataGridCell<String>(
//                   columnName: 'totalPrice', value: e.totalPrice),
//               DataGridCell<String>(columnName: 'payment', value: e.payment),
//               const DataGridCell<String>(columnName: 'products', value: ""),
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
//           color: getRowBackgroundColor(),
//           alignment: Alignment.center,
//           padding: const EdgeInsets.all(4.0),
//           child: e.columnName == 'products'
//               ? ElevatedButton(onPressed: () {}, child: const Text("View"))
//               //  Image.network(e.value)
//               // : e.columnName == 'action1'
//               //     ? ViewImageContainer(
//               //         e: e,
//               //         product: _paginatedProduct[effectiveRows.indexOf(row)],
//               //       )
//               //     : e.columnName == 'action2'
//               //         ? UpdateContainer(
//               //             e: e,
//               //             product: _paginatedProduct[effectiveRows.indexOf(row)],
//               //           )
//               : SelectableText(
//                   e.value.toString(),
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontFamily: "AvenirLTStd",
//                     fontSize: 14,
//                     color: AppColor.greyTextColor,
//                   ),
//                 ));
//     }).toList());
//   }
// }

// // class UpdateContainer extends StatelessWidget {
// //   const UpdateContainer({Key? key, required this.product, required this.e})
// //       : super(key: key);
// //   final DataGridCell<dynamic> e;
// //   final OrderModel product;

// //   @override
// //   Widget build(BuildContext context) {
// //     return InkWell(
// //       onTap: () {
// //         showDialog(
// //           builder: (context) => Container(
// //             alignment: Alignment.center,
// //             child: Container(
// //                  height: 450,
// //                 width: 900,
// //                 color: Colors.white,
// //                 child: UpdateProduct(
// //                   product: product,
// //                 )),
// //           ),
// //           context: context,
// //         );
// //       },
// //       child: Container(
// //           padding: const EdgeInsets.all(4),
// //           width: 70,
// //           height: 35,
// //           decoration: BoxDecoration(
// //             color: AppColor.primaryColor,
// //             borderRadius: BorderRadius.circular(5),
// //           ),
// //           child: Center(
// //             child: Text(
// //               e.value.toString(),
// //               style: TextStyle(color: Colors.white),
// //             ),
// //           )),
// //     );
// //   }
// // }

// // class ViewImageContainer extends StatelessWidget {
// //   const ViewImageContainer({Key? key, required this.product, required this.e})
// //       : super(key: key);
// //   final DataGridCell<dynamic> e;
// //   final OrderModel product;

// //   @override
// //   Widget build(BuildContext context) {
// //     return InkWell(
// //       onTap: () {
// //         showDialog(
// //           builder: (context) => Container(
// //             alignment: Alignment.center,
// //             child: Container(
// //                 height: 450,
// //                 width: 800,
// //                 color: Colors.white,
// //                 child: ViewProductImagesDialog(
// //                   product: product,
// //                 )),
// //           ),
// //           context: context,
// //         );
// //       },
// //       child: Container(
// //           padding: const EdgeInsets.all(4),
// //           width: 70,
// //           height: 35,
// //           decoration: BoxDecoration(
// //             color: AppColor.primaryColor,
// //             borderRadius: BorderRadius.circular(5),
// //           ),
// //           child: Center(
// //             child: Text(
// //               e.value.toString(),
// //               style: TextStyle(color: Colors.white),
// //             ),
// //           )),
// //     );
// //   }
// // }
