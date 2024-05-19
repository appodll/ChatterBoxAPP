import 'package:chatapp/Screen/login%20page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class EmailVerfied extends StatelessWidget {
  const EmailVerfied({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("lib/Assets/verified.jpeg"), fit: BoxFit.cover)
        ),
        child: Column(
          children: [
            LottieBuilder.asset("lib/Assets/email.json"),
            Text(
              "Verify your e-mail address",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                  "We just sent a verification link to your email. Please check your e-mail.",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: Colors.white),
                ),
            ),
            TextButton(onPressed: (){
              Get.off(Login());
            }, child: Text("Back to Login", style: TextStyle(
              color: Colors.purple[600],
              fontSize: 15
            ),))
          ],
        ),
      ),
    );
  }
}