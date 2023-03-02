import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta1/Screens/SignUpScreen.dart';
import 'package:insta1/resources/Auth_Fun.dart';
import 'package:insta1/responsive/mobile_Screen_Layout.dart';
import 'package:insta1/responsive/responsive_screen_layout.dart';
import 'package:insta1/responsive/web_Screen_layout.dart';
import 'package:insta1/utils/AppBar.dart';
import 'package:insta1/utils/Login_SignUp_Button.dart';
import 'package:insta1/utils/TextButton_SignUp.dart';
import 'package:insta1/utils/Text_Fields.dart';
import 'package:insta1/utils/costum_Colors.dart';
import 'package:sign_button/sign_button.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  var _auth = FirebaseAuth.instance;
  var _isLoading = false;
  var res;

  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
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
              _isLoading == true ? Center(
                child: LinearProgressIndicator(color: Colors.blue),
              ):Container(),
              Center(
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: ExactAssetImage("assets/ins.png"),
                          fit: BoxFit.fill)),
                ),
              ),
              //TODO: Get User Email Input
              Text_Field_Input(
                  textInputType: TextInputType.emailAddress,
                  controller: _emailTextController,
                  hintText: "Enter your Email",
                  isPassword: false),

              //TODO: Get User Password Input
              Text_Field_Input(
                  textInputType: TextInputType.text,
                  controller: _passwordTextController,
                  hintText: "Enter your Password",
                  isPassword: true),

              //TODO: Press Login Button
              
                  login_signUp_Button("Login", Colors.purple, () async {
                      print("Login Button clicked");

                      setState(() {
                        _isLoading = true;
                      });
                   var res = await Auth_Method().signInUser(
                          email: _emailTextController.text.trim(),
                          password: _passwordTextController.text.trim(),
                          context: context);

                        if(res == "Success"){
                          setState(() {
                            _isLoading = false;
                          });
                        }else{
                          setState(() {
                            _isLoading = false;
                          });
                        }

                    }),
                 
              //TODO: Go to SignUp Screen

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child:
                    textButton_SignUp("Do you have an account?", " SignUp", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUp_Screen(),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
