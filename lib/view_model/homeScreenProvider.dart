import 'package:chat_application/model/firebase_user_model/firebase_user_model.dart';
import 'package:chat_application/utils/routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import '../model/firebase_user_model/firebase_chat_user_model.dart';
import '../utils/firebase_database/firebase_firestore/chat_user.dart';
import '../utils/firebase_database/firebase_firestore/user_profile.dart';

class HomeScreenProvider extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  logout(BuildContext context) {
    _auth.signOut().then((value) {
      Navigator.pushNamed(context, RoutesName.signIn);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _isLogin = false;
    super.dispose();
  }

  late FirebaseUserDetailModel _currentUser;
  bool _isLogin = false;

  FirebaseUserDetailModel get currentUser {
    if (!_isLogin) {
      getCurentUserDetail();
      _isLogin = true;
    }
    return _currentUser;
  }


  getCurentUserDetail() {
    UserProfileStore.getCurrentUserProfile(_auth.currentUser!.uid).listen((
        f_user) {
      if (f_user != null) {
        _currentUser = f_user;
      }
    });
  }
  Stream<List<FirebaseUserDetailModel>> getAllUsers()
  {
    return UserProfileStore.getUsersProfile();
  }
}


