import 'package:chat_application/model/firebase_user_model/firebase_user_model.dart';
import 'package:chat_application/utils/routes/routes_name.dart';
import 'package:chat_application/view_model/homeScreenProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  final databaseStore = FirebaseFirestore.instance.collection("user").snapshots();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<HomeScreenProvider>(
            builder: (context,value,child) {
              return
                Row(
                  children: [
                    Expanded(child: Text(value.currentUser.name ??"" )),
                    IconButton(onPressed:(){
                      value.logout(context);
                    }, icon: Icon(Icons.logout_outlined)),

                  ],
                );
            }
        ),
      ),
       body: Column(
         children: [
           Expanded(
               child:Consumer<HomeScreenProvider>(
                 builder: (context, value, child) {
                   return StreamBuilder<List<FirebaseUserDetailModel>>(
                     stream: value.getAllUsers(),
                     builder: (BuildContext context, AsyncSnapshot<List<FirebaseUserDetailModel>> snapshot) {
                       List<FirebaseUserDetailModel>? users = snapshot.data;
                     if (snapshot.connectionState == ConnectionState.waiting) {
                       return const CircularProgressIndicator();
                     }
                     if (snapshot.hasError) {
                       return const Text("Error");
                     }
                     return ListView.builder(
                       itemCount : users!.length,
                         itemExtent: 70,
                         itemBuilder: (context,index){
                         return ListTile(
                           onTap: (){
                               Navigator.pushNamed(context, RoutesName.chatRoomScreen,
                                   arguments: {"user":users![index]});
                           },
                             leading: CircleAvatar(
                             backgroundImage: NetworkImage(users![index].imageUrl?? ""),
                           ),
                           title: Text(users![index].name),
                           subtitle:Text(users![index].email),
                           trailing: Text(users![index].joinDate) ,
                         );
                     });
                   },);
                 }
               ) )
         ],
       ),
    );
  }
}

