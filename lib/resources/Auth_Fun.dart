import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta1/model/User.dart';
import 'package:insta1/model/posts.dart';
import 'package:insta1/provider/posts_Provider.dart';
import 'package:insta1/resources/storage_methods.dart';
import 'package:insta1/responsive/mobile_Screen_Layout.dart';
import 'package:insta1/responsive/responsive_screen_layout.dart';

import '../Screens/Login_Screen.dart';
import '../responsive/web_Screen_layout.dart';

class Auth_Method {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var userUid;
  user? userSnap;
  var postSnap;
  getUserDetails()async{
    var currentUser = _auth.currentUser!;

    DocumentSnapshot snap = await _firestore.collection("Users").doc(currentUser.uid).get();
    return userSnap = user.fromSnap(snap);
  }

  getUserPostDetails()async{

    var snap = await _firestore.collection("Posts").get();
    return postSnap = posts_model.fromPostSnap(postSnap);
  }

  Future<String> singUpUser({
    required var userName,
    required var email,
    required var password,
    required var bio,
    required var context,
    required var file,
  }) async {
    var result = "Error were found";

    try {
      if (userName.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          bio.isNotEmpty &&
          file != null) {
        //TODO: Create User
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print("${cred.user!.uid}");
        userUid = cred.user!.uid;
        //TODO Adding the User to the database

        var photoUrl = await StorageMethods()
            .uploadImageToStorage(file, false, 'profileImages');

        var userMap = user(
            userName: userName,
            email: email,
            profImageUrl: photoUrl,
            bio: bio,
            followers: [],
            following: [],
            uid: userUid);

        await _firestore.collection("Users").doc(cred.user!.uid).set(
              userMap.toJson(),
            );

        result = "Success";
      }else{
        result = "The operation is not Success";
      }
    } on FirebaseAuthException catch (err) {
      FirebaseAuthExceptionFun(err, context);
    }

    return result;
  }

  FirebaseAuthExceptionFun(FirebaseAuthException error, BuildContext context) {
    if (error.code == 'invalid-email') {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: "Error",
          confirmBtnText: "Close",
          confirmBtnColor: Colors.amber,
          animType: CoolAlertAnimType.slideInDown,
          text: "You have Entered invalid email");
    } else if (error.code == 'weak-password') {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.warning,
          title: "Error",
          confirmBtnText: "Close",
          confirmBtnColor: Colors.amber,
          animType: CoolAlertAnimType.slideInDown,
          text: "You have Entered week password");
    } else if (error.code == 'email-already-in-use') {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.info,
          title: "Error",
          confirmBtnText: "Close",
          confirmBtnColor: Colors.amber,
          animType: CoolAlertAnimType.slideInDown,
          text: "You email is already in use try to SignIn!");
    } else if (error.code == 'user-disabled') {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.info,
          title: "Error",
          confirmBtnText: "Close",
          confirmBtnColor: Colors.amber,
          animType: CoolAlertAnimType.slideInDown,
          text: "You email is already in use try to SignIn!");
    } else if (error.code == 'wrong-password') {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.info,
          title: "Info",
          confirmBtnText: "Close",
          confirmBtnColor: Colors.amber,
          animType: CoolAlertAnimType.slideInDown,
          text: "You have entered wrong password");
    } else if (error.code == 'user-not-found') {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.warning,
          title: "Warning",
          confirmBtnText: "Close",
          confirmBtnColor: Colors.amber,
          animType: CoolAlertAnimType.slideInDown,
          text: "User not found");
    }
  }

  dynamic signInUser(
      {required String email,
      required String password,
      required var context}) async {
    var result;
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential cred = await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        //TODO: Just to check if the user has been create or not
        print("${cred.user!.uid}");

        result = "Success";
      }else{
        result = "The opeartion is not success";
      }
    } on FirebaseAuthException catch (error) {
       FirebaseAuthExceptionFun(error, context);
    }
    return result;
  }
}
