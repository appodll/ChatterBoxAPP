import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class MessageTables {
  RxList messages_tables = RxList();
  RxList user_tables = RxList();
  RxList allMessagesUsers = RxList();
  final messageGroupsCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('message_groups');
  var usercollection = FirebaseFirestore.instance.collection("users");

  Future<void> messageGroupAdd(String id, String doc_id) async {
    messageGroupsCollection.doc(doc_id).set({
      "sender_uid": FirebaseAuth.instance.currentUser!.uid,
      "receiver_uid": id,
      "message" : [
        
      ]
    });
  }

  Future<void> getMessagestables() async {
    
    QuerySnapshot querySnapshot = await usercollection.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    user_tables.value = allData;
    /////////////////////////////////////////////////////////////////////
    QuerySnapshot message_groups = await messageGroupsCollection.get();
    final allMessageGroups = message_groups.docs.map((e) => e.data()).toList();
    messages_tables.value = allMessageGroups;
    allMessagesUsers.value = [];
    /////////////////////////////////////////////////////////////////////
    for (var i = 0; i < messages_tables.length; i++) {
      for (var j = 0; j < user_tables.length; j++) {
        if (messages_tables[i]['receiver_uid'] == user_tables[j]['uid']) {
          allMessagesUsers.add(user_tables[j]);
        }
      }
    }
  }
}
