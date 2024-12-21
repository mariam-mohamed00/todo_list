import 'package:app_todo_list/model/my_user.dart';
import 'package:flutter/material.dart';

class UserAuthProvider extends ChangeNotifier {
  MyUser? currentuser;

  void updateUser(MyUser newUser) {
    currentuser = newUser;
    notifyListeners();
  }
}
