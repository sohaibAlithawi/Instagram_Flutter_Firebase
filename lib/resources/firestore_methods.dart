import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta1/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  uploadPost(
    var file,
    var description,
    var uid,
    var username,
    var profImage,
  ) async {
    String result = "Error were found";
    try {
      var photoUrl = await StorageMethods()
          .uploadImageToStorage(file, true, "postsImages");
      String postId = const Uuid().v1();
      await _firestore.collection('Posts').doc(postId).set({
        'postId': postId,
        'description': description,
        'uid': uid,
        'photoUrl': photoUrl,
        'datePublished': DateTime.now(),
        'username': username,
        'profImage': profImage,
        'like': [],
      });
      result = "Success";
      print("$result");
    } catch (error) {
      result = error.toString();
      print("$result");
    }
    return result;
  }

  likePost(String postId, String uid, List like) async {
    try {
      if (!like.contains(uid)) {
        await _firestore.collection("Posts").doc(postId).update({
          'like': FieldValue.arrayUnion([uid]),
        });
      } else {
        print("Like field have allready the user uid:");
      }
    } catch (e) {
      print("${e.toString()}");
    }
  }

  small_LikePost(String postId, String uid, List like) async {
    try {
      if (like.contains(uid)) {
        await _firestore.collection("Posts").doc(postId).update({
          'like': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection("Posts").doc(postId).update({
          'like': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print("${e.toString()}");
    }
  }

  postComment(
      String postId, String text, String uid, String name, String profImage) async{
    try {
      if (text.isNotEmpty) {
        String commnetId = Uuid().v1();
       await _firestore
            .collection('Posts')
            .doc(postId)
            .collection('Comments')
            .doc(commnetId)
            .set({
          'postId': postId,
          'commentText': text,
          'userUid': uid,
          'userName': name,
          'profileImage': profImage,
          'date':DateTime.now()
        });
      } else {
        print("The comment is empty");
      }
    } catch (error) {
      print("Error was: ${error.toString()}");
    }
  }
}
