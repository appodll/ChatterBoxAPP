import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:chatapp/Screen/login%20page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';


class ForgotPage extends StatelessWidget {
  const ForgotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("lib/Assets/indir (1).jpeg"), fit: BoxFit.cover)
        ),
        child: BlurryContainer(
          child: Column(
            children: [
              LottieBuilder.asset("lib/Assets/forgotpasword.json"),
              SizedBox(height: 75,),
              Text(
                "Check your email address.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 15,),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                    "You can change your password from the link we sent",
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
      ),
    
    );
  }
}