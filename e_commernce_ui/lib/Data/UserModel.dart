class UserModel {
  String? name;
  String? email;
  String? password;
  String? imageURL;
  String? uid;
  bool? loginState;
  int? wincounter;

  UserModel(
      {this.name,
        this.email,
        this.password,
        this.imageURL,
        this.uid,
        this.loginState,
        this.wincounter
      });

  UserModel.fromJson2(Map<String, dynamic> json) {
    name = json['name'];
    wincounter = json['wincounter'];
    email = json['email'];
    password = json['password'];
    imageURL = json['imageURL'];
    uid = json['uid'];
    loginState = json['loginState'];
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        imageURL: json['imageURL'],
        loginState: json['loginState'],
        uid: json['uid'],
        wincounter : json['wincounter'],
        name: json['name'],
        email: json['email'],
        password: json['password']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['imageURL'] = this.imageURL;
    data['uid'] = this.uid;
    data['loginState'] = this.loginState;
    data['wincounter'] = this.wincounter;
    return data;
  }
}
