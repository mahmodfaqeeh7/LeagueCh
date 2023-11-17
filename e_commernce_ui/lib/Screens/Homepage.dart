import 'dart:math';

import 'package:e_commernce_ui/Data/AuthClass.dart';
import 'package:e_commernce_ui/Data/SearchModel.dart';
import 'package:e_commernce_ui/Data/UserModel.dart';
import 'package:e_commernce_ui/Route.dart';
import 'package:e_commernce_ui/Data/Sharedprefs.dart';
import 'package:e_commernce_ui/Data/api.dart';
import 'package:e_commernce_ui/Data/model.dart';
import 'package:e_commernce_ui/widgetsui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:once/once.dart';
import 'package:provider/provider.dart';



class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);




  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {


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

    id = CacheHelper.getData(key: "currentid");

    Search().wronganswer = [];



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


                      String? guesstitle  = apilist!.photos[randomNumber].title;
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
                              child: Text("Guess this Title of the Champ ! " ,
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold ,color: Colors.blueGrey.shade700),)),
                          SizedBox(height: 15,),
                          Center(
                            child: Container(decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(20),


                            ),
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(2),
                              child: Text("$guesstitle ", style: TextStyle( fontSize: 20 , fontWeight: FontWeight.bold ,),),

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


                                return   Container(
                                    decoration: BoxDecoration(
                                      // color: Colors.black26,
                                      //   borderRadius: BorderRadius.circular(20),


                                    ),
                                    margin: EdgeInsets.all(10),
                                    padding: EdgeInsets.all(2),

                                    child: Consumer<Search>(
                                      builder:(_,model,child) => ListView.builder(
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
                                              child: ListV(function: ()
                                              {
                                                ImageNo ch = model.modellist[index];
                                                if(ch.title == guesstitle)
                                                {
                                                  searchCon.clear();
                                                  print("YOU WON");

                                                  user!.wincounter = user!.wincounter! +1;

                                                  UserService().updateUser(id!, user!);

                                                  setState(() {
                                                    isvis = true;
                                                  });



                                                }
                                                else {
                                                  print("You ARE WRONG");
                                                  print(ch.id);
                                                  model.addwrong(ch);
                                                  searchCon.clear();
                                                }

                                              },
                                                  champ: model.modellist[index]));
                                        },
                                      ),
                                    ));





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
                                  itemCount: model.wronganswer.length,
                                  itemBuilder: (BuildContext context, int index)
                                  {

                                    return Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        child: WrongList(
                                          function: () {}, champ: model.wronganswer[index] ,));
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

      Consumer<Search>(
          builder: (_,model,child)=> Visibility(
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
                       model.wronganswer = [];
                      Navigator.of(context).pushReplacementNamed(modeRoute);

                    },color: Colors.blue,

                    ),),

              ),
            ),
      ),

          ]
      ),



      //  ),
    );
  }
}
