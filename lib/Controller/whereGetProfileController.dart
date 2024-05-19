import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class WhereGet{
  RxString url = "".obs;
  Future<void> response(id)async{
    final userAbout = await FirebaseFirestore.instance.collection('users').doc(id).get();
    url.value = userAbout.data()!['profil-image'];
  }
}