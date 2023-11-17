import 'package:e_commernce_ui/Data/model.dart';
import 'package:flutter/material.dart';
class Search extends ChangeNotifier{


  List<ImageNo> modellist = [];
  List<ImageNo> wronganswer = [];
  List<ImageNo> hintanswers = [];
  List<ImageNo> wronganswer2 = [];



  Future<void> ChangeSearch( List<ImageNo> loaded , String v) async
  {
    modellist = await loaded.where(
            (element) => element.id!.toLowerCase().contains(v.toLowerCase())).toList();

    notifyListeners();


  }
  Future<void> addwrong( ImageNo ch) async
  {
    wronganswer.add(ch);
    notifyListeners();


  }

  Future<void> addwrong2( ImageNo ch) async
  {
    wronganswer.add(ch);
    notifyListeners();


  }

}