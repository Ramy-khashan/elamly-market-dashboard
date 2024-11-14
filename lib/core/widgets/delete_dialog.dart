import 'package:elamlymarket_dashboard/core/constant/app_colors.dart';
import 'package:elamlymarket_dashboard/core/widgets/buttons.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import 'responsive.dart';

deleteDialog({required Function() onDelete}) => Container(
      alignment: Alignment.center,
      child: SizedBox(
        width:
            Responsive.isDesktop(MarketDashboard.navigatorKey.currentContext!)
                ? 650
                : 400,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Are you sure you want to delete this item?",
                  style: TextStyle(fontSize: 21),
                ),
                SizedBox(
                    height: Responsive.isDesktop(
                            MarketDashboard.navigatorKey.currentContext!)
                        ? 60
                        : 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonsWidget(
                        onPressed: () {
                          Navigator.pop(
                              MarketDashboard.navigatorKey.currentContext!);
                        },
                        text: "Cancel",
                        icon: Icons.close_fullscreen_sharp,
                        backgroundColor: AppColor.primaryColor),
                    ButtonsWidget(
                        onPressed: onDelete,
                        text: "Delete",
                        icon: Icons.delete,
                        backgroundColor: AppColor.primaryColor)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
