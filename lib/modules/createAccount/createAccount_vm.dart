import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled1/base.dart';
import 'package:untitled1/dataBase/dataBaseUtilities.dart';
import 'package:untitled1/models/myUser.dart';
import 'package:untitled1/modules/createAccount/connector.dart';
import 'connector.dart';

class CreateAccount_vm extends BaseViewModel<createAccountNavigator> {
  void createAccount(String fName, String lName, String userName,
      String email, String pass) async {
    try {
      navigator?.showLoading();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      // add User to dataBase
      myUser user = myUser(
          id: credential.user?.uid ?? "",
          fName: fName,
          lName: lName,
          email: email,
          userName: userName);
      DataBaseUtils.addToFireStore(user);
      navigator?.hideDialog();
      navigator?.goHome();
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
