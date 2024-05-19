import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DataCheck{
  RxBool loading = false.obs;
  RxString status = "".obs;
  final usercollection = FirebaseFirestore.instance.collection("users");
  final statusCheckdb = FirebaseFirestore.instance.collection('users')
  .doc(FirebaseAuth.instance.currentUser!.uid).collection('message_groups');
  var profil_image = "https://static.vecteezy.com/system/resources/previews/021/079/672/non_2x/user-account-icon-for-your-design-only-free-png.png".obs;
  RxString name = "name".obs;
  Future<void>check()async{
    loading.value = true;
    final data = await usercollection.doc(FirebaseAuth.instance.currentUser?.uid).get();
    profil_image.value = data.data()?["profil-image"];
    name.value = data.data()?['name'];
    loading.value = false;
  }


  Future<void>checkStatus(id)async{
    final statusData = await statusCheckdb.doc(id).get();
    status.value = statusData.data()!['sender_uid'];
  }
}