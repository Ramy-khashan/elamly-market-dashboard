// import 'package:flutter/material.dart';

// import '../constant/constants.dart';
// import 'orders_widget.dart';

// class OrdersList extends StatelessWidget {
//   const OrdersList({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(defaultPadding),
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         borderRadius: const BorderRadius.all(Radius.circular(10)),
//       ),
//       child: ListView.separated(
//           // physics: const NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           itemCount: 10,
//           separatorBuilder: (context, index) => const Divider(
//                 thickness: 2,
//               ),
//           itemBuilder: (ctx, index) {
//             return const OrdersWidget();
//           }),
//     );
//   }
// }
