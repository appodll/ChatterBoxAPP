import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class FileSearching extends StatelessWidget {
  const FileSearching({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(height: Get.height/4.5,),
          Center(
          child: SizedBox(
            height: 250,
            width: 250,
            child: LottieBuilder.asset("lib/Assets/file-searching.json",),
          )
        )
        ],
      ),
    );
  }
}