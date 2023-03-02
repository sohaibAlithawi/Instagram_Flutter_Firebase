import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta1/model/User.dart';
import 'package:insta1/provider/user_Provider.dart';
import 'package:insta1/utils/AppBar.dart';
import 'package:insta1/widgets/post_card.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_Bar_Const("", false, ""),
      body: StreamBuilder(
        stream: _firestore.collection("Posts").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("Connection is in waiting");
            return const Center(
              child: CircularProgressIndicator(color: Colors.blue,),
            );
          } else {
            if (snapshot.hasData) {
              print("snapshot has data to show${snapshot.data}");
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => PostCard(
                  snap: snapshot.data!.docs[index].data(),
                ),
              );
            }
           else{
             print("There is not data to show");
              return  Center(
                child: Text(
                  "There is no Posts to show",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              );

            }
          }
        },
      ),
    );
  }
}
