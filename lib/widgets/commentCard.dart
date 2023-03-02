import 'package:flutter/material.dart';
import 'package:insta1/provider/user_Provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CommentCard extends StatelessWidget {
  final snap;
  CommentCard({required this.snap});

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<userProvider>(context).getUser;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: EdgeInsets.only(bottom: 3),
        child: Card(
          child: Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            snap['profileImage'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${snap['userName']}",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text("${snap['commentText']}"),
                            Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                DateFormat.yMMMd().format(
                                  snap['date'].toDate(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
