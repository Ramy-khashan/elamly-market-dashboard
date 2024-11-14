// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// import '../../modules/add_ads/view/add_ads.dart';
// import '../../modules/category/view/category_screen.dart';
//  import '../constant/constants.dart';
// import 'category_item.dart';

// class CategoryGridWidget extends StatelessWidget {
//   final List<QueryDocumentSnapshot<Map<String, dynamic>>> items;
//   final String type;
//   const CategoryGridWidget(
//       {Key? key,
//       this.crossAxisCount = 4,
//       this.childAspectRatio = 1,
//       this.isInMain = true,
//       required this.items,
//       this.type = "category"})
//       : super(key: key);
//   final int crossAxisCount;
//   final double childAspectRatio;
//   final bool isInMain;
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//         physics: const NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         itemCount: items.length,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: crossAxisCount,
//           childAspectRatio: childAspectRatio,
//           crossAxisSpacing: defaultPadding,
//           mainAxisSpacing: defaultPadding,
//         ),
//         itemBuilder: (context, index) {
//           return CategoryWidget(
//             item: items[index],
//             type: type,
//             editCategory: () {
//               if (type == "ads") {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const UploadAdsForm(),
//                   ),
//                 );
//               } else {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const UploadCategoryForm(),
//                   ),
//                 );
//               }
//             },
//             removeCategory: () {
              
//                   if (type == "ads") {
//               FirebaseFirestore.instance
//                   .collection(type )
//                   .doc(items[index].get("ads_id"))
//                   .delete()
//                   .then((value) {
              
//               });}else{
//                      FirebaseFirestore.instance
//                   .collection(type)
//                   .doc(items[index].get("category_id"))
//                   .delete()
//                   .then((value) {
             
//               });
//               }
//             },
//           );
//         });
//   }
// }
