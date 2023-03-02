import 'package:cloud_firestore/cloud_firestore.dart';

class user {
  final String userName;
  final String email;
  final String profImageUrl;
  final String bio;
  final List followers;
  final List following;
  final String uid;

  user({
    required this.userName,
    required this.email,
    required this.profImageUrl,
    required this.bio,
    required this.followers,
    required this.following,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'email': email,
        'profImageUrl': profImageUrl,
        'bio': bio,
        'followers': [],
        'following': [],
        'userId': uid
      };

  static fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return user(
        userName: snapshot["userName"],
        email: snapshot["email"],
        profImageUrl: snapshot["profImageUrl"],
        bio: snapshot["bio"],
        followers: snapshot["followers"],
        following: snapshot["following"],
        uid: snapshot["userId"]);
  }
}
