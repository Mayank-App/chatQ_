import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_application/model/firebase_user_model/firebase_user_model.dart';
import 'package:chat_application/resources/app_color.dart';
import 'package:chat_application/utils/firebase_database/firebase_firestore/chat_user.dart';
import 'package:chat_application/view_model/chatroomScreenProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/firebase_user_model/firebase_chat_user_model.dart';

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
    final databaseStoreChat = FirebaseFirestore.instance.collection("chat-collections").doc(ChatUserStore.getChatRoomId(_auth.currentUser!.uid.toString(), widget.receiver.uid)).collection("messages").snapshots();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: false,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        },
          icon: Icon(Icons.arrow_back_ios_new_rounded,color: AppColors.blueAccent,size: 30,),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.receiver.imageUrl?? ""),
            ),
            SizedBox(width: 15,),
            Text(widget.receiver.name,style: TextStyle(color: AppColors.blueAccent,fontWeight: FontWeight.w600),),
          ],
        ),
      ),
       body: Padding(
         padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
         child: Consumer<ChatRoomScreenProvider>(builder: ( context,  value,  child) {
           return Column(
             children: [
               Expanded(
                   child: StreamBuilder<QuerySnapshot>(
                   stream: databaseStoreChat,
                   builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot)
                   {
                     if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
                       return const CircularProgressIndicator();
                     }
                     else if (snapshot.hasError) {
                       return const Text("Error");
                     }
                     else
                     {
                       return ListView.builder
                         (
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var doc = snapshot.data!.docs[index].data();
                              // debugPrint("Message:"+doc.toString());
                              FirebaseChatUserModel chat =
                                  FirebaseChatUserModel.fromJson(
                                      doc as Map<String, dynamic>);
                              bool isImage = chat.img!.isEmpty;
                              return Row(
                                mainAxisAlignment: chat.senderUID
                                            .toString() ==
                                        _auth.currentUser!.uid.toString()
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        chat.senderUID.toString() ==
                                                _auth.currentUser!.uid
                                                    .toString()
                                            ? CrossAxisAlignment.end
                                            : CrossAxisAlignment.start,
                                    children: [
                                      Card(
                                          color: AppColors.blackFade,
                                          child: Padding(
                                            padding: const EdgeInsets.all(
                                                10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                              children: [
                                                Container(
                                                    constraints:
                                                        BoxConstraints(
                                                            maxWidth:
                                                                270),
                                                   child: isImage
                                                        ? Text(
                                                            chat.message,
                                                            style: const TextStyle(
                                                                color: AppColors
                                                                    .white,
                                                                fontSize:
                                                                    16),
                                                          )
                                                        : CachedNetworkImage(imageUrl: chat.img.toString())),
                                              ],
                                            ),
                                          )),
                                      Row(
                                        children: [
                                          Text(chat.time
                                              .substring(11, 16)),
                                          if (chat.senderUID ==
                                              _auth.currentUser!.uid
                                                  .toString())
                                            Icon(Icons.check),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              );
                            });
                     }

                    }
               )),
               Row(
                 children: [
                   IconButton(onPressed:()
                   {
                      value.requestPermission(widget.receiver.uid);
                   },
                       icon: Icon(Icons.camera_alt_rounded,size: 35,)),
                   SizedBox(width: 10,),
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
                       backgroundColor: AppColors.blackFade,
                       child:InkWell(
                        onTap: (){
                          value.sendMessage(widget.receiver.uid);
                        },
                           child: Icon(Icons.send,color: AppColors.blueAccent,))
                   ),
                 ],
               ),

             ],

           );
         },)
       ),
     );

  }

  Widget fetchImage(url)
  {
    return Image.network(url, fit: BoxFit.fill,);
  }


}