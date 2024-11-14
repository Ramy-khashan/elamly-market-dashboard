// import 'package:cloud_firestore/cloud_firestore.dart'; 
// import 'package:flutter/material.dart';
// import '../../modules/all_products/model/product_model.dart';
// import '../../modules/main_screen.dart';
// import '../constant/constants.dart';
// import 'products_widget.dart';

// class ProductGridWidget extends StatelessWidget {
//   final List<ProductsModel> products;
//   const ProductGridWidget(
//       {Key? key,
//       this.crossAxisCount = 4,
//       this.childAspectRatio = 1,
//       this.isInMain = true,
//       required this.products})
//       : super(key: key);
//   final int crossAxisCount;
//   final double childAspectRatio;
//   final bool isInMain;
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//         physics: const NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         itemCount: products.length,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: crossAxisCount,
//           childAspectRatio: childAspectRatio,
//           crossAxisSpacing: defaultPadding,
//           mainAxisSpacing: defaultPadding,
//         ),
//         itemBuilder: (context, index) {
//           return ProductWidget(
//             product: products[index],
           
//             removeProduct: () {
//               FirebaseFirestore.instance
//                   .collection("product")
//                   .doc(products[index].productId)
//                   .delete()
//                   .then((value) {
//                 Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const MainScreen(),
//                     ),
//                     (route) => false);  
//               });
//             },
//           );
//         });
//   }
// }
