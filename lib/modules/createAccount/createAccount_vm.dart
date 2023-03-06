import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/modules/connector.dart';
import 'package:untitled1/modules/connector.dart';
import 'package:untitled1/modules/connector.dart';

import '../connector.dart';

class CreateAccount_vm extends ChangeNotifier {
  late connector connect;
  void createAccount(String email, String pass)async{
    try {
      connect.showLoading();
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      connect.hideLoadind();
      connect.showMessage('Account Created Successfully');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        connect.hideLoadind();
        connect.showMessage('The password provided is too weak.');
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        connect.hideLoadind();
        connect.showMessage('The account already exists for that email.');
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

}