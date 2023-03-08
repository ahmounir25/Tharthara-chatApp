import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
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

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<User?> user;

  void initState() {
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
      initialRoute:FirebaseAuth.instance.currentUser == null ? LoginScreen.routeName :homeScreen.routeName,
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

