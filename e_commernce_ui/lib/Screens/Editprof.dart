import 'dart:io';
import 'dart:math';

import 'package:e_commernce_ui/Data/AuthClass.dart';
import 'package:e_commernce_ui/Data/FilesUploadService.dart';
import 'package:e_commernce_ui/Data/SearchModel.dart';
import 'package:e_commernce_ui/Data/UserModel.dart';
import 'package:e_commernce_ui/Route.dart';
import 'package:e_commernce_ui/Data/Sharedprefs.dart';
import 'package:e_commernce_ui/Data/api.dart';
import 'package:e_commernce_ui/Data/model.dart';
import 'package:e_commernce_ui/widgetsui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


class HomeProfileScreen extends StatefulWidget {
  const HomeProfileScreen({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  _HomeProfileScreenState createState() => _HomeProfileScreenState();
}

class _HomeProfileScreenState extends State<HomeProfileScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final UserService _userService = UserService();
  final FilesUploadService filesUploadService = FilesUploadService();
  UserModel? _userModel;
  bool showPassword = false;
  File? file;
  ImagePicker imagePicker = ImagePicker();
  String? imageURL ;
  String staticImage = 'https://static.wikia.nocookie.net/leagueoflegends/images/7/7d/00_Reactivated_profileicon.png/revision/latest?cb=20170505005452';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _userService.getUser(widget.id),
      builder: (ctx, snapshot) {
        var data = snapshot.data;

        if (data == null) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        _userModel = data as UserModel;
        _name.text = _userModel!.name!;
        _email.text = _userModel!.email!;
        //showPass? _userModel!.password! : '*****'
        _password.text = _userModel!.password!;

        //fill null --> model : url
        //fill not null
        ImageProvider? image = (file == null
            ? NetworkImage(_userModel!.imageURL!.isNotEmpty
            ? _userModel!.imageURL!
            : staticImage)
            : FileImage(file!)) as ImageProvider<Object>;

        return Scaffold(
          appBar: AppBar(
            title: Text('welcome ${_userModel!.name}'),
          ),
          body: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          var result = await showDialog(
                              context: context,
                              builder: (context) {
                                return SimpleDialog(
                                  title: Text('Chose your image option.'),
                                  children: [

                                    Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          SimpleDialogOption(
                                            child: Text(
                                              'Change your image',
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context, true);
                                            },
                                          ),
                                          SimpleDialogOption(
                                            child: Divider(),
                                            onPressed: () {},
                                          ),
                                          SimpleDialogOption(
                                            child: Text(
                                              'View your image',
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context, false);
                                            },
                                          ),
                                        ],
                                      ),

                                  ],
                                );
                              });
                          //actions
                          if (result != null) {
                            if (result) {
                              //change image
                              await chooseImage();
                              if (file != null) {
                                imageURL = await filesUploadService
                                    .fileUpload(file!, 'UserProfileImage')
                                    .whenComplete(() {
                                  print("User Image Changed");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Your Profile Image is changed")));
                                });
                              }
                            } else {
                              //view image

                              Navigator.of(context).pushNamed(imageViewer,
                                  arguments: _userModel!.imageURL!.isNotEmpty
                                      ? _userModel!.imageURL!
                                      : staticImage);
                            }
                          }
                        },
                        child: CircleAvatar(
                          //image
                          backgroundImage: image,
                          maxRadius: 50,
                          minRadius: 25,
                        ),
                      ),
                      TextButton(
                        child: Text('Update'),
                        onPressed: () async {
                          if (imageURL!.isNotEmpty) {
                            _userModel!.imageURL = imageURL;
                            await _userService
                                .updateUser(widget.id, _userModel!)
                                .whenComplete(() {
                              print('Image Updated');
                            });
                          }
                        },
                      )
                    ],
                  )),
              Expanded(
                flex: 1,
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: TextFormField(
                    controller: _name,
                    maxLines: 1,
                    autofocus: false,
                    decoration: InputDecoration(
                        hintText: 'Name',
                        icon: Icon(
                          Icons.person,
                          color: Colors.grey,
                        )),
                    validator: (value) =>
                    value!.isEmpty ? 'Name can\'t be empty' : null,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: TextFormField(
                    enabled: false,
                    controller: _email,
                    maxLines: 1,
                    autofocus: false,
                    decoration: InputDecoration(
                        hintText: 'Email',
                        icon: Icon(
                          Icons.email,
                          color: Colors.grey,
                        )),
                    validator: (value) =>
                    value!.isEmpty ? 'Email can\'t be empty' : null,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: TextFormField(
                    controller: _password,
                    maxLines: 1,
                    obscureText: true,
                    autofocus: false,
                    decoration: InputDecoration(
                        hintText: 'Email',
                        icon: Icon(
                          Icons.email,
                          color: Colors.grey,
                        )),
                    validator: (value) =>
                    value!.isEmpty ? 'Email can\'t be empty' : null,
                  ),
                ),
              ),
              ElevatedButton(
                child: Text('Update'),
                onPressed: () async {
                  var model = UserModel(
                      uid: widget.id,
                      loginState: _userModel!.loginState,
                      imageURL: _userModel!.imageURL,
                      password: _password.text,
                      email: _email.text,
                      name: _name.text,
                    wincounter: _userModel!.wincounter,


                  );
                  await _userService
                      .updateUser(widget.id, model)
                      .whenComplete(() {
                    print('Data Updated');
                  });
                },
              )
            ],
          ),
        );
      },
    );
  }

  chooseImage() async {
    final pickedImage = await imagePicker.getImage(source: ImageSource.gallery);
    if (pickedImage!.path.isEmpty) {
      //lost data : old data
      retrieveLostData();
    } else {
      setState(() {
        file = File(pickedImage.path);
      });
    }
  }

  Future<void> retrieveLostData() async {
    final LostData result = await imagePicker.getLostData();
    if (result.file == null) {
      print("Null LOST DATA");
    } else {
      setState(() {
        file = File(result.file!.path);
      });
    }
  }
}


class ImageViewerScreen extends StatefulWidget {
  const ImageViewerScreen({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image.network(
          widget.url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}