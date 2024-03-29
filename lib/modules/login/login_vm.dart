import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/base.dart';
import 'package:untitled1/models/myUser.dart';
import 'package:untitled1/modules/login/loginNavigator.dart';
import 'package:untitled1/dataBase/dataBaseUtilities.dart';

class login_vm extends BaseViewModel<loginNavigator> {
  void login(String email, String pass) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      navigator?.showLoading();
      final  credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      //read User from dataBase

      myUser? myuser =
          await DataBaseUtils.readUserFromFirestore(credential.user?.uid ??"");
      navigator?.hideDialog();
      if (myuser != null) {
        navigator?.goHome(myuser);
      } else {
        navigator?.showMessage("No user found for This data");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        navigator?.hideDialog();
        navigator?.showMessage("No user found for that e mail.");
        // print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        navigator?.hideDialog();
        navigator?.showMessage("Wrong password provided for that user.");
        // print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
  }
}
