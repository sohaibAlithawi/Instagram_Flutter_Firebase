import 'package:flutter/material.dart';

textButton_SignUp(var question_text, var signUp_Text, var onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child:  Text("$question_text"),
          padding: EdgeInsets.symmetric(
            vertical: 8
          ),
        ),
        Container(
          child: Text("$signUp_Text"),
          padding: EdgeInsets.symmetric(
            vertical: 8,
          ),
        )
      ],

    ),
  );
}
