import 'dart:collection';

import 'package:e_commernce_ui/Data/AuthClass.dart';
import 'package:e_commernce_ui/Data/InternetConnection.dart';
import 'package:e_commernce_ui/Screens/Homepage.dart';
import 'package:e_commernce_ui/Screens/Modeselection.dart';
import 'package:e_commernce_ui/Screens/reallogin.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_database/firebase_database.dart';
import '../Data/Sharedprefs.dart';
import '../widgetsui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({Key? key}) : super(key: key);

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

  final _formKe = GlobalKey<FormState>();
  final TextEditingController fname = new TextEditingController();
  final TextEditingController lname = new TextEditingController();
  final UserService userService = UserService();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  String? errorMessage;




class _SignupscreenState extends State<Signupscreen> {

  final firstname =
  TextFormField(
      autofocus: false,
      controller: fname,
      keyboardType: TextInputType.name,

      onSaved: (value) {
        fname.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "first name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),

      )

  );

  final lastname =
  TextFormField(
      autofocus: false,
      controller: lname,
      keyboardType: TextInputType.name,

      onSaved: (value) {
        lname.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "last name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),

      )

  );
  final emailField =
  TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
            .hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),

      )

  );
  final passwordField =
  TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      )
  );




  @override
  Widget build(BuildContext context) {

    final FirebaseDatabase database = FirebaseDatabase.instance;
    final DatabaseReference reference = database.ref();
    String root = "Users";

    return Scaffold(
      body:Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/lol.jpg"),
              fit: BoxFit.cover,
          ),

        ),
        child: Center(

          child: SingleChildScrollView(
            child:Container(
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white54,

              ),
              padding: const EdgeInsets.all(25.0),
                child: Form(
                  key: _formKe,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.withOpacity(0.35),
                      borderRadius: BorderRadius.circular(20),


                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                          Image(image: AssetImage
                            ("assets/images/signup.png"),width: 220,height: 220,),





                        SizedBox(height: 45),

                        firstname,
                        SizedBox(height: 20),
                        lastname,

                        SizedBox(height: 20),

                        emailField,


                        SizedBox(height: 20),
                        passwordField,
                        SizedBox(height: 20),
                        newButton(width:  MediaQuery.of(context).size.width * 0.35,
                          title: Text("Sign up" ,style: TextStyle(color: Colors.white),),
                          function: (){
                          validateAndSubmit(context);


                          },
                          color: Colors.indigo.shade400,
                        ),


                        SizedBox(height: 20,),

                        SizedBox(height: 55,),


                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

    );
  }
  void validateAndSubmit(BuildContext context) async {
    if (_formKe.currentState!.validate()) {
      if (await ConnectivityService.checkInternetConnectivity()) {


        var userData = HashMap();
        userData['email'] = emailController.text.trim();
        userData['password'] = passwordController.text.trim();
        userData['name'] = fname.text.trim();


        var result =await userService.signUp(userData);


        if (result == "Weak Password") {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Password should be al least 6 letters")));
        } else if (result == "The account is already exists Try Sign in") {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Email is used")));
        } else {
          //Navigator to home page
          CacheHelper.putBoolean(key: "loginstate", value: true);

          Navigator.pushReplacement(context, PageTransition(child: modeselect(),
            type: PageTransitionType.rightToLeft,

          ),
          );

        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
  static const snackBar = SnackBar(
    content: Text('No Internet' , textAlign: TextAlign.center, style: TextStyle(fontSize: 16),),
  );

}