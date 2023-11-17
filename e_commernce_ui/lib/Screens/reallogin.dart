import 'package:e_commernce_ui/Data/InternetConnection.dart';
import 'package:e_commernce_ui/Route.dart';
import 'package:e_commernce_ui/Screens/Homepage.dart';
import 'package:e_commernce_ui/Screens/Modeselection.dart';
import 'package:e_commernce_ui/Screens/Signup.dart';
import 'package:page_transition/page_transition.dart';
import 'package:e_commernce_ui/widgetsui.dart';
import 'package:flutter/material.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

import '../Data/Sharedprefs.dart';
import '../Data/api.dart';
import '../Data/model.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

final _formKey = GlobalKey<FormState>();



final TextEditingController emailController = new TextEditingController();
final TextEditingController passwordController = new TextEditingController();

String? errorMessage;




class _loginState extends State<login> {

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


  final passwordField = TextFormField(
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


  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/giphy1.gif"),
            fit: BoxFit.cover),),
        child: Center(

          child: SingleChildScrollView(



              child: Container(
                decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  color: Colors.white54,

                ),
                margin:const EdgeInsets.all(14.0) ,
                padding: const EdgeInsets.all(25.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                //      const CircleAvatar(
                  //      backgroundImage : AssetImage
                    //      ("assets/images/select.png"),
                      //  minRadius: 100,
                        //maxRadius: 100,

                      //),




                      SizedBox(height: 45),

                      emailField,


                      SizedBox(height: 25),
                      passwordField,
                      SizedBox(height: 35),


                      newButton(width:  MediaQuery.of(context).size.width * 0.35,
                          title: Text("Log in" ,style: TextStyle(color: Colors.white),),
                          function: (){

                            validateAndSubmit(context);


                          },
                        color: Colors.deepOrange.shade700,
                      ),


                      SizedBox(height: 20,),
                      Text("Or Sign in using Google" ,
                        style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),),
                      SizedBox(height: 20,),

                      InkWell(
                        onTap: () {
                          userService.signInWihGoogle().whenComplete(() => {
                            CacheHelper.putBoolean(key: "loginstate", value: true),
                            Navigator.of(context).pushReplacementNamed(modeRoute),
                          });
                        },
                        child: Ink(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(6),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.deepOrange.shade500,
                                borderRadius: BorderRadius.circular(10),

                              ),
                              padding: EdgeInsets.all(10),
                              child: Wrap(

                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Icon(Icons.android , color: Colors.white,), // <-- Use 'Image.asset(...)' here
                                  SizedBox(width: 12),
                                  Text('Sign in with Google',
                                    style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 15),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Don't have an account? ",style: TextStyle(
                                color: Colors.black87,

                                fontSize: 15),),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context, PageTransition(
                                  child: Signupscreen(),
                                  type: PageTransitionType.leftToRightWithFade,
                                ),
                                );


                              },
                              child: Text(
                                "SignUp",
                                style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            )
                          ])
                    ],
                  ),
                ),
              ),

          ),
        ),
      ),
    );
  }
  void validateAndSubmit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      if (await ConnectivityService.checkInternetConnectivity()) {

        var result = await userService.signIn(emailController.text, passwordController.text);


        if (result == "NO USER FOUND") {


          Navigator.of(context).pushReplacementNamed(signupRoute);
        } else if (result == "WRONG PASSWORD,TRY AGAIN") {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Wrong Password Try Again")));
        } else {
          CacheHelper.putBoolean(key: "loginstate", value: true);
          Navigator.of(context).pushReplacementNamed(modeRoute);
        }
      } else {
        SnackBar(content: Text("no internet"));
      }
    }
  }
}

