import 'package:flutter/material.dart';
import 'package:insta1/provider/user_Provider.dart';
import 'package:insta1/resources/firestore_methods.dart';
import 'package:insta1/utils/costum_Colors.dart';
import 'package:provider/provider.dart';

class EnterCommentCard extends StatefulWidget {
  final snap;
  EnterCommentCard({required this.snap});
  @override
  State<EnterCommentCard> createState() => _EnterCommentCardState();
}

class _EnterCommentCardState extends State<EnterCommentCard> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<userProvider>(context).getUser;

    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: SizedBox(
        width: double.infinity,
        height: 70,
        child: Card(
          color: mobileBackgroundColor,
          child: Row(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    userData.profImageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 50,
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    hintText: "Enter Comment ...",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                width: 90,
              ),
              TextButton(
                onPressed: () {
                  FireStoreMethods().postComment(
                      widget.snap['postId'],
                      _commentController.text,
                      userData.uid,
                      userData.userName,
                      userData.profImageUrl);

                      setState(() {
                        _commentController.text ="";
                      });
                },
                child: Text("Send"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
