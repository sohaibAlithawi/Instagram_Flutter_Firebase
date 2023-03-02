import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta1/Screens/Login_Screen.dart';
import 'package:insta1/main.dart';
import 'package:insta1/resources/Auth_Fun.dart';
import 'package:insta1/responsive/mobile_Screen_Layout.dart';
import 'package:insta1/responsive/responsive_screen_layout.dart';
import 'package:insta1/responsive/web_Screen_layout.dart';
import 'package:insta1/utils/utlis.dart';

import '../utils/Login_SignUp_Button.dart';
import '../utils/TextButton_SignUp.dart';
import '../utils/Text_Fields.dart';

class SignUp_Screen extends StatefulWidget {
  const SignUp_Screen({Key? key}) : super(key: key);

  @override
  State<SignUp_Screen> createState() => _SignUp_ScreenState();
}

class _SignUp_ScreenState extends State<SignUp_Screen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  var _image;
  var _loading = false;

  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _userNameTextController.dispose();
    _bioController.dispose();
  }

  void selectImage() async {
    var im = await pickImage(ImageSource.gallery);

    setState(() {
      _image = im;
    });
    setState(() {
      _loading = false;
    });
  }

  signUpProcess() async {
    if (_image != null) {
      print("All fields are not empty");
      setState(() {
        print("loading true");
        _loading = true;
      });
      var res = await Auth_Method().singUpUser(
          userName: _userNameTextController.text,
          email: _emailTextController.text,
          password: _passwordTextController.text,
          bio: _bioController.text,
          context: context,
          file: _image!);

      if (res == "Success") {
        setState(() {
          print("loading is false");
          _loading = false;
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyApp(),
          ),
        );
      } else {
        setState(() {
          print("loading is false 2");
          _loading = false;
        });
      }

      print("$res");
    } else {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: "Error",
          confirmBtnText: "Close",
          confirmBtnColor: Colors.amber,
          animType: CoolAlertAnimType.slideInDown,
          text: "Please fill all fields and select image");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _loading == true
                  ? const Center(
                      child: LinearProgressIndicator(
                        color: Colors.blue,
                      ),
                    )
                  : Container(),
              Center(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: ExactAssetImage("assets/ins.png"),
                        fit: BoxFit.fill),
                  ),
                ),
              ),
              //TODO: Add avatar image
              InkWell(
                onTap: () {
                  print("Add profile image ");
                  selectImage();
                },
                child: Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image),
                          )
                        : const CircleAvatar(
                            radius: 64,
                            backgroundImage:
                                ExactAssetImage("assets/profile_image.png"),
                          ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: () {
                          print("Add profile image ");
                          selectImage();
                        },
                        icon: const Icon(Icons.camera_alt),
                      ),
                    )
                  ],
                ),
              ),

              //TODO: Get UserName Input
              Text_Field_Input(
                  textInputType: TextInputType.text,
                  controller: _userNameTextController,
                  hintText: "Enter your userName",
                  isPassword: false),

              //TODO: Get Email Input
              Text_Field_Input(
                  textInputType: TextInputType.text,
                  controller: _emailTextController,
                  hintText: "Enter your Email",
                  isPassword: false),

              //TODO: Get Password Input
              Text_Field_Input(
                  textInputType: TextInputType.text,
                  controller: _passwordTextController,
                  hintText: "Enter your Password",
                  isPassword: true),

              //TODO: Get Bio Input
              Text_Field_Input(
                  textInputType: TextInputType.text,
                  controller: _bioController,
                  hintText: "Enter your Bio",
                  isPassword: false),

              //TODO: Press SignUp Button

              login_signUp_Button("SingUp", Colors.purple, () async {
                print("Login Button clicked");
                signUpProcess();

                // ignore: use_build_context_synchronously
              }),
              //TODO: Back to Login Screen

              SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: textButton_SignUp(
                    "Do you have already an account?", " Login", () {
                  Navigator.pop(context);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
