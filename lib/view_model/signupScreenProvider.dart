import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../model/firebase_user_model/firebase_user_model.dart';
import '../utils/firebase_database/firebase_firestore/user_profile.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';

class SignUpScreenProvider extends ChangeNotifier{
  final auth = FirebaseAuth.instance;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController conformPassword= TextEditingController();
  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode conformFocus = FocusNode();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    name.dispose();
    email.dispose();
    password.dispose();
   conformPassword.dispose();
  }

  FocusNode signUpFocus = FocusNode();
  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
  bool isObx = false;
  setObs(){
    isObx = !isObx;
    notifyListeners();
  }
  bool isObx1 = false;
  setObs1(){
    isObx1 = !isObx1;
    notifyListeners();
  }


  void signup(BuildContext context) async {
    String emailText = email.text.toString().trim();
    String nameText = name.text.toString().trim();
    String imageUrl = "";
    String pass = password.text.toString().trim();
    DateTime now = DateTime.now();
    String joinDate = DateTime(now.year, now.month, now.day).toString().replaceAll("00:00:00.000", "");


    await auth.createUserWithEmailAndPassword(
        email: emailText, password: pass)
        .then((value) async {
      setLoading(false);
      String uid = auth.currentUser!.uid;
       await UserProfileStore().setUserProfileDetail(FirebaseUserDetailModel(email: emailText,
          name: nameText,
          uid: uid,
          joinDate: joinDate,
          pass: pass,
          imageUrl: imageUrl));

       email.clear();
       name.clear();
       password.clear();
       conformPassword.clear();

      Navigator.pushNamed(context, RoutesName.signIn);
        }).onError((error, stackTrace) {
      Utils.toastMessage(error.toString());
      setLoading(false);
    });
  }


}