import 'dart:ui';

import 'package:chatapp/Controller/Auth/AuthConroller.dart';
import 'package:chatapp/Controller/LoginRegisterController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ForGotPassw extends StatelessWidget {
  const ForGotPassw({super.key});
  
  @override
  Widget build(BuildContext context) {
    final _auth = Get.put(Auth());
    final _ctrl = Get.put(RegisterController());
    return Scaffold(
        body: Obx(()=>
          Stack(
                children: [
          Container(
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "lib/Assets/9d3e0d8c-041c-4964-b17f-362cd86bb18f.jpeg"),
                    fit: BoxFit.cover)),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5,
            ),
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: Get.width - 30,
                    child: TextField(
                      controller: _ctrl.forgot_password.value,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Color.fromRGBO(28, 31, 201, 1),
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(6, 9, 137, 0.8))),
                          prefixIcon: Icon(Icons.email),
                          prefixIconColor: Colors.white),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.only(right: Get.width/1.3),
                child: TextButton(
                    onPressed: () {
                      _auth.forgotpassword(email: _ctrl.forgot_password.value.text.toString());
                    },
                    child: Text(
                      "Next",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
              )
            ],
          )
                ],
              ),
        ));
  }
}
