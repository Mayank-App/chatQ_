import 'package:chat_application/utils/routes/routes_name.dart';
import 'package:chat_application/view/chatroom_screen.dart';
import 'package:chat_application/view/forget_password_screen.dart';
import 'package:chat_application/view/home_screen.dart';
import 'package:chat_application/view/signIn_screen.dart';
import 'package:chat_application/view/signUp_screen.dart';
import 'package:flutter/material.dart';

import '../../view/splash_screen.dart';

class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings){

    switch(settings.name){
      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (BuildContext context)=>SplashScreen());
      case RoutesName.signIn:
        return MaterialPageRoute(builder: (BuildContext context)=>SignInScreen());
      // case RoutesName.home:
      //   return MaterialPageRoute(builder: (BuildContext context)=>HomeView());
      case RoutesName.signUp:
        return MaterialPageRoute(builder:(BuildContext context)=>SignUpScreen());
      case RoutesName.forgetPassword:
        return MaterialPageRoute(builder: (BuildContext context)=>ForgetPasswordScreen());
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (BuildContext context)=>HomeScreen());
      case RoutesName.chatRoomScreen:
             Map<String,dynamic> user = settings.arguments as Map<String,dynamic>;
        return MaterialPageRoute(builder: (BuildContext context)=>ChatRoomScreen(receiver:user["user"]));
      default:
        return MaterialPageRoute(builder: (_){
          return  const Scaffold(
            body: Center(
              child: Text("No routes are there"),
            ),
          );
        });
    }

  }
}