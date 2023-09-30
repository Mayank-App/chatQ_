import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../model/firebase_user_model/firebase_chat_user_model.dart';
import '../model/firebase_user_model/firebase_user_model.dart';
import '../utils/firebase_database/firebase_firestore/chat_user.dart';
import '../utils/firebase_database/firebase_firestore/user_profile.dart';

class ChatRoomScreenProvider extends ChangeNotifier {
  final writeController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    writeController.dispose();
  }

  final writeFocusNode = FocusNode();
  final _auth = FirebaseAuth.instance;

  sendMessage(String receiverId) {
    if (writeController.text
        .toString()
        .isNotEmpty) {
      String time = DateTime.now().toString();
      ChatUserStore().sendMessage(_auth.currentUser!.uid,
          receiverId, FirebaseChatUserModel(
              message: writeController.text.toString().trim(),
              senderUID: _auth.currentUser!.uid.toString().trim(),
              time: time,
              receiverUID: receiverId,
              chatID: time,
              status: "u"));
      writeController.clear();
    }
    writeController.clear();
  }
}

