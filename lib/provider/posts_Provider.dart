import 'package:flutter/foundation.dart';
import 'package:insta1/model/posts.dart';

class posts_provider with ChangeNotifier{

  posts_model? _post;
  posts_model get getPost => _post!;
  final _postFun = posts_provider();


}