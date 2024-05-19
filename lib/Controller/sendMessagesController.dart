import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  var status = "".obs;
  var status_message = "".obs;
  RxList message_elemets = [].obs;
  RxBool loading = RxBool(false);
  Future<void> checkTablesAdd(id) async {
    final messageCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('message_groups')
        .doc(id);

    var querySnapshot = await messageCollection.get();
    status.value = querySnapshot.data()?['sender_uid'];
    print(status);
  }

  Future<void> readSendMessage(uid) async {
    loading.value = false;
    final sendMessagecollection = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('message_groups')
        .doc(uid);

    var messageSnapshot = await sendMessagecollection.get();
    message_elemets.value = messageSnapshot.data()!['message'];
    loading.value = true;
  }

  void receiveSendermessage(id,message) {
    readSendMessage(id);
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('message_groups')
        .doc(id)
        .update({
      "message": FieldValue.arrayUnion([
        {
          "messages": message,
          "sender_id": FirebaseAuth.instance.currentUser!.uid,
          "time": DateTime.now()
        }
      ]),
      "sender_uid": FirebaseAuth.instance.currentUser!.uid,
      "receiver_uid": id
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('message_groups')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "message": FieldValue.arrayUnion([
        {
          "messages": message,
          "sender_id": FirebaseAuth.instance.currentUser!.uid,
          "time": DateTime.now()
        }
      ]),
      "sender_uid": id,
      "receiver_uid": FirebaseAuth.instance.currentUser!.uid
    });
  }
}
