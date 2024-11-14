// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import '../../main.dart';
// import '../constant/app_colors.dart';
// import 'text_field_shape.dart';

// import '../../modules/all_products/model/product_model.dart';
// import '../../modules/edit_product/view/edit_product.dart';
// import '../../modules/main_screen.dart';
// import '../utils/utils.dart';
// import 'text_widget.dart';

// class ProductWidget extends StatelessWidget {
//   final VoidCallback removeProduct;
//   final ProductsModel product;
//   const ProductWidget({
//     Key? key,
//     required this.product,
//     required this.removeProduct,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final color = Utils(context).color;
//     return Stack(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Material(
//             borderRadius: BorderRadius.circular(12),
//             color: AppColor.primaryColor,
//             child: InkWell(
//               borderRadius: BorderRadius.circular(12),
//               onTap: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => UploadProductFormScreen(
//                       product: product,
//                     ),
//                   ),
//                   // (route) => false
//                 );
//               },
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Flexible(
//                             flex: 3,
//                             child: Center(
//                               child: Image.network(
//                                 product.mainImage!,
//                                 fit: BoxFit.fill,
//                                 // width: screenWidth * 0.12,r
//                               ),
//                             ),
//                           ),
//                           StatefulBuilder(
//                               builder: (BuildContext context, setState) {
//                             return PopupMenuButton(
//                                 itemBuilder: (context) => [
//                                       PopupMenuItem(
//                                         onTap: () {
//                                           final onSale = TextEditingController(
//                                               text: product.onSalePrice);
//                                           showDialog(
//                                             context: MarketDashboard
//                                                 .navigatorKey.currentContext!,
//                                             builder: (context) {
//                                               return Container(
//                                                 height: 550,
//                                                 width: 1200,
//                                                 color: Colors.white,
//                                                 child: Column(
//                                                   children: [
//                                                     Row(
//                                                       mainAxisSize:
//                                                           MainAxisSize.min,
//                                                       children: [
//                                                         const Text(
//                                                           "On Sale",
//                                                           style: TextStyle(
//                                                             fontSize: 19,
//                                                             fontWeight:
//                                                                 FontWeight.w500,
//                                                           ),
//                                                         ),
//                                                         const SizedBox(
//                                                           width: 15,
//                                                         ),
//                                                         Switch.adaptive(
//                                                             value: product
//                                                                 .isOnSale!,
//                                                             onChanged: (value) {
//                                                               product.isOnSale =
//                                                                   !product
//                                                                       .isOnSale!;
//                                                             })
//                                                       ],
//                                                     ),
//                                                     TextFormFieldShape(
//                                                       title: "On Sale Price",
//                                                       controller: onSale,
//                                                       validate: (text) {
//                                                         if (text
//                                                             .toString()
//                                                             .isEmpty) {
//                                                           return "this field must be field";
//                                                         }
//                                                         return null;
//                                                       },
//                                                     ),
//                                                     Row(
//                                                       children: [
//                                                         TextButton(
//                                                             onPressed:
//                                                                 () async {
//                                                               await FirebaseFirestore
//                                                                   .instance
//                                                                   .collection(
//                                                                       'product')
//                                                                   .doc(product
//                                                                       .productId)
//                                                                   .update({
//                                                                 'is_on_sale':
//                                                                     product
//                                                                         .isOnSale!,
//                                                                 'on_sale_price':
//                                                                     onSale.text
//                                                               }).whenComplete(
//                                                                       () {
//                                                                 Navigator
//                                                                     .pushAndRemoveUntil(
//                                                                         MarketDashboard
//                                                                             .navigatorKey
//                                                                             .currentContext!,
//                                                                         MaterialPageRoute(
//                                                                           builder: (context) =>
//                                                                               const MainScreen(),
//                                                                         ),
//                                                                         (route) =>
//                                                                             false);
//                                                               });
//                                                             },
//                                                             child: const Text(
//                                                                 "Edit")),
//                                                         TextButton(
//                                                             onPressed: () {
//                                                               Navigator.pop(
//                                                                   MarketDashboard
//                                                                       .navigatorKey
//                                                                       .currentContext!);
//                                                             },
//                                                             child: const Text(
//                                                                 "Cancel")),
//                                                       ],
//                                                     )
//                                                   ],
//                                                 ),
//                                               );
//                                             },
//                                           );
//                                         },
//                                         value: 1,
//                                         child: const Text(
//                                           'Edit',
//                                           style: TextStyle(color: Colors.black),
//                                         ),
//                                       ),
//                                       PopupMenuItem(
//                                         onTap: removeProduct,
//                                         value: 1,
//                                         child: const Text(
//                                           'Delete',
//                                           style: TextStyle(color: Colors.red),
//                                         ),
//                                       ),
//                                     ]);
//                           })
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 2,
//                     ),
//                     Row(
//                       children: [
//                         TextWidget(
//                           text: product.isOnSale!
//                               ? product.onSalePrice!
//                               : product.price!,
//                           color: color,
//                           textSize: 18,
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Visibility(
//                             visible: product.isOnSale!,
//                             child: Text(
//                               product.price!,
//                               style: TextStyle(
//                                   decoration: TextDecoration.lineThrough,
//                                   color: color),
//                             )),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 2,
//                     ),
//                     TextWidget(
//                       text: product.title!,
//                       color: color,
//                       textSize: 24,
//                       isTitle: true,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
