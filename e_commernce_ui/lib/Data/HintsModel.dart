import 'package:e_commernce_ui/Data/model.dart';
import 'package:flutter/material.dart';
class Hints extends ChangeNotifier{


 int counter = 1;
 bool h2 = false ;
 bool h3 = false ;
 bool h4 = false ;

  void IncHints()
  {
    counter = counter +1;
    if(counter == 2) h2 =true;
    if(counter == 3) h3 =true;
    if(counter == 4) h4 =true;

    print(counter);
    notifyListeners();

  }


}