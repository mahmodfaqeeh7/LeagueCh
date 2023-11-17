import 'dart:math';
import 'package:e_commernce_ui/Data/HintsModel.dart';
import 'package:e_commernce_ui/Data/SearchModel.dart';
import 'package:e_commernce_ui/Route.dart';
import 'package:e_commernce_ui/Data/Sharedprefs.dart';
import 'package:e_commernce_ui/Data/api.dart';
import 'package:e_commernce_ui/Data/model.dart';
import 'package:e_commernce_ui/widgetsui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:once/once.dart';


import '../Data/AuthClass.dart';
import '../Data/UserModel.dart';


class ClassicPage extends StatefulWidget {
  const ClassicPage({Key? key}) : super(key: key);

  @override
  State<ClassicPage> createState() => _ClassicPageState();
}

class _ClassicPageState extends State<ClassicPage> {


  final TextEditingController searchCon = new TextEditingController();


  List<String> listofname = [];
  List<ImageNo> wronganswers = [];

  bool isvis = false;
  PhotoService api = PhotoService();
  PhotosList? apilist ;
  int randomNumber = 0 ;

  String? id ;
  int? wincounter;
  UserModel? user ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = CacheHelper.getData(key: "currentid");
    Once.runDaily(
        "key",
        callback: () {
          Random random = new Random();
          randomNumber = random.nextInt(162);
          CacheHelper.saveData(key: "randomNumber", value: randomNumber);
        },
        fallback: (){
          randomNumber = CacheHelper.getData(key: "randomNumber");
        }

    );

    Search().wronganswer2 = [];



  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      
      body: Stack(

          children: <Widget>[

            Container(

              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/background.jpeg"),
                    fit: BoxFit.cover,
                    alignment:Alignment.topCenter
                ),
              ),
            ),



            SingleChildScrollView(
              child: FutureBuilder(
                  future: api.loadAddressData(),
                  builder :(context , aa) {
                    if(aa.hasData)
                    {
                      apilist = aa.data as PhotosList;
                      listofname =  Newlistofnames(apilist!.photos);
                      // display = apilist;



                      var tags  = apilist!.photos[randomNumber].tags;
                      String? partype  = apilist!.photos[randomNumber].partype;
                      String? title  = apilist!.photos[randomNumber].title;
                      int? magic  = apilist!.photos[randomNumber].magic;
                      int? def  = apilist!.photos[randomNumber].defence;
                      int? diff  = apilist!.photos[randomNumber].diff;
                      int? attack  = apilist!.photos[randomNumber].attack;

                      String? Hint1 = "1- the Champ tags is $tags " ;
                      String? Hint2 = "2- the Champ use  $partype " ;
                      String? Hint3 = "3- the Champ title is $title " ;
                      String? Hint4 = "4- in scale out of 10 this champ is "
                          "\n $magic /10 AP \n $attack /10 AD"
                          "\n $def /10 TANK \n $diff /10 Difficulty " ;


                      String? titleholder  = apilist!.photos[randomNumber].id;
                      print("$titleholder");

                      return  Column(

                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment:CrossAxisAlignment.start ,
                        children: [
                          SizedBox(height: 50,),


                          Container(
                            margin: EdgeInsets.all(25),

                            child: Consumer<Search>(
                              builder: (_,model,child)=>TextFormField(
                                  onChanged: (v) {

                                    model.ChangeSearch(apilist!.photos, v);

                                  },
                                  autofocus: false,
                                  controller: searchCon,
                                  keyboardType: TextInputType.name,

                                  onSaved: (value) {
                                    searchCon.text = value!;
                                  },
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(

                                    prefixIcon: Icon(Icons.search),
                                    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                                    hintText: "Search",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),

                                  )

                              ),
                            ),

                          ),

                          SizedBox(height:15),


                          SizedBox(height: 12),
                          Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Text("Guess the Champ with the following Hints \n (1 more every miss) " , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold ,color: Colors.blueGrey.shade700),)),
                          SizedBox(height: 15,),
                          Container(decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(20),


                            ),
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(2),
                              child: Text( Hint1,
                                style: TextStyle( fontSize: 18 , fontWeight: FontWeight.bold ,),
                                textAlign: TextAlign.left,),

                            ),



                          SizedBox(height: 5,),
                        Consumer<Hints>(
                            builder: (_,model,child)=>Visibility(
                              visible : model.h2 ,
                              child: Container(decoration: BoxDecoration(
                                 color: Colors.black26,
                                 borderRadius: BorderRadius.circular(10),


                                ),
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(2),
                                child: Text( Hint2, style: TextStyle( fontSize: 18 , fontWeight: FontWeight.bold ,),),

                              ),


                          ),
                    ),
                          SizedBox(height: 5,),
                          Consumer<Hints>(
                            builder: (_,model,child)=>Visibility(
                              visible : model.h3 ,
                              child:  Container(decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.circular(10),


                                ),
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.all(2),
                                  child: Text( Hint3, style: TextStyle( fontSize: 18 , fontWeight: FontWeight.bold ,),),

                                ),


                            ),
                          ),
                          SizedBox(height: 5,),
                          Consumer<Hints>(
                            builder: (_,model,child)=>Visibility(
                              visible : model.h4 ,
                              child:  Container(decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.circular(10),


                                ),
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.all(2),
                                  child: Text( Hint4, style: TextStyle( fontSize: 18 , fontWeight: FontWeight.bold ,),),

                                ),


                            ),
                          ),

                          SizedBox(height: 15,),


                          FutureBuilder(
                              future: UserService().getUser(id!),
                              builder: (ctx, snapshot) {
                                var data = snapshot.data;

                                if (data == null) {
                                  return (
                                    Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  );

                                }
                                user = data as UserModel;
                                if(user!.wincounter == null) user!.wincounter =0;

                                //   wincounter = user!.wincounter! == null ? 0 : user!.wincounter!;


                                return  Container(
                                    decoration: BoxDecoration(
                                      // color: Colors.black26,
                                      //   borderRadius: BorderRadius.circular(20),


                                    ),
                                    margin: EdgeInsets.all(10),
                                    padding: EdgeInsets.all(2),

                                    child: Consumer2<Search,Hints>(
                                      builder:(_,model,Hints,child) => ListView.builder(
                                        shrinkWrap: true ,

                                        physics: ScrollPhysics(),
                                        itemCount:  model.modellist == null ? 0 : model.modellist.length,
                                        itemBuilder: (BuildContext context, int index)
                                        {

                                          return searchCon.text == "" ?
                                          GestureDetector(

                                              child:  Container()):
                                          Padding(
                                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                              child: ListV(
                                                  function: ()
                                              {


                                                ImageNo ch = model.modellist[index];
                                                if(ch.id == titleholder)
                                                {


                                                  searchCon.clear();

                                                  user!.wincounter = user!.wincounter! +1;

                                                  UserService().updateUser(id!, user!);

                                                  print("YOU WON");
                                                  setState(() {
                                                    isvis = true;
                                                  });



                                                }
                                                else {
                                                  setState(() {
                                                    Hints.IncHints();
                                                  });

                                                  print("You ARE WRONG");
                                                  print(ch.id);
                                                  model.addwrong2(ch);
                                                  searchCon.clear();
                                                }

                                              },
                                                  champ: model.modellist[index]));
                                        },
                                      ),
                                    )
                                );





                              }
                          ),

                          Divider(height: 2,),
                          SizedBox(height: 15,),
                          Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Text(" Answers :" , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold ,color :Colors.blueGrey.shade700),)),

                          Container(
                              decoration: BoxDecoration(
                                color: Colors.white38,
                                borderRadius: BorderRadius.circular(20),


                              ),
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(2),

                              child: Consumer<Search>(
                                builder:(_,model,child) => ListView.builder(
                                  shrinkWrap: true ,

                                  physics: ScrollPhysics(),
                                  itemCount: model.wronganswer2.length,
                                  itemBuilder: (BuildContext context, int index)
                                  {

                                    return Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        child: WrongList(function: ()
                                        {
                                        }, champ: model.wronganswer2[index] ,));
                                  },
                                ),
                              )),



                          SizedBox(height: 20,),

                          SizedBox(height: 20,),


                          SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                          newButton(width: MediaQuery.of(context).size.width*0.4,
                              title: Text("back"),
                              function: (){

                                Navigator.of(context).pushReplacementNamed(modeRoute);
                              }),
                        ],

                      );



                    }
                    else
                    {return LinearProgressIndicator();}
                  }
              ),
              // padding: EdgeInsets.symmetric(horizontal: 5),

            ),

      Consumer2<Search ,Hints>(
          builder: (_,model,Hints,child)=> Visibility(
              visible: isvis,
              child: Container(

                width: double.infinity,
                height: double.infinity,
                decoration:  BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "assets/images/win.png"),
                      fit: BoxFit.cover,
                    ),


                ),

                child: Center(child:newButton(width:MediaQuery.of(context).size.width*0.5
                    , title: Text("C O N G R A T S"),
                    function: (){
                      model.wronganswer2 = [];
                      Hints.counter =1;
                      Hints.h2 = false;
                      Hints.h3 = false;
                      Hints.h4 = false;

                      Navigator.of(context).pushReplacementNamed(modeRoute);

                    },color: Colors.blue,
                    ),

                ),

              ),
            ),
      ),

          ]
      ),



      //  ),
    );
  }
}
