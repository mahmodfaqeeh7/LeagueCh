import 'package:e_commernce_ui/Data/model.dart';
import 'package:flutter/material.dart';
import 'Data/model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'Data/api.dart';




class newButton extends StatelessWidget
{
const newButton({Key? key,required this.width, required this.title , required this.function,  this.color  }) : super(key: key);

final double? width ;
final Widget title ;
final VoidCallback? function;
final Color? color;
@override
  Widget build(BuildContext context)


  {

    return Material(

      elevation: 3,
      borderRadius: BorderRadius.circular(25),
      color: color,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: width,

        onPressed: function,

        child:  title,
      ),
    );  }


}


class GridCON extends StatefulWidget


{
  const GridCON({Key? key,required this.width, required this.function, required this.height , required this.champ  }) : super(key: key);
  final double? height;
  final double? width ;
  final ImageNo champ ;

 final GestureTapCallback? function;


  @override
  State<GridCON> createState() => _GridCONState();

}

class _GridCONState extends State<GridCON> {


  @override
  Widget build(BuildContext context)
  {

             return


               Container(

                 margin: EdgeInsets.symmetric(horizontal: 5),

                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(25)),
                   color: Colors.black45,
                   boxShadow: [
                     BoxShadow(
                       color: Colors.black26.withOpacity(0.35),
                       spreadRadius: 3,
                       blurRadius: 5,
                       offset: Offset(0, 2), // changes position of shadow
                     ),
                   ],

                 ),
                 child : GestureDetector(

                     onTap: widget.function,
                     child: Column(children: [
                       Container(
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.all(Radius.circular(25)),
                           color: Colors.amber.shade500,


                         ),


                         margin: EdgeInsets.all(10),
                         width: widget.width,
                         height: widget.height,
                         child: Image.asset("http://ddragon.leagueoflegends.com/cdn/13.4.1/img/champion/Aatrox.png",
                             height: widget.height
                             ,width: widget.width ),
                       ),
                       Center(child :Text("", style:
                       TextStyle(fontSize: 12 ,fontWeight: FontWeight.normal ,color: Colors.white38 ),
                         textAlign: TextAlign.center,),),
                       Center(child :Text( "", style:
                       TextStyle(fontSize: 16 ,fontWeight: FontWeight.bold ,color: Colors.white ),
                         textAlign: TextAlign.center,),)
                     ],
                     )
                 ),
               );







  }
}




class DetailedScreen extends StatefulWidget
{

  final double? width ;
  final String name ;
  final String path ;
  final double price ;
  final String desc ;

  final VoidCallback? function;
  final Color? color;

  const DetailedScreen({Key? key, this.width,required this.name,required this.price,required this.desc, required this.path ,  this.function,  this.color  }) : super(key: key);


  @override
  State<DetailedScreen> createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  int counter = 1;

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(

      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.red.shade700,

        leading: IconButton(onPressed: (){Navigator.pop(context);},
            icon: Icon(Icons.arrow_back)),

        actions: [
          IconButton(onPressed: (){},
              icon: Icon(Icons.search)),
          IconButton(onPressed: (){},
              icon: Icon(Icons.shopping_cart)),

        ],

      ),
      backgroundColor: Colors.teal,
      body: SingleChildScrollView(

        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(15),
              child: Column(





              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(5),
                height: MediaQuery.of(context).size.height * 0.8,
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.2),
                decoration: const BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40) ,topRight: Radius.circular(40)),
                ),
                child: Column(
                  children: <Widget>[

                    SizedBox(height: MediaQuery.of(context).size.height*0.10,),

                    Column(
                     // crossAxisAlignment: CrossAxisAlignment.start,
                      children:  <Widget>[
                        SizedBox( height : 10),

                        Text(widget.name ,textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 22 ,
                              fontWeight: FontWeight.bold ,color: Colors.black ),),
                        SizedBox( height : 10),

                        Text("Price : ${widget.price}" ,textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 18 ,
                            fontWeight: FontWeight.bold ,color: Colors.black54 ,),),
                        SizedBox( height : 10),


                      ],


                    ),

                    Text(widget.desc , style: TextStyle(color: Colors.black54),
                      textAlign: TextAlign.center, ),
                    SizedBox(height: 25,),
                    Row(
                      children: <Widget>[
                        SizedBox(width: MediaQuery.of(context).size.width*0.05,),

                        Text("Colors : "),
                        CircleAvatar(backgroundColor: Colors.indigo,),
                        SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                        CircleAvatar(backgroundColor: Colors.red,),
                        SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                        CircleAvatar(backgroundColor: Colors.green,),
                        SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                        CircleAvatar(backgroundColor: Colors.black,),
                        SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                      ],


                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.03,),

                    Row(
                      children: <Widget>[
                        SizedBox(width: MediaQuery.of(context).size.width*0.05,),

                        Text("Amount : "),
                        SizedBox(width: MediaQuery.of(context).size.width*0.05,),

                        newButton(width: MediaQuery.of(context).size.width*0.10,
                            title: Text("-",style: TextStyle(color : Colors.white70 )),
                          function: (){
                          setState(() {
                            if(counter==1){}
                            if(counter > 1){counter = counter-1;}
                          });

                          } , color: Colors.teal.shade600,),
                        SizedBox(width: MediaQuery.of(context).size.width*0.05,),

                        Text("$counter", style: TextStyle(fontSize: 16)),


                        SizedBox(width: MediaQuery.of(context).size.width*0.05,),

                        newButton(width: MediaQuery.of(context).size.width*0.10,
                            title: Text("+" ,style: TextStyle(color : Colors.white70 )),
                            function: (){
                              setState(() {
                                if(counter != 15){counter = counter+1;}
                              });

                            },
                            color: Colors.teal.shade600)

                      ],


                    ),
                    SizedBox(height: MediaQuery.of(context).size.width*0.05,),

                    Text("Other Photos : ",style: TextStyle(), textAlign: TextAlign.left,),
                    SizedBox(height: MediaQuery.of(context).size.width*0.05,),
                    Text("Not Available",style: TextStyle(color: Colors.red),),
                    SizedBox(height: MediaQuery.of(context).size.width*0.05,),


                    SizedBox(height: 40,),
                    newButton(width: MediaQuery.of(context).size.width*0.6,
                        title: Text("Check out  ! !" ,
                          style: TextStyle(color : Colors.white, fontSize: 20 ,
                              fontWeight: FontWeight.bold ), ), function: (){}, color: Colors.teal.shade900,),
                    SizedBox(height: MediaQuery.of(context).size.width*0.025,),

                    Text("Total price : ${widget.price*counter}",style: TextStyle(), textAlign: TextAlign.left,),

                  ],


                ),
              ),
            ),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.1,
                right: MediaQuery.of(context).size.width * 0.1,
                left: MediaQuery.of(context).size.width * 0.1,

                child: Image.asset(widget.path, scale: 0.85, height: 160 , width: 160,),

            ),




          ],

        ),

      ),






    );

  }
}







class ListV extends StatefulWidget


{
  const ListV({Key? key, required this.function , required this.champ  }) : super(key: key);

  final ImageNo champ ;

  final GestureTapCallback? function;


  @override
  State<ListV> createState() => _ListVState();

}

class _ListVState extends State<ListV> {


  @override
  Widget build(BuildContext context)
  {

    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),

          color: Colors.black26,

        ),
        width: MediaQuery.of(context).size.width*0.8,
        height: 150,
        padding: EdgeInsets.all(10),

        child:  GestureDetector(

        onTap: widget.function,
        child: Column(children: [

          Container(

           child : Column(
              children: <Widget>[
                SizedBox(width: 30,),
                Image.network("http://ddragon.leagueoflegends.com/cdn/13.5.1/img/champion/${widget.champ.img!}"
                ,width: 80,height: 80,
                ),
                SizedBox(width: 5,),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: AutoSizeText("\n ${widget.champ.id!} " , style: TextStyle(fontSize: 18 ,fontWeight: FontWeight.bold ),textAlign: TextAlign.center,)
            ),
              ],

            ),
          ),
        ],
        )
          ,)


    );







  }
}

List<String> Newlistofnames(List<ImageNo> ch){
  List<String> names = [];

  ch.forEach((element) {names.add(element.id!); });
  return names;

}



class WrongList extends StatefulWidget


{
  const WrongList({Key? key, required this.function , required this.champ  }) : super(key: key);

  final ImageNo champ ;

  final GestureTapCallback? function;


  @override
  State<WrongList> createState() => _WrongListState();

}

class _WrongListState extends State<WrongList> {


  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),

          color: Colors.red.shade900,

        ),
        width: MediaQuery
            .of(context)
            .size
            .width * 0.8,
        height: 100,
        padding: EdgeInsets.all(10),

        child: GestureDetector(

          onTap: widget.function,
          child: Column(children: [

            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 30,),
                  Image.network(
                    "http://ddragon.leagueoflegends.com/cdn/13.5.1/img/champion/${widget
                        .champ.img!}"
                    , width: 40, height: 40,
                  ),
                  SizedBox(width: 15,),
                  FittedBox(
                      fit: BoxFit.scaleDown,
                      child: AutoSizeText("\n ${widget.champ.id!} ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,)
                  ),
                ],

              ),
            ),
          ],
          )
          ,)


    );
  }
}
