import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/modules/createAccount/createAccount.dart';
import 'package:untitled1/modules/homeScreen/HomeScreen.dart';
import 'package:untitled1/modules/login/loginScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());//initial fireBase before run App

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginScreen.routeName,
      routes: {
        createAccountScreen.routeName:(context) => createAccountScreen(),
        LoginScreen.routeName:(context) => LoginScreen(),
        homeScreen.routeName:(context) => homeScreen(),
      },
      // home:createAccountScreen(),
      debugShowCheckedModeBanner: false,

    );
  }
}

