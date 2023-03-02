import 'package:flutter/cupertino.dart';
import 'package:insta1/model/User.dart';
import 'package:insta1/resources/Auth_Fun.dart';

class userProvider with ChangeNotifier{

  user? _user;
  final Auth_Method  _auth_method = Auth_Method();
  user get getUser => _user!;

  refreshUser()async{
    var user = await _auth_method.getUserDetails();
    _user= user;
    notifyListeners();
  }
}