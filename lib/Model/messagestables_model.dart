import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:chatapp/Controller/UserData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MessageTablesModel extends StatelessWidget {
  final photo;
  final name;
  final small_message;
  final void Function() function;
  const MessageTablesModel(
      {
      @required this.photo,
      @required this.name,
      required this.function,
      @required this.small_message});

  @override
  Widget build(BuildContext context) {
    final userData = Get.put(UserData());
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          BlurryContainer(
            width: Get.width - 10,
            height: 100,
            elevation: 35,
            blur: 5,
            
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                    children: [
                      SizedBox(
                        width: 7,
                      ),
                      Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(photo.toString()),
                                fit: BoxFit.cover),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: Colors.black, blurRadius: 80)
                            ]),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                            shadows: [
                              BoxShadow(color: Colors.black, blurRadius: 80)
                            ]),
                      ),
                    ],
                  ),
                  Text(small_message, style: TextStyle(fontSize: 16, ),)],
                ),
                IconButton(onPressed: function, icon: Icon(Icons.send_rounded, color: Colors.white,))
              ],
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
