import 'package:untitled1/base.dart';
import 'package:untitled1/models/myUser.dart';

abstract class loginNavigator extends BaseNavigator{
  void goHome(myUser user);
}