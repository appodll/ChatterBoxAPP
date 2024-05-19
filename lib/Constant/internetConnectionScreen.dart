import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ConnectionScreen extends StatelessWidget {
  const ConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("lib/Assets/wifi.gif"),
          SizedBox(height: 20,),
          Text("Please connect to the Internet", style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25
          ),)
        ],
      )
    );
  }
}