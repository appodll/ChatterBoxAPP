import 'dart:async';

import 'package:chatapp/Controller/LoginRegisterController.dart';
import 'package:chatapp/Controller/UserData.dart';
import 'package:chatapp/Controller/messagetablescontroller.dart';
import 'package:chatapp/Controller/sendMessagesController.dart';
import 'package:chatapp/Controller/whereGetProfileController.dart';
import 'package:chatapp/Model/NavigatorBAR.dart';
import 'package:chatapp/Model/messagestables_model.dart';
import 'package:chatapp/Model/searchList_model.dart';
import 'package:chatapp/Screen/messages_screen.dart';
import 'package:chatapp/Model/profilimage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../Constant/LoadingPage.dart';
import '../Controller/data check.dart';
import '../Controller/internetconnection.dart';

class AllusersMessagesTables extends StatefulWidget {
  const AllusersMessagesTables({super.key});

  @override
  State<AllusersMessagesTables> createState() => _AllusersMessagesTablesState();
}

class _AllusersMessagesTablesState extends State<AllusersMessagesTables> {
  Timer? _timer;
  @override


  Widget build(BuildContext context) {
    setState(() {
      InternetService().connectionCheck();
    });
    final _ctrl = Get.put(DataCheck());
    final _messagesGroups = Get.put(MessageTables());
    final _sendController = Get.put(RegisterController());
    final _messagesController = Get.put(MessageController());
    final userData = Get.put(UserData());
    _messagesGroups.getMessagestables();
    UserData().responseData();
    _timer?.cancel();
    return DoubleTapToExit(
      snackBar: SnackBar(
        content: Text("Press the back button twice to exit the application"),
        ),
      child: Scaffold(
        floatingActionButton: NavigatorBAR(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Obx(()=>
          SafeArea(
            child: Container(
              width: Get.width,
              height: Get.height,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("lib/Assets/TRANSACTIONS (1).png"),
                fit: BoxFit.cover, opacity: 0.95)
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: ProfilPage(),
                      ),
                      Text(
                        _ctrl.name.value,
                        style: TextStyle(
                          color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            shadows: [BoxShadow(color: Colors.black, blurRadius: 80)]),
                      ),
                      SizedBox(
                        width: Get.width / 1.7,
                      ),
                    ],
                  ),
                  _messagesGroups.messages_tables.length>0?Expanded(
                    child: ListView.builder(
                      itemCount: _messagesGroups.messages_tables.length,
                      itemBuilder: (context, index) {
                        
                        var name = _messagesGroups.allMessagesUsers[index]['name'];
                        var profil_image = _messagesGroups.allMessagesUsers[index]['profil-image'];
                        return GestureDetector(
                          onTap: ()async{
                            await _messagesController.readSendMessage(_messagesGroups.allMessagesUsers[index]['uid']);
                            Get.to(
                              MessagesScreen(uid: _messagesGroups.allMessagesUsers[index]['uid'],
                            photo: profil_image, name: name, function: () async {
                               if (_sendController.send_message_controller.value.text != ""){
                                _messagesController.receiveSendermessage(
                                _messagesGroups.allMessagesUsers[index]['uid'], 
                                _sendController.send_message_controller.value.text);
                              }
                              _sendController.send_message_controller.value.clear();
                            },));
                          },
                          child: MessageTablesModel(
                            small_message: "",
                            name: name, 
                            photo: profil_image, 
                            function: ()async{
                            await _messagesController.readSendMessage(_messagesGroups.allMessagesUsers[index]['uid']);
                            Get.to(
                              MessagesScreen(
                              uid: _messagesGroups.allMessagesUsers[index]['uid'],
                              photo: profil_image, 
                              name: name, 
                              function: () async {
                              if (_sendController.send_message_controller.value.text != ""){
                                _messagesController.receiveSendermessage(
                                _messagesGroups.allMessagesUsers[index]['uid'], 
                                _sendController.send_message_controller.value.text);
                              }
                              _sendController.send_message_controller.value.clear();
                              
                            },));
                          },));
                    },),
                  ):Center(
                    child: Text("No users"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
