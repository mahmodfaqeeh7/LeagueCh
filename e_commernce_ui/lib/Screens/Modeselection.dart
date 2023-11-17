

import 'package:e_commernce_ui/Data/AuthClass.dart';
import 'package:e_commernce_ui/Route.dart';
import 'package:e_commernce_ui/Screens/ClassicMode.dart';
import 'package:e_commernce_ui/Screens/Editprof.dart';
import 'package:e_commernce_ui/Screens/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../Data/Sharedprefs.dart';
import '../Data/UserModel.dart';
import '../widgetsui.dart';
class modeselect extends StatefulWidget {
  const modeselect({Key? key}) : super(key: key);

  @override
  State<modeselect> createState() => _modeselectState();
}



class _modeselectState extends State<modeselect> {
  String? id;

  String? name;
  String? imgurl;
  String? email;
  var wincounter;
  UserModel? user ;

  bool profvis = false;
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
     id = CacheHelper.getData(key: "currentid");



  }


  @override
  Widget build(BuildContext context) {
    return UserService().isEmailVerified() ?
     Scaffold(
    appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.blue.shade700,
        title: Text("LeagueChallenge" ,textAlign: TextAlign.center,),

      actions: [
        IconButton(
            onPressed: (){
              setState(() {
                profvis = true;
              });


            },
            icon: Icon(Icons.person)),

      ],



      ),
      body: Stack(

          children :
          [
            Container(
              width: double.infinity,
              height: double.maxFinite,
              alignment: Alignment.center,
              color: Colors.indigo.shade700,
              ),


            SingleChildScrollView(
              child :Center (
                child :
                Column(


                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                  Container(

                  width: 170,
                  height: 170,
                  decoration:  BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "assets/images/lolicon.png"),
                      fit: BoxFit.cover,
                    ),


                  ),),

                    SizedBox(height: MediaQuery.of(context).size.height*0.05,),


                    Text("Welcome to LeageChallenge" , textAlign: TextAlign.center,
                      style: TextStyle(color : Colors.white ,fontSize: 24 , fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),


                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      child: InkWell(
                          borderRadius: BorderRadius.circular(24),
                          splashColor: Colors.brown.withOpacity(0.7), // Splash color
                          onTap: () {

                            Navigator.push(
                              context, PageTransition(
                              child: ClassicPage(),
                              type: PageTransitionType.leftToRightWithFade,
                            ),);



                          },
                          child: Stack(
                            children:  [
                              Ink(
                                width: MediaQuery.of(context).size.width * 0.85,
                                height: MediaQuery.of(context).size.width*0.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  image: const DecorationImage(
                                    colorFilter: ColorFilter.mode(Colors.black26, BlendMode.colorBurn),
                                    opacity: 0.65,
                                    fit: BoxFit.cover,
                                    image: AssetImage("assets/images/yasuo.jpg"), // Background image
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(10 ,MediaQuery.of(context).size.width*0.3,0,5),
                                  child: Text("Classic : guess the champion" ,style: TextStyle(color: Colors.white , fontSize: 22),)),


                            ],)
                      ),
                    ),

                    SizedBox(height: 10,),


                    SizedBox(height: 10,),

                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(24),
                        splashColor: Colors.brown.withOpacity(0.7), // Splash color
                        onTap: () {


                          Navigator.push(
                            context, PageTransition(
                            child: homepage(),
                            type: PageTransitionType.leftToRightWithFade,
                          ),
                          );

                        },
                        child: Stack(
                          children:  [
                            Ink(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: MediaQuery.of(context).size.width*0.4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                image: const DecorationImage(
                                  colorFilter: ColorFilter.mode(Colors.black26, BlendMode.colorBurn),
                                  opacity: 0.65,
                                  fit: BoxFit.cover,
                                  image: AssetImage("assets/images/zed.jpg"), // Background image
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(10 ,MediaQuery.of(context).size.width*0.3,0,5),
                                child: Text("Titlol : Guess the Title" ,style: TextStyle(color: Colors.white , fontSize: 22),)),
                          
                          
                        ],) 
                      ),
                    ),


                    SizedBox(height: 10,),



                  ],


                ),

              ),
            ),

        FutureBuilder(
            future: UserService().getUser(id!),
                 builder: (ctx, snapshot) {
                   var data = snapshot.data;

                   if (data == null) {
                     return Scaffold(
                       body: Center(
                         child: CircularProgressIndicator(),
                       ),
                     );
                   }
                   user = data as UserModel;
                   name = user!.name!;
                   email = user!.email!;
                   imgurl = user!.imageURL!;

                   wincounter =user!.wincounter;

                  print(wincounter);


                   return Container(



                     child:  Visibility(
                       visible: profvis,
                       child: Center(
                         child: Container(
                           width: double.infinity,
                           height: double.maxFinite,
                           alignment: Alignment.center,
                           color: Colors.blue.shade500,

                           child:SingleChildScrollView(
                             child : Column(
                               children:  <Widget>[

                               SizedBox(height: 25,),
                               CircleAvatar(
                                 backgroundImage:
                                 imgurl!.isEmpty ?
                                  AssetImage("assets/images/icon.jpg")
                                  : NetworkImage(imgurl!) as ImageProvider,

                                 radius: 75,
                               ),
                               SizedBox(height: 25,),
                               Text( "Welcom buddy 👋 " ,
                                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold ,color: Colors.white),),
                               SizedBox(height: 5,),
                               Text( name! ,
                                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold ,color: Colors.white),),
                               Text( email! ,
                                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold ,color: Colors.black),),
                               SizedBox(height: 25,),
                               Text( "Wins you have achieved 🏆 :  " ,
                                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold ,color: Colors.white),),
                               SizedBox(height: 15,),

                               Text( wincounter == null ? "0" : "$wincounter" ,
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold ,color: Colors.white),),



                               SizedBox(height: 80,),
                               newButton(width: MediaQuery.of(context).size.width*0.4,
                                   title: Text( "Edit Information" ,
                                     style: TextStyle(fontSize: 18 ,color: Colors.white),),
                                   function: (){

                                     Navigator.push(
                                       context, PageTransition(
                                       child: HomeProfileScreen(id: id!,),
                                       type: PageTransitionType.leftToRightWithFade,
                                     ),
                                     );


                                   },color: Colors.blue.shade900
                               ),
                               SizedBox(height: 10,),
                               newButton(width: MediaQuery.of(context).size.width*0.4,
                                 title: Text( "Back" ,
                                   style: TextStyle(fontSize: 18 ,color: Colors.white),),
                                 function: (){
                                   setState(() {
                                     profvis = false;
                                   });
                                 },color: Colors.blue.shade900,

                               ),
                               SizedBox(height: 20,),

                               newButton(width: MediaQuery.of(context).size.width*0.4,
                                   title: Text( "Sign out" ,
                                     style: TextStyle(fontSize: 18 ,color: Colors.white),),
                                   function: (){
                                 setState(() {
                                   CacheHelper.removeData(key: "loginstate");
                                   CacheHelper.removeData(key: "emailstate");

                                   Navigator.of(context).pushNamed(loginRoute);
                                 });
                                   },color: Colors.red.shade900,

                               ),


                             ],

                           ),
                           ),

                         ),

                       ),
                     ),

                   );
                 }
               ),



          ]
      ),
    ) :
     Scaffold(
       backgroundColor: Colors.blueGrey,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.circular(15),

          ),
          width: MediaQuery.of(context).size.width*0.9,
          height: MediaQuery.of(context).size.width*0.9,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(top: 100),

          child: Column(
            children:<Widget>[
              SizedBox(height: 80,),

              CircularProgressIndicator(),
              SizedBox(height: 30,),

              Text("Verify your email then come back" , style: TextStyle(fontSize: 24),textAlign: TextAlign.center,)
            ],

          ),
        )

      ),
    );
  }

}