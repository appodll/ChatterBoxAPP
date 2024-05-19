import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi{
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNofitication()async{
    await _firebaseMessaging.requestPermission();

    final token = await _firebaseMessaging.getToken();
    print(token);
  }
}