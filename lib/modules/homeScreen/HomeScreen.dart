import 'package:flutter/material.dart';
import 'package:untitled1/base.dart';
import 'package:untitled1/modules/homeScreen/homeScreen_Navigator.dart';
import 'package:untitled1/modules/homeScreen/homeScreen_VM.dart';
import 'package:untitled1/modules/login/loginScreen.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);
  static const String routeName = 'Home';

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends BaseView<homeScreen_VM, homeScreen>
    implements homeScreenNavigator {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator=this;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home page'), centerTitle: true,
      actions: [
         IconButton(onPressed: () {
           Navigator.pushReplacementNamed(context, LoginScreen.routeName);
         }, icon:Icon(Icons.logout)),
      ]),
    );
  }

  @override
  homeScreen_VM init_VM() {
    return homeScreen_VM();
  }


}