import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta1/utils/AppBar.dart';
import 'package:insta1/widgets/commentCard.dart';
import 'package:insta1/widgets/enterCommentCard.dart';

class CommentPage extends StatefulWidget {
  final snap;
  CommentPage({required this.snap});
  @override
  State<CommentPage> createState() => _CommentPage();
}

class _CommentPage extends State<CommentPage> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_Bar_Const("Comment", false, ""),
      body: Column(children: [
        Container(
            width: double.infinity,
            height: 640,
            child: StreamBuilder(
              stream: _firestore
                  .collection('Posts')
                  .doc(widget.snap['postId'])
                  .collection('Comments')
                  .snapshots(),
              builder: (context, snapshot) {
                if (ConnectionState == ConnectionState.waiting) {
                 return Center(
                    child: CircularProgressIndicator(color: Colors.blue),
                  );
                } else {
                   print("The Connection State is active");

                }
                
                  return snapshot.hasData? ListView.builder(
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      itemBuilder: (context, index) {
                      return CommentCard(
                          snap: snapshot.data!.docs[index].data(),
                        );
                      }):Center(child: Text("no comments to show"),);
               
              },
            ),
           ),
        EnterCommentCard(
          snap: widget.snap,
        ),
      ]),
    );
  }
}
