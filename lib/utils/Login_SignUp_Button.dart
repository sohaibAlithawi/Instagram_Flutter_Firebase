import 'package:flutter/material.dart';

login_signUp_Button(var button_Text, var button_Color, var button_onTap) {
  return Padding(
    padding: EdgeInsets.only(top: 10),
    child: SizedBox(
      width: 200,
      height: 40,
      child: ElevatedButton(
        onPressed: button_onTap,
        child: Text("${button_Text}",style: TextStyle(fontSize: 18),),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(button_Color) ,
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    ),
  );
}
