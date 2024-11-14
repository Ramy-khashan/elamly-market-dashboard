// import 'package:flutter/material.dart';
 
// import '../../modules/all_order/view/all_orders_screen.dart';
// import '../../modules/all_products/view/all_products.dart';
// import '../../modules/main_screen.dart';
// import '../../modules/reports/view/report_screen.dart';
// import '../../modules/special_orders/view/special_orders_screen.dart';
// import 'text_widget.dart';

// class SideMenu extends StatelessWidget {
//   const SideMenu({
//     Key? key,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         children: [
//           DrawerHeader(
//             child: Image.asset(
//               "assets/images/zezo.jpg",
//               fit: BoxFit.fill,
//             ),
//           ),
//           DrawerListTile(
//             title: "Main",
//             press: () {
//               Navigator.of(context).pushReplacement(
//                 MaterialPageRoute(
//                   builder: (context) => const MainScreen(),
//                 ),
//               );
//             },
//             icon: Icons.home_filled,
//           ),
//           DrawerListTile(
//             title: "View all products",
//             press: () {
//               Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const AllProductsScreen()));
//             },
//             icon: Icons.store,
//           ),
//           DrawerListTile(
//             title: "View all orders",
//             press: () {
//               Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const AllOrdersScreen()));
//             },
//             icon: Icons.shopping_bag,
//           ), DrawerListTile(
//             title: "Special Orders",
//             press: () {
//               Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const SpecialOrdersScreen()));
//             },
//                       icon: Icons.shopping_bag,

//           ),
//           DrawerListTile(
//             title: "View all Reports",
//             press: () {
//               Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const ReportScreen()));
//             },
//             icon: Icons.report,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class DrawerListTile extends StatelessWidget {
//   const DrawerListTile({
//     Key? key,
//     // For selecting those three line once press "Command+D"
//     required this.title,
//     required this.press,
//     required this.icon,
//   }) : super(key: key);

//   final String title;
//   final VoidCallback press;
//   final IconData icon;
//   @override
//   Widget build(BuildContext context) {
//     final color = Colors.black;

//     return ListTile(
//         onTap: press,
//         horizontalTitleGap: 0.0,
//         leading: Icon(
//           icon,
//           size: 18,
//         ),
//         title: TextWidget(
//           text: title,
//           color: color,
//         ));
//   }
// }
