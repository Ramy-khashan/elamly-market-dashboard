import 'package:elamlymarket_dashboard/core/widgets/buttons.dart';
import 'package:flutter/material.dart';

import '../constant/app_colors.dart';

class HeadTitleItem extends StatelessWidget {
  const HeadTitleItem({super.key, required this.title, required this.onTap});
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Text(title,style: const TextStyle(fontSize: 21,fontWeight: FontWeight.w700),),
          const Spacer(),
          ButtonsWidget(
              onPressed: onTap,
              text: "Add $title",
              icon: Icons.add,
              backgroundColor: AppColor.primaryColor)
        ],
      ),
    );
  }
}
