import 'package:chat_application/model/firebase_user_model/firebase_user_model.dart';
import 'package:chat_application/resources/app_color.dart';
import 'package:chat_application/utils/firebase_database/firebase_firestore/chat_user.dart';
import 'package:chat_application/view_model/chatroomScreenProvider.dart';
import 'package:chat_application/view_model/homeScreenProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/firebase_user_model/firebase_chat_user_model.dart';
import '../utils/utils.dart';

class ChatRoomScreen extends StatefulWidget{

  FirebaseUserDetailModel receiver;
  ChatRoomScreen({super.key, required this.receiver});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final databaseStoreChat = FirebaseFirestore.instance.collection("chat-collections").doc(ChatUserStore.getChatRoomId(_auth.currentUser!.uid.toString(), widget.receiver.uid)).collection("message").snapshots();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueAccent,
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.receiver.imageUrl?? ""),
            ),
            SizedBox(width: 15,),
            Text(widget.receiver.name),
          ],
        ),
      ),
       body: Padding(
         padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
         child: Consumer<ChatRoomScreenProvider>(builder: ( context,  value,  child) {
           return Column(
             children: [
               Expanded(child: StreamBuilder<QuerySnapshot>(
                   stream: databaseStoreChat,
                   builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot) {
                     if (snapshot.connectionState == ConnectionState.waiting) {
                       return const CircularProgressIndicator();
                     }
                     if (snapshot.hasError) {
                       return const Text("Error");
                     }

                     return ListView.builder(
                         itemCount: snapshot.data!.docs.length,
                         itemBuilder: (context, index) {
                           var doc = snapshot.data!.docs[index].data();
                           // debugPrint("Message:"+doc.toString());
                           var chat = FirebaseChatUserModel.fromJson(doc as Map<String, dynamic>);
                           return Row(
                             mainAxisAlignment: chat.senderUID.toString() == _auth.currentUser!.uid.toString()
                                 ? MainAxisAlignment.end
                                 : MainAxisAlignment.start,
                             children: [
                               Column(
                                 crossAxisAlignment: chat.senderUID.toString()==_auth.currentUser!.uid.toString()?CrossAxisAlignment.end:CrossAxisAlignment.start,
                                 children: [
                                   Card(
                                    color: AppColors.blueAccent
                                    , child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child:
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(
                                            maxWidth: 270
                                          )
                                            ,child: Text(chat.message, style: const TextStyle(color: AppColors.white, fontSize: 16),)),
                                      ],
                                    ),

                                   )),
                                   Row(
                                     children: [
                                       Text(chat.time.substring(11, 16)),
                                       if(chat.senderUID== _auth.currentUser!.uid.toString())
                                           Icon(Icons.check),

                                     ],
                                   )
                                 ],
                               )
                             ],

                           );
                         }

                     );
                   }

               )),
               Row(
                 children: [
                   Expanded(
                     child: TextFormField(
                       controller: value.writeController,
                       focusNode: value.writeFocusNode,
                       keyboardType: TextInputType.text,
                       onFieldSubmitted: (val1){
                         // Utils.fieldFocusNode(context, value.writeFocusNode,value.emailFocus);
                         value.sendMessage(widget.receiver.uid);
                       },

                       decoration: InputDecoration(

                         hintText: 'Write here something...',
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(30),
                           borderSide: const BorderSide(
                             color: AppColors.black26,

                           ),
                         ),
                         focusedBorder:
                         OutlineInputBorder(
                             borderRadius: BorderRadius.circular(30),
                             borderSide: const BorderSide(
                                 color: AppColors.blueAccent,
                                 width: 2
                             )
                         ),

                       ),
                     ),
                   ),
                   const SizedBox(width: 20,),
                   CircleAvatar(
                       backgroundColor: Colors.blue,
                       child:InkWell(
                        onTap: (){
                          value.sendMessage(widget.receiver.uid);
                        },
                           child: Icon(Icons.send))
                   ),
                 ],
               ),

             ],

           );
         },)
       ),
     );
  }
}