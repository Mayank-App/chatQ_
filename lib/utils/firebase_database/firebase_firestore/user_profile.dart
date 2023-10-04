import 'package:chat_application/utils/utils.dart';

import '../../../model/firebase_user_model/firebase_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileStore{
  static final databaseStore = FirebaseFirestore.instance.collection("user");

  Future setUserProfileDetail(FirebaseUserDetailModel  userDetailModel ) async {
   await databaseStore.doc(userDetailModel.uid).set(
      userDetailModel.toMap()
    ).then((value){
      Utils.toastMessage("Profile Data Store");
    }).onError((error, stackTrace) {
      Utils.toastMessage(error.toString());
    });
  }

  static Stream<List<FirebaseUserDetailModel>> getUsersProfile()
  {
    var datas = databaseStore.snapshots();
    return datas.map((QuerySnapshot<Map<String, dynamic>> snapshot){
      final List<FirebaseUserDetailModel> list = [];
      for(final DocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs){
        final Map<String, dynamic> data = doc.data()!;
        list.add(FirebaseUserDetailModel.fromJson(data));
      }
      return list;
    });
  }

  static Stream<FirebaseUserDetailModel?> getCurrentUserProfile(String currentUserUID) {
    final firestoreStream = databaseStore.doc(currentUserUID).snapshots();
    return firestoreStream.map((DocumentSnapshot<Map<String, dynamic>> snapshot) {
      if (snapshot.exists) {
        final Map<String, dynamic> data = snapshot.data()!;
        return FirebaseUserDetailModel.fromJson(data);
      } else {
        // If the user profile document doesn't exist, return null.
        return null;
      }
    });
  }
}
