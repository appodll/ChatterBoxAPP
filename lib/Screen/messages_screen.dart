import 'dart:async';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:chatapp/Constant/LoadingPage.dart';
import 'package:chatapp/Controller/LoginRegisterController.dart';
import 'package:chatapp/Controller/sendMessagesController.dart';
import 'package:chatapp/Controller/whereGetProfileController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../Controller/internetconnection.dart';

class MessagesScreen extends StatefulWidget {
  final photo;
  final name;
  final void Function()? function;
  final uid;
  const MessagesScreen(
      {super.key,
      @required this.photo,
      @required this.name,
      required this.function,
      required this.uid});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  final ScrollController _scrollController = ScrollController();
  

  Widget build(BuildContext context) {
    setState(() {
      InternetService().connectionCheck();
    });
    final _messagesController = Get.put(MessageController());
    final _controller = Get.put(RegisterController());
    return Obx(
      () => Scaffold(
        floatingActionButton: SafeArea(
          child: Container(
            padding: EdgeInsets.all(3),
            child: TextField(
              showCursor: true,
              controller: _controller.send_message_controller.value,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: widget.function,
                      icon: Icon(
                        Icons.send_rounded,
                        color: Colors.black,
                        size: 28,
                      )),
                  hintText: "Send Message...",
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 2, 60, 107))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 2, 46, 82)))),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SafeArea(
            child: Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("lib/Assets/message (1).png"),fit: BoxFit.cover, opacity: 0.8),
            
          ),
              child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(
              children: [
                BlurryContainer(
                  width: Get.width - 10,
                  height: 80,
                  elevation: 50,
                  blur: 5,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(widget.photo.toString()),
                                fit: BoxFit.cover),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: Colors.black, blurRadius: 80)
                            ]),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.name.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('message_groups').doc(widget.uid).snapshots(),
                    builder: (context, snapshot) {
                      ///////////////////////////////////////// En asagiya dusmesi ucun (Scroll) /////////////////////////////////////////////////////////////////////////////////////////////
                      WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_scrollController.hasClients) {
                _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
              }
                        });
                         ////////////////////////////////////////////////////////////////////
                      return ListView.builder(
                      controller: _scrollController,
                      itemCount: snapshot.data!.data()!['message'].length,
                      dragStartBehavior: DragStartBehavior.start,
                      itemBuilder: (context, index) {
                        Timestamp timestamp = snapshot.data!.data()!['message'][index]['time'];
                        DateTime dateTime = timestamp.toDate();
                        var messages = snapshot.data!.data()!['message'][index]['messages'];
                        return snapshot.data!.data()!['message'][index]['sender_id'] ==
                                FirebaseAuth.instance.currentUser!.uid
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 0,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            radius: 25,
                                            splashColor: Colors.black,
                                            onLongPress: (){
                                                  showDialog(
                                                    context: context, 
                                                    builder: (context) => SimpleDialog(
                                                      title: Text("Are you sure to delete the message?"),
                                                      children: [
                                                        TextButton(onPressed: (){
                                                          FirebaseFirestore.instance.collection('users')
                                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                                  .collection('message_groups').doc(widget.uid).update({
                                                    "message" : FieldValue.arrayRemove([
                                                      
                                                        snapshot.data!.data()!['message'][index]
                                                      
                                                    ])
                                                  });
                                                  Get.back();
                                                        }, child: Text("Delete for me", style: TextStyle(
                                                          color: Colors.black
                                                        ),)),
                                                        
                                                      ],
                                                    ),);
                                                },
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: Color.fromRGBO(78, 0, 196, 0.751),
                                              ),
                                                child: Center(
                                                  child: Text(
                                                    messages.toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                        fontSize: 17,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                )),
                                          ),
                                           SizedBox(
                                              height: 4,
                                            ),
                                          Text(
                                            dateTime.toString().substring(11,16),
                                            style: TextStyle(fontWeight: 
                                            FontWeight.w500),)
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              )
                            : Column(
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(25),
                                                color: Colors.white.withOpacity(0.8),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color.fromRGBO(0, 0, 0, 0.355),
                                                    blurRadius: 30,

                                                    )
                                                ]
                                              ),
                                              child: Text(
                                                messages.toString(),
                                                    
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromRGBO(78, 0, 196, 0.751),),
                                              )),
                                            SizedBox(
                                              height: 4,
                                            ),
                                          Text(
                                            dateTime.toString().substring(11,16),
                                            style: TextStyle(fontWeight: FontWeight.w500),)
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              );
                      },
                    );
                  
                    },
                    
                    ),
                ),
                Container(
                  height: 78,
                  color: Colors.transparent,
                )
              ],
                        ),
                      ),
            )),
      ),
    );
  }
}
