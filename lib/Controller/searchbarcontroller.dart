import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SearchControll{
  RxList? allUsers = [].obs; 
  var usercollection = FirebaseFirestore.instance.collection("users");
  void item()async{
    QuerySnapshot querySnapshot = await usercollection.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    allUsers?.value = allData;
  }
  

  SearchControll(){
    item();
  }
}