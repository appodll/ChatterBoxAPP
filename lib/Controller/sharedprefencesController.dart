import 'package:chatapp/Screen/allUsersSearch.dart';
import 'package:chatapp/Screen/login%20page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataSave{
  Future<void>save_data()async{
    final prefs = await SharedPreferences.getInstance();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    prefs.setString("UID",uid.toString());
  }
  Future<void>get_data()async{
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString("UID") != null && FirebaseAuth.instance.currentUser?.emailVerified == true){
      Get.off(AllUsersSearch());
    }else{
      Get.off(Login());
    }
  }
  Future<void>delete_data()async{
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("UID");
  }
}