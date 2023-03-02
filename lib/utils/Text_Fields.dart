import 'package:flutter/material.dart';

class Text_Field_Input extends StatelessWidget {
  var controller;
  var hintText;
  var isPassword;
  var textInputType;
   Text_Field_Input(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.isPassword = false,
      required this.textInputType,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: inputBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          contentPadding: EdgeInsets.all(10),
          filled: true
        ),
        keyboardType: textInputType,
        obscureText: isPassword,
      ),
    );
  }
}
