// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';
// import 'package:syncfusion_flutter_core/theme.dart';
 
// import '../constant/app_colors.dart';
// import '../utils/camil_case_method.dart';

// class SpecialOrderTable extends StatefulWidget {
//   const SpecialOrderTable({Key? key , this.isAll})
//       : super(key: key); 
//   final bool? isAll;

//   @override
//   SpecialOrderTableTableState createState() => SpecialOrderTableTableState();
// }

// class SpecialOrderTableTableState extends State<SpecialOrderTable> {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: SfDataGridTheme(
//           data: SfDataGridThemeData(),
//           child: SfDataGrid(
//             isScrollbarAlwaysShown: true,
//             horizontalScrollPhysics: const AlwaysScrollableScrollPhysics(),
//             columnWidthMode: ColumnWidthMode.auto,
//             source:SpecialOrderDataSource(configStudentData: []) ,
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
//                     'Name',
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
//                   columnName: 'phone',
//                   label: Container(
//                     padding: const EdgeInsets.all(4.0),
//                     alignment: Alignment.center,
//                     child: const AutoSizeText(
//                       'Phone',
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
//                   columnName: 'special_order',
//                   label: Container(
//                     padding: const EdgeInsets.all(4.0),
//                     alignment: Alignment.center,
//                     child: const AutoSizeText(
//                       'Special Order',
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
//                   width: 180,
//                   columnName: 'user_id',
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
//                   width: 120,
//                   columnName: 'status',
//                   label: Container(
//                     padding: const EdgeInsets.all(4.0),
//                     alignment: Alignment.center,
//                     child: const AutoSizeText(
//                       'Order Status',
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
//                   width: 120,
//                   columnName: 'action1',
//                   label: Container(
//                     padding: const EdgeInsets.all(4.0),
//                     alignment: Alignment.center,
//                     child: const AutoSizeText(
//                       'Accept',
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
//                   width: 120,
//                   columnName: 'action2',
//                   label: Container(
//                     padding: const EdgeInsets.all(4.0),
//                     alignment: Alignment.center,
//                     child: const AutoSizeText(
//                       'Rejected',
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

// class SpecialOrderDataSource extends DataGridSource {
//   List _paginatedProduct = [];

//   /// Creates the user data source class with required details.
//   SpecialOrderDataSource({required List configStudentData}) {
//     _paginatedProduct = configStudentData;

//     _subSyndicateData = _paginatedProduct
//         .map<DataGridRow>((e) => DataGridRow(cells: [
//               DataGridCell<String>(columnName: 'id', value: ""),
//               DataGridCell<String>(columnName: 'name', value:  ""),
//               DataGridCell<String>(columnName: 'email', value: ""),
//               DataGridCell<String>(columnName: 'phone', value:  ""),
//               DataGridCell<String>(columnName: 'address', value: ""),
//               DataGridCell<String>(
//                   columnName: 'description', value:  ""),
//               DataGridCell<String>(
//                   columnName: 'special_order', value:  ""),
//               DataGridCell<String>(columnName: 'user_id', value: ""),
//               DataGridCell<String>(
//                   columnName: 'status',
//                   value: camilCaseMethod( "")),
//               DataGridCell<String>(
//                   columnName:
//                       "",
//                   value:  ""),
//               DataGridCell<String>(
//                   columnName:
//                       "",
//                   value:  ""),
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
//           child: e.columnName == 'action1'
//               ? ElevatedButton(
//                   style:
//                       ElevatedButton.styleFrom(backgroundColor: Colors.green),
//                   onPressed: () async {
//                     await FirebaseFirestore.instance
//                         .collection("specialOrder")
//                         .doc(e.value)
//                         .update({"status": "accepted"});
                
//                   },
//                   child: const Text(
//                     "Accept",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 )
//               : e.columnName == ""
//                   ? SizedBox()
//                   : e.columnName == "action2"
//                       ? ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.red),
//                           onPressed: () async {
//                             await FirebaseFirestore.instance
//                                 .collection("specialOrder")
//                                 .doc(e.value)
//                                 .update({"status": "rejeced"});
//                             // Navigator.pushReplacement(
//                             //     MarketDashboard.navigatorKey.currentContext!,
//                             //     MaterialPageRoute(
//                             //         builder: (context) =>
//                             //             const SpecialOrdersScreen()));
//                           },
//                           child: const Text(
//                             "Reject",
//                             style: TextStyle(color: Colors.white),
//                           ))
//                       : SelectableText(
//                           e.value.toString(),
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontFamily: "AvenirLTStd",
//                             fontSize: 14,
//                             color: AppColor.greyTextColor,
//                           ),
//                         ));
//     }).toList());
//   }
// }
