import 'dart:developer';

class PhotoModel {
  ImageNo? imageNo;

  PhotoModel({this.imageNo});

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
        imageNo: json['imageNo'] != null ? ImageNo.fromJson(json['imageNo']) : null);
  }

  PhotoModel.fromJson2(Map<String, dynamic> json) {
    imageNo = json['imageNo'] != null ? ImageNo.fromJson(json['imageNo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (imageNo != null) {
      data['imageNo'] = imageNo!.toJson();
    }
    return data;
  }
}

class ImageNo {

  String? id;
  String? title;
  String? img;
  var tags;
  String? partype;
  int? magic;
  int? attack;
  int? defence;
  int? diff;


  ImageNo({ this.id, this.title,this.img,this.tags ,this.partype, this.attack ,this.defence,this.diff,this.magic});

  factory ImageNo.fromJson(Map<String, dynamic> json) {
    return ImageNo(
        id: json['name'],
        title: json['title'],
        img: json['image']['full'],
        tags : json['tags'],
        partype: json['partype'],
       magic: json['info']['magic'],
      diff: json['info']['difficulty'],
      attack: json['info']['attack'],
      defence: json['info']['defense'],
    );

  }

  ImageNo.fromJson2(Map<String, dynamic> json) {
    id = json['name'];
    title = json['title'];
    img = json['image']['full'];
    tags = json['tags'];
   // partype= json['partype'];
   // magic= json['info']['magic'];
 //   diff= json['info']['difficulty'];
   // attack= json['info']['attack'];
   // defence= json['info']['defense'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;

    return data;
  }
}

class PhotosList {
  List<ImageNo> photos;

  PhotosList({required this.photos});

  factory PhotosList.fromJson(Map<String, dynamic> photos) {
    List<ImageNo> data = [];
    photos.forEach((key, value) {
      data.add(ImageNo.fromJson(value));
    });
    // data = photos.map((item) => ImageNo.fromJson(item)).toList();
    return PhotosList(photos: data);
  }
}
