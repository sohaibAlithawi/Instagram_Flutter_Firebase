import 'package:flutter/material.dart';

import 'costum_Colors.dart';
app_Bar_Const(String title, var centerTitle, String iconText, [var onPress]) {
  return AppBar(
    title: title.isEmpty
        ? Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage("assets/ins.png"),
              ),
            ),
          )
        : Transform.translate(offset: Offset(-20,0),child: Text("$title")),
        
    centerTitle: centerTitle,
    backgroundColor: mobileBackgroundColor,
    actions: [
      Padding(
        padding: EdgeInsets.only(right: 10),
        child: iconText.isEmpty
            ? Icon(Icons.message_outlined)
            : Center(
                child: TextButton(
                  onPressed: onPress,
                  child: Text(
                    "$iconText",
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
      ),
    ],
  );
}
