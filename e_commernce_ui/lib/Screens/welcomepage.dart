import 'package:e_commernce_ui/Screens/Homepage.dart';
import 'package:e_commernce_ui/Screens/Modeselection.dart';
import 'package:e_commernce_ui/widgetsui.dart';
import 'package:flutter/material.dart';
import 'package:e_commernce_ui/Route.dart';

import '../Data/Sharedprefs.dart';
class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}


class _WelcomePageState extends State<WelcomePage> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();

}
  @override
  Widget build(BuildContext context) {
    return CacheHelper.getData(key: "loginstate") ?? false  ? modeselect() : Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/back1.png"),
                  fit: BoxFit.cover),



            ),),


                Column(
                  children:<Widget>[

                    SizedBox(height: MediaQuery.of(context).size.height*0.70,),

                    Row(children:
                    <Widget>[
                      SizedBox(width: MediaQuery.of(context).size.width*0.13,),

                      newButton(width: MediaQuery.of(context).size.width*0.3,
                        title: Text("Sign up", style: TextStyle(fontSize: 22),),
                        function: (){Navigator.of(context).pushNamed(signupRoute);} ,
                        color: Colors.blueGrey,),

                      SizedBox(width: 50,),
                      newButton(width: MediaQuery.of(context).size.width*0.3,
                        title: Text("Log in" , style: TextStyle(fontSize: 22),),
                        function: (){Navigator.of(context).pushNamed(loginRoute);} ,color: Colors.greenAccent.shade700,)


                    ],
                    ),
                  ]

                ),
              






        ],

      )
    );
  }
}
