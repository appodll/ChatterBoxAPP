import 'package:chatapp/Controller/NofiticationController.dart';
import 'package:chatapp/Controller/searchbarcontroller.dart';
import 'package:chatapp/Screen/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNofitication();
  
  runApp(MAIN());
}

class MAIN extends StatelessWidget {
  const MAIN({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SPLASH(),
      debugShowCheckedModeBanner: false,
      title: "ChatAPP",
    );
  }
}
