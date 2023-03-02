
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
class StorageMethods{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

   uploadImageToStorage(Uint8List file, bool isPost, String childName)async{

     var ref = _storage.ref().child(childName).child(_auth.currentUser!.uid);

     if(isPost){
       var id = Uuid().v1();
      ref =ref.child(id);
     }

    var uploadTask = ref.putData(file);
    var snap = await uploadTask;
    var downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
   }
}