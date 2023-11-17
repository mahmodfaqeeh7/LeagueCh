import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:e_commernce_ui/Data/model.dart';

// class PhotoService{
//   Future<String> _loadJsonFromAssets() async{
//   return await rootBundle.loadString('assets/JSON/photo.json');
//   }
//   Future<PhotosList> loadAddressData() async{
//     //string -> job/map
//     var decodedData = json.decode(await _loadJsonFromAssets());
//     //map -> list
//     var model = PhotosList.fromJson(decodedData);
//     return model;
//
//   }
// }
class PhotoService{
  static Future<String> _loadJsonFromAssets() async{
    var url = Uri.parse("http://ddragon.leagueoflegends.com/cdn/13.4.1/data/en_US/champion.json");
    var respon = await http.get(url);
    return respon.body;
  }
  Future<PhotosList> loadAddressData() async{
    //string -> job/map
    var decodedData = json.decode(await _loadJsonFromAssets());
    // log("serv -> ${decodedData}");

    //map -> list
    var model = PhotosList.fromJson(decodedData['data']);
    // log("serv -> ${model}");
    return model;

  }
}