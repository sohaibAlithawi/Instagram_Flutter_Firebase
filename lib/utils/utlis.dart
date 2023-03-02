import 'dart:io';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async{

  final ImagePicker _imagePicker = ImagePicker();

   var file = await _imagePicker.pickImage(source: source);

   if (file !=null){
    return await file.readAsBytes();
   }
   else{
     print("No image selected");
   }
}