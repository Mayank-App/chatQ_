import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../model/firebase_user_model/firebase_chat_user_model.dart';
import '../model/firebase_user_model/firebase_user_model.dart';
import '../utils/firebase_database/firebase_firestore/chat_user.dart';
import '../utils/firebase_database/firebase_firestore/user_profile.dart';
import '../utils/firebase_database/firebase_storage/upload_image_firebase.dart';

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

  sendMessage(String receiver, {bool isImage = false, String imageUrl = ""}) {
    String mess = writeController.text.toString().trim();
    writeController.clear();
    DateTime now = DateTime.now();
    String time = now.toString();
    String chatID = now.millisecondsSinceEpoch.toString();
    if (mess.isNotEmpty || isImage) {
      ChatUserStore.sendMessage(FirebaseChatUserModel(
          message: !isImage?mess:"",
          senderUID: _auth.currentUser!.uid,
          time: time,
          receiverUID: receiver,
          chatID: chatID,
        //  readTime: "u",
          status: 0,
         // sentTime: time,
          visibleNo: 3,
          img: isImage?imageUrl:"",
      ));
    }
  }
  pickAndSendImage(String receiver) async {
    debugPrint("pick going to upload");
    await requestPermission(receiver);

  }
  String getChatID(String r, String s) {

    List<String> l = [r,s];
    l.sort();
    debugPrint("returning chat id");
    return l.join("ChatQ");

  }
  Future<void> requestPermission(String receiver) async {
    PermissionStatus status = await Permission.camera.request();

    // Check the permission status
    if (status.isGranted) {
      debugPrint("Permission Granted");
      await fetchImage();
      debugPrint("Image Fetched going to upload");
      await uploadImage(receiver);
      debugPrint("Image Uploaded");

    } else {
      debugPrint("Permission not granted in else");
      debugPrint("Going to fetch image in else");
      await fetchImage();
      debugPrint("Image fetched going to upload in else");
      await uploadImage(receiver);
      debugPrint("Going to upload in else");
      // openAppSettings();
    }
  }
  bool isUploaded = true;

  bool isPicked = false;

  uploadImage(String receiver) async {
    if (!isPicked) return;
    User user = _auth.currentUser!;
    String timeId = DateTime.now().microsecondsSinceEpoch.toString();

    String url = await FirebaseImageUpload.sendImageWithSenderAndReceiverChatIDAndTimeOnStorage(getChatID(receiver, user.uid.toString()), timeId, pickedImage);
    sendMessage(receiver, isImage: true, imageUrl: url);
    // await UsersChat.sendMessage(MessageModel(message: "", senderUID: user.uid, time: timeId, receiverUID: receiver, chatID: timeId, status: 0, sentTime: timeId, img: url)).then((value){
    // debugPrint("Success uploading image on database");
    //
    // }).onError((error, stackTrace){
    // debugPrint("Error while uploading image on database");
    // });
    isPicked = false;
    pickedImage = null;
  }
  File? pickedImage;
  fetchImage() async {
    try {
      XFile? pickImage = await ImagePicker().pickImage(
          source: ImageSource.gallery, maxHeight: 200, maxWidth: 300);

      if (pickImage == null) return;
      final tmpImage = File(pickImage.path);
      pickedImage = tmpImage;
      isPicked = true;
      debugPrint("image fetched $pickedImage");
    } on Exception catch (_)
    {}
  }
  Stream<List<FirebaseChatUserModel>> getAllMessage(String receiverUID)
  {
    var datas = ChatUserStore.getUsersMessage(receiverUID,_auth.currentUser!.uid);
    // datas.map((List<FirebaseChatUserModel> chatsList){
    //   for(var chat in chatsList){
    //     // debugPrint(user.imageUrl.toString());
    //     // if(chat.status < 2){
    //     //
    //     // }
    //   }
    // });
    return datas;
  }
}



