import 'package:chat_application/model/firebase_user_model/firebase_chat_user_model.dart';
import 'package:flutter/material.dart';

import '../../../resources/app_color.dart';

class ChatInfoDialog extends StatelessWidget {
  const ChatInfoDialog({super.key, required this.messageModel});
  final FirebaseChatUserModel messageModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.blueAccent,
      ),
      constraints: const BoxConstraints(
          maxHeight: 405
      ),
      child: Column(
        children:
        [
          Text("Message: ${messageModel.message}"),
          Text("Status: ${messageModel.status}"),
          Text("ReadTime: ${messageModel.readTime}"),
          Text("DeliveredTime: ${messageModel.deliveredTime}"),
          Text("SentTime: ${messageModel.sentTime}"),
        ],
      ),
    );
  }
}
