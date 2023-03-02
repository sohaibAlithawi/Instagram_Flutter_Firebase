import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta1/provider/user_Provider.dart';
import 'package:insta1/resources/firestore_methods.dart';
import 'package:insta1/utils/AppBar.dart';
import 'package:insta1/utils/utlis.dart';
import 'package:provider/provider.dart';

import '../model/User.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  @override
  void dispose() {
    super.dispose();

    _description.dispose();
  }

  var file;
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _description = TextEditingController();
  var userName;
  var profileImage;
  var userId;
  var _isLoading = false;
  var res;

  postImage(String uid, String username, String profImage) async {
    try {
      setState(() {
        _isLoading = true;
      });

      if (_description.text.isNotEmpty) {
        res = await FireStoreMethods()
            .uploadPost(file, _description.text, uid, username, profImage);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Please fill the description"),
          ),
        );
      }
      if (res == 'Success') {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Posted!"),
          ),
        );

        setState(() {
          file = null;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Not Posted!"),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${error.toString()}"),
        ),
      );
    }
  }

  _selectImage(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(

            title: Text("Create Post"),
            children: [
              //TODO: Choose the image from Gallery
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: const [
                    Icon(Icons.image),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Choose from Gallery",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  var imageSource = await pickImage(ImageSource.gallery);
                  setState(() {
                    file = imageSource;
                  });
                },
              ),

              //TODO: Take photo from Camera
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: const [
                    Icon(Icons.camera_alt),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Take photo from Camera",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  var imageSource = await pickImage(ImageSource.camera);
                  setState(() {
                    file = imageSource;
                  });
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    user userData = Provider.of<userProvider>(context).getUser;
    return file == null
        ? Center(
            child: IconButton(
              onPressed: () {
                _selectImage(context);
              },
              icon: Icon(Icons.upload),
            ),
          )
        : Scaffold(
            appBar: app_Bar_Const("Add Post", false, "Post", () {
              postImage(userData.uid, userData.userName, userData.profImageUrl);
            }),
            body: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  _isLoading
                      ? const Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: LinearProgressIndicator(color: Colors.blue,),
                        )
                      : Container(),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Transform.translate(
                            offset: Offset(0, -10),
                            child: CircleAvatar(
                              child: ImageNetwork(
                                image: userData.profImageUrl,
                                height: 45,
                                width: 45,
                                duration: 1500,
                                fitAndroidIos: BoxFit.cover,
                                fitWeb: BoxFitWeb.cover,
                                borderRadius: BorderRadius.circular(20),
                                onLoading: const CircularProgressIndicator(
                                  color: Colors.indigoAccent,
                                ),
                                onError: const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: TextField(
                              controller: _description,
                              decoration: InputDecoration(
                                hintText: "Write a caption",
                                border: InputBorder.none,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 45,
                        height: 45,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill, image: MemoryImage(file!)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
