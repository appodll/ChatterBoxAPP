import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Indicator extends StatelessWidget {
  const Indicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
          height: 150,
          width: 150,
          child: LottieBuilder.asset("lib/Assets/indicator.json")),
      );
  }
}