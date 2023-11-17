import 'package:e_commernce_ui/Screens/Modeselection.dart';
import 'package:e_commernce_ui/Screens/reallogin.dart';
import 'package:e_commernce_ui/Screens/welcomepage.dart';
import 'package:flutter/material.dart';


import '../Screens/Signup.dart';
import '../Screens/homepage.dart';
import 'Screens/Editprof.dart';

const String welcomeRoute='/';
const String loginRoute='/loginRoute';
const String signupRoute='/signupRoute';
const String homeRoute='/homeRoute';
const String modeRoute='/modeRoute';
const String imageViewer = '/imageViewer';

class MyRouter{

  static Route generateRoutes(RouteSettings settings){

    switch (settings.name){
      case welcomeRoute:{
        return _route(WelcomePage());
      }
      case loginRoute:{
        return _route(login());
      }
      case modeRoute:{
        return _route(modeselect());
      }
      case imageViewer:{
        final arg = settings.arguments as String;
        return _route(ImageViewerScreen(url: arg));
      }
      case signupRoute:{
        return _route(Signupscreen());
      }
      case homeRoute:{
        return _route(homepage());
      }
      default:{
        return _route(undefined());

      }


    }


  }

  static MaterialPageRoute _route(Widget w){
    return MaterialPageRoute(builder: (_)=>w);
  }
}


class undefined extends StatelessWidget {
  const undefined({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(" undefined page",style: TextStyle(fontSize: 40,color: Colors.red),),
    );
  }
}