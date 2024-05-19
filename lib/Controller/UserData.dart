import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserData{
  RxList message = [].obs;
  RxString name = "".obs;
  RxBool loading = false.obs;
  Future<void> responseData()async{
    final userData = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid)
    .collection('message_groups');
    QuerySnapshot user = await userData.get();
    message.value = user.docs.map((e) => e.data()).toList();
  }

  Future<void> userData()async{
    loading.value = false;
    final getUserData = await FirebaseFirestore.instance.collection("users")
    .doc(FirebaseAuth.instance.currentUser!.uid).get();
    name.value = getUserData.data()!['name'];
    loading.value = true;
  }
}