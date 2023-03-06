import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled1/base.dart';
import 'package:untitled1/modules/createAccount/connector.dart';
import 'connector.dart';

class CreateAccount_vm extends BaseViewModel<createAccountNavigator> {

  void createAccount(String email, String pass)async{
    try {
      navigator?.showLoading();
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      navigator?.hideDialog();
      navigator?.showMessage('Account Created Successfully');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        navigator?.hideDialog();
        navigator?.showMessage('The password provided is too weak.');
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        navigator?.hideDialog();
        navigator?.showMessage('The account already exists for that email.');
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

}