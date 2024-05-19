import 'package:chatapp/Controller/sharedprefencesController.dart';
import 'package:chatapp/Screen/login%20page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/searchbarcontroller.dart';

class SPLASH extends StatefulWidget {
  const SPLASH({super.key});

  @override
  State<SPLASH> createState() => _SPLASHState();
}

class _SPLASHState extends State<SPLASH> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5),(){
      DataSave().get_data();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("lib/Assets/Live Chat.gif"),
          SizedBox(height: 50,),
          Text("Welcome To ChatterBox", style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold
          ),)
        ],
      )
    );
  }
}