import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({super.key, this.image});
  final String? image;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: SizedBox(
            height: 800,
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: InteractiveViewer(
                  child: Image.network(
                image ?? "",
                fit: BoxFit.fill,
              )),
            ),
          ),
        ),
        Positioned(
          top:30, 
          right: 20,
          child:   CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close,color: Colors.red,),
                  ),
          ),
        )
      ],
    );
  }
}
