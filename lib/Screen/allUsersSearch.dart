import 'package:chatapp/Controller/data%20check.dart';
import 'package:chatapp/Controller/messagetablescontroller.dart';
import 'package:chatapp/Model/NavigatorBAR.dart';
import 'package:chatapp/Model/searchList_model.dart';
import 'package:chatapp/Constant/LoadingPage.dart';
import 'package:chatapp/Screen/allUsersMessagestables.dart';
import 'package:chatapp/Screen/file_searching.dart';
import 'package:chatapp/Model/profilimage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../Controller/internetconnection.dart';
import '../Controller/searchbarcontroller.dart';
import '../Controller/sendMessagesController.dart';

class AllUsersSearch extends StatefulWidget {
  const AllUsersSearch({super.key});

  @override
  State<AllUsersSearch> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AllUsersSearch> {
  RxList _foundUsers = [].obs;
  RxBool searchCheck = false.obs;
  final _search = Get.put(SearchControll());
  bool wasCleared = false;
  RxString value1 = ''.obs;
  @override
  void initState() {
    super.initState();
    _foundUsers = _search.allUsers!;
  }

  void runFilter(String enterKeyword) {
    List result = [];
    if (enterKeyword.isEmpty) {
      result = _search.allUsers!.value;
      if (enterKeyword != '') {
        _search.item();
      }
    } else {
      result = _search.allUsers!
          .where((p0) =>
              p0['name'].toLowerCase().contains(enterKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundUsers.value = result;
    });
  }

  Widget build(BuildContext context) {
    setState(() {
      InternetService().connectionCheck();
    });
    final _ctrl = Get.put(DataCheck());
    final _search = Get.put(SearchControll());
    final _messagesGroups = Get.put(MessageTables());
    final _messagesController = Get.put(MessageController());
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, 
      statusBarIconBrightness: Brightness.dark, 
));

    _ctrl.check();
    return DoubleTapToExit(
      snackBar: SnackBar(
        content: Text("Press the back button twice to exit the application"),
        ),
      child: Scaffold(
          floatingActionButton: NavigatorBAR(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          body: SafeArea(
            child: Obx(
              () => Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("lib/Assets/CARDS (1).png"),
                        fit: BoxFit.cover)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: Get.width - 20,
                      child: TextField(
                        
                        onTap: () {},
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            
                            focusedBorder: OutlineInputBorder(
                              
                              borderRadius: BorderRadius.circular(25),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              
                            ),
                            labelText: "Search",
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.white),
                            prefixIcon: Icon(Icons.search),
                            prefixIconColor: Colors.white),
                        cursorColor: Colors.white,
                        onChanged: (value) {
                          if (value != "") {
                            setState(() {
                              searchCheck.value = true;
                              value1.value = value;
                            });
                          }else if (value == ""){
                            setState(() {
                              searchCheck.value = false;
                            });
                            _search.item();
                          }
                          runFilter(value);
                        },
                      ),
                    ),
                    value1 == ''?FileSearching():searchCheck == true
                        ? _search.allUsers!.length > 0
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: _foundUsers.length,
                                  itemBuilder: (context, index) {
                                    var result_text = _foundUsers[index]['name'];
                                    var result_photo =
                                        _foundUsers[index]['profil-image'];                                  
                                    
                                    return GestureDetector(
                                        onTap: () async{
                                          if (FirebaseAuth.instance.currentUser!.uid != _foundUsers[index]['uid']){
                                             _messagesGroups.messageGroupAdd(_foundUsers[index]['uid'].toString(), _foundUsers[index]['uid'].toString());
                                            Get.to(AllusersMessagesTables(), transition: Transition.rightToLeft);
                                            FirebaseFirestore.instance.collection('users').doc(_foundUsers[index]['uid']).collection('message_groups').doc(FirebaseAuth.instance.currentUser!.uid).set({
                                                    "sender_uid" : _foundUsers[index]['uid'],
                                                    "receiver_uid" : FirebaseAuth.instance.currentUser!.uid
                                                  });
                                          }    
                                        },
                                        child: SearchModel(
                                            name: result_text,
                                            photo: result_photo,
                                            function: () {
                                              if (FirebaseAuth.instance.currentUser!.uid != _foundUsers[index]['uid']){
                                             _messagesGroups.messageGroupAdd(_foundUsers[index]['uid'].toString(), _foundUsers[index]['uid'].toString());
                                             Get.to(AllusersMessagesTables(), transition: Transition.rightToLeft);
                                             FirebaseFirestore.instance.collection('users').doc(_foundUsers[index]['uid']).collection('message_groups').doc(FirebaseAuth.instance.currentUser!.uid).set({
                                                    "sender_uid" : _foundUsers[index]['uid'],
                                                    "receiver_uid" : FirebaseAuth.instance.currentUser!.uid
                                                  });
                                             
                                          }    
                                          
                                              
                                              
                                                  
                                            },));
                                  },
                                ),
                              )
                            : Container()
                        : Container()
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
