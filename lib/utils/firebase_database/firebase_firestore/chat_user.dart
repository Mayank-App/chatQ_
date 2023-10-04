import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../../../model/firebase_user_model/firebase_chat_user_model.dart';

class ChatUserStore {
  static final databaseStore = FirebaseFirestore.instance.collection("chat-collections");

     //  sendMessage(String senderId ,String receiverId ,FirebaseChatUserModel firebaseChatUserModel ) {
     //   String chatroomId = getChatRoomId(senderId, receiverId);
     //  databaseStore.doc("$chatroomId").collection("message").doc(firebaseChatUserModel.time).set(firebaseChatUserModel.toMap());
     //
     // }
     static String getChatRoomId(String senderId ,String receiverId){
       List ids = [senderId, receiverId];
       ids.sort();
       String join = ids.join("ChatQ");
       return join;
     }
  static Future<void> sendMessage(FirebaseChatUserModel message) async {
    final chatRoomId = getChatRoomId(message.senderUID, message.receiverUID);
    final messageCollection = databaseStore.doc(chatRoomId).collection("messages");
    messageCollection
        .doc(message.chatID)
        .set(message.toMap())
        .then((value) {
      debugPrint("message sent");
    })
        .onError((error, stackTrace) {
    });
  }

}