import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SearchModel extends StatelessWidget {
  final name;
  final photo;
  final void Function() function;
  const SearchModel({super.key, @required this.name, @required this.photo, required this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 10,),
          BlurryContainer(
            width: Get.width - 10,
            height: 80,
            elevation: 50,
            blur: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
              children: [
                SizedBox(width: 7,),
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(photo.toString()),fit: BoxFit.cover),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 80
                      )
                    ]
                  ),
                ),
                SizedBox(width: 15,),
                Text(name, style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                  shadows: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 80
                    )
                  ]
                ),),
                
              ],
                         ),
                         IconButton(onPressed: function, icon: Icon(Icons.add_comment_rounded, size: 30,color: Colors.white,))],
            ),
          ),
        SizedBox(height: 10,)
        ],
      ),
    );
  }
}