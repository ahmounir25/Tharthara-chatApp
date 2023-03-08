

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/models/myUser.dart';

import '../dataBase/dataBaseUtilities.dart';

class UserProvider extends ChangeNotifier {
  myUser? user;
  User? userAuth;

  UserProvider() {
    userAuth = FirebaseAuth.instance.currentUser;
    initMyUser();
  }

  void initMyUser() async {
    if (userAuth != null) {
      user = await DataBaseUtils.readUserFromFirestore(userAuth?.uid ?? "");
    }
  }
}