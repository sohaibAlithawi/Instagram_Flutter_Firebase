import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:insta1/Screens/commentPage.dart';
import 'package:insta1/provider/user_Provider.dart';
import 'package:insta1/resources/firestore_methods.dart';
import 'package:insta1/utils/costum_Colors.dart';
import 'package:provider/provider.dart';

import '../model/User.dart';
import 'like_Animation.dart';

class PostCard extends StatefulWidget {
  final snap;
  PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;

  @override
  Widget build(BuildContext context) {
    user userData = Provider.of<userProvider>(context).getUser;

    return Center(
      child: Column(
        children: [
          //TODO: Adding user image with the name
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Transform.translate(
                offset: Offset(-10, -5),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.network(
                            widget.snap['profImage'],
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(-10, 10),
                      child: Padding(
                        padding: EdgeInsets.only(right: 50),
                        child: Text(
                          "${widget.snap['username']}",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<_menuValues>(
                icon: Icon(Icons.more_vert),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    child: Text("Delete"),
                    value: _menuValues.Delete,
                  ),
                ],
                onSelected: (value) {
                  switch (value) {
                    case _menuValues.Delete:
                      print("Post Delete button clicked");
                  }
                },
              ),
            ],
          ),

          //TODO: User Post Image
          GestureDetector(
            onDoubleTap: () async {
              await FireStoreMethods().likePost(
                  widget.snap['postId'], userData.uid, widget.snap['like']);

              setState(() {
                isLikeAnimating = true;
              });
              print("IsLikeAnimating = true");
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  widget.snap['photoUrl'],
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.fill,
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 100,
                    ),
                    isAnimating: isLikeAnimating,
                    duration: const Duration(milliseconds: 400),
                    onEnd: () {
                      setState(() {
                        isLikeAnimating = false;
                      });
                      print("IsLikeAnimating = false");
                    },
                  ),
                ),
              ],
            ),
          ),
          //TODO: Adding Like,Comment,Send,Save Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  LikeAnimation(
                    isAnimating: widget.snap['likes'] == userData.uid,
                    smallLike: true,
                    child: IconButton(
                      onPressed: () async {
                        await FireStoreMethods().small_LikePost(
                            widget.snap['postId'],
                            userData.uid,
                            widget.snap['like']);
                      },
                      icon: widget.snap['like'].contains(userData.uid)
                          ? Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : Icon(Icons.favorite_border_outlined),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommentPage(snap: widget.snap,),
                        ),
                      );
                    },
                    icon: Icon(Icons.comment),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.send),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.bookmark_border),
              ),
            ],
          ),

          //TODO: View Likes, Comment Count & View Description , Date
          Padding(
            padding: EdgeInsets.only(left: 12, top: 5),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${widget.snap['like'].length} Likes'),
                  SizedBox(
                    height: 5,
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: primaryColor),
                      children: [
                        TextSpan(
                          text: "${widget.snap['username']} ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: "${widget.snap['description']}",
                        ),
                      ],
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(-8, 0),
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "View all 200 comment",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  //Text(widget.snap['datePublished']),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

enum _menuValues {
  Delete;
}
