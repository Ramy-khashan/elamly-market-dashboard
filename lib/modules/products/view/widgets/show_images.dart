import 'package:elamlymarket_dashboard/main.dart';
import 'package:flutter/material.dart';

showProductImages({required List<String>? images}) {
  showDialog(
    context: MarketDashboard.navigatorKey.currentContext!,
    builder: (context) => AlertDialog(
      title: const Text(
        "Product Images",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
      ),
      content: SingleChildScrollView(
        child: Wrap(
          children: List.generate(
            images!.length,
            (index) => Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.network(images[index])),
          ),
        ),
      ),
    ),
  );
}
