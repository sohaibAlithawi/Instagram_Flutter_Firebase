

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta1/Screens/add_post.dart';
import 'package:insta1/Screens/feed_screen.dart';

import '../Screens/feed_screen.dart';

var webScreenSize = 600;

var homeScreenItems =[
    FeedScreen(),
    Text("Search"),
    AddPost(),
    Text("favourite"),
    TextButton(onPressed: (){FirebaseAuth.instance.signOut();}, child: Text("SignOut"))

];