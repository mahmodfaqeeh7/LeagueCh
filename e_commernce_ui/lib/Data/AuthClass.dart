import 'dart:collection';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commernce_ui/Data/Sharedprefs.dart';
import 'package:e_commernce_ui/Data/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class UserService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late CollectionReference collectionReference;
  User? user;

  UserService() {
    collectionReference = _firestore.collection('users');
  }

  //sign in
  Future<String> signIn(String email, String password) async {
    //3-> 1: user --> uid , no user --> no uid 3 --> wrong pass
    var msg = '';
    try {
      var user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      msg = user.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        msg = "NO USER FOUND";
      } else if (e.code == 'wrong-password') {
        msg = "WRONG PASSWORD,TRY AGAIN";
      }
    }
    log(msg);
    await CacheHelper.saveData(key: "currentid", value: msg);
    return msg;
  }

  Future<String> signUp(HashMap userValues) async {
    String msg = '';
    try {
      var user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: userValues['email'], password: userValues['password']);
      msg = user.user!.uid;

      //add user firestore:
      //1: model
      var model = UserModel(
          name: userValues['name'],
          email: userValues['email'],
          password: userValues['password'],
          imageURL: userValues['imageURL'] ?? '',
          loginState: true,
          uid: user.user!.uid,
          wincounter: 0,
      );
      log("before adduser");

      await addUser(model);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        msg = "Weak Password";
        log(msg);
      } else if (e.code == 'email-already-in-use') {
        msg = "The account is already exists Try Sign in";
        log(msg);
      }
    }
    log(msg);
    await sendEmailVerification();
    await CacheHelper.saveData(key: "currentid", value: msg);
    return msg;
  }


  Future<void> addUser(UserModel model) async {

    await collectionReference.add(model.toJson()).catchError((e) {
      log("error accurds");
      log(e.toString());
    });
  }

  Future<UserModel> getUser(String id) async {
    QuerySnapshot result =
    await collectionReference.where('uid', isEqualTo: id).get();
    //doc -> json map --> model
    var data = result.docs[0];
    Map<String, dynamic> userMap = {};
    userMap['uid'] = data.get('uid');
    userMap['name'] = data.get('name');
    userMap['password'] = data.get('password');
    userMap['imageURL'] = data.get('imageURL');
    userMap['loginState'] = data.get('loginState');
    userMap['email'] = data.get('email');
    userMap['wincounter'] = data.get('wincounter');


    UserModel model = UserModel.fromJson(userMap);

    return model;
  }

  Future<void> updateUser(String id, UserModel userModel) async {
    QuerySnapshot result =
    await collectionReference.where('uid', isEqualTo: id).get();

    var docId = result.docs[0].id;

    await collectionReference.doc(docId).update(userModel.toJson());
  }

  Future<void> signInWihGoogle() async {
    //GoogleSignIn -> account --> auth --> credential --> _firebaseAuth.signInWithCredential -->MODEL
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount!.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);

    UserCredential userCredential =
    await _firebaseAuth.signInWithCredential(credential);
    user = userCredential.user;
    log(user!.isAnonymous.toString());
    log(await user!.getIdToken());
    //current user
    User? currentUser = _firebaseAuth.currentUser;
    var userModel = UserModel(
        name: currentUser!.displayName,
        email: currentUser.email,
        password: 'non',
        imageURL: currentUser.photoURL,
        loginState: true,
        uid: currentUser!.uid,
        wincounter: 0

    );
    await addUser(userModel).catchError((e) {
      log(e.toString());
    });
   await CacheHelper.saveData(key: "currentid", value: currentUser!.uid);
  }

  Future<void> sendEmailVerification() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }
  bool isEmailVerified() {
    User? user = _firebaseAuth.currentUser;
    return user != null && user.emailVerified;
  }


}