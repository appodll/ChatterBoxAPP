import 'dart:io';
import 'package:chatapp/Controller/data%20check.dart';
import 'package:chatapp/Constant/LoadingPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<ProfilPage> {
  RxBool loading = false.obs;
  File? selectimage;
  Future<void> getImage()async{
    loading.value = true;
    final picker = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picker != null){
      selectimage = File(picker.path);
      var filename = selectimage?.path.toString().split("/").last;
      var path = "pp/${FirebaseAuth.instance.currentUser!.uid}/${filename}";
      final strogeRef = FirebaseStorage.instance.ref().child(path);
      if (selectimage != null){
        await strogeRef.putFile(selectimage!);
      }
      var url = await FirebaseStorage.instance.ref(path).getDownloadURL();
      final usercollection = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);
      setState(() {
        usercollection.update({
          "profil-image" : url??''
        });
        
      });
    }
    loading.value = false;
  }
  @override

  Widget build(BuildContext context) {
    final _ctrl = Get.put(DataCheck());
    _ctrl.check();
    return Obx(
        () => loading.value == true?SizedBox(height: 80,width: 80,child: Indicator()):Center(
            child: IconButton(
                onPressed: () async{
                  getImage();
                },
                icon: Container(
                  height: 260,
                  width: 260,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.202),blurRadius: 100,)
                    ],
                    image: DecorationImage(image: NetworkImage(_ctrl.profil_image.value),fit: BoxFit.cover)
                  ),
                )
                )),
      );
  }
}
