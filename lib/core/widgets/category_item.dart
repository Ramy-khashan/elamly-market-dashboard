import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'; 

 import '../utils/utils.dart';
import 'text_widget.dart';

class CategoryWidget extends StatelessWidget {
  final VoidCallback editCategory;
  final VoidCallback removeCategory;
  final String type;
  final QueryDocumentSnapshot<Map<String, dynamic>> item;
  const CategoryWidget({
    Key? key,
    required this.item,
    required this.editCategory,
    required this.removeCategory, required this.type,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final color = Utils(context).color;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: const Color.fromARGB(74, 96, 125, 139),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 3,
                        child: Center(
                          child: Image.network(
                          type=="ads"?  item.get("ads_image")!:item.get("category_image"),
                            fit: BoxFit.fill,
                            // width: screenWidth * 0.12,r
                          ),
                        ),
                      ),
                      PopupMenuButton(
                          itemBuilder: (context) => [
                    
                                PopupMenuItem(
                                  onTap: removeCategory,
                                  value: 2,
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ])
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextWidget(
                  text: item.get("title")!,
                  color: color,
                  textSize: 22,
                  isTitle: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
