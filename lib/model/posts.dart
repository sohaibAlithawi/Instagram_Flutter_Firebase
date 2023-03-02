import 'package:cloud_firestore/cloud_firestore.dart';

class posts_model{
  var date;
  var postImageUrl;
  var description;

  posts_model({
    required this.date,
    required this.postImageUrl,
    required this.description,
  });


  static fromPostSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return posts_model(
        date: snapshot['datePublished'],
        postImageUrl: snapshot['photoUrl'],
        description: snapshot['description']);

  }
}