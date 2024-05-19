import 'package:chatapp/Controller/sharedprefencesController.dart';
import 'package:chatapp/Screen/allUsersSearch.dart';
import 'package:chatapp/Screen/emailverfied.dart';
import 'package:chatapp/Screen/forgotpasswordpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Auth {
  final usercollection = FirebaseFirestore.instance.collection("users");
  RxBool loading = false.obs;
  Future<void> singup(
      {required String email,
      required String name,
      required String password}) async {
        loading.value = true;
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        await _register(email: email, name: name, password: password);
        await sendemail();
        Get.to(EmailVerfied());
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("OPS", e.message.toString());
    }
    loading.value = false;
  }

  Future<void> signin({required String email, required String password}) async {
    loading.value = true;
    try {
      final usercredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (usercredential.user != null &&
          FirebaseAuth.instance.currentUser!.emailVerified) {
        DataSave().save_data();
        Get.off(AllUsersSearch());
      }
      if (FirebaseAuth.instance.currentUser?.emailVerified == false){
        Get.snackbar("OPS", "Email Verified");
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("OPS", e.message.toString());
    }
    loading.value = false;
  }

  Future<void> _register(
      {required String email,
      required String name,
      required String password}) async {
    usercollection.doc(FirebaseAuth.instance.currentUser?.uid).set({
      "email": email,
      "name": name,
      "password": password,
      "profil-image":
          "https://static-00.iconduck.com/assets.00/profile-circle-icon-512x512-dt9lf8um.png",
      "uid": FirebaseAuth.instance.currentUser?.uid,
    });
  }

  Future<void> sendemail() async {
    loading.value = true;
    FirebaseAuth.instance.currentUser?.sendEmailVerification();
    loading.value = false;
  }

  Future<void>forgotpassword({required email})async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.off(ForgotPage());
    }on FirebaseAuthException catch(e){
      Get.snackbar("OPS", e.message.toString());
    }
    
  }
}
