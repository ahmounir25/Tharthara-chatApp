import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/modules/createAccount/createAccount.dart';
import 'package:untitled1/modules/createRoom/createRoomScreen.dart';
import 'package:untitled1/modules/homeScreen/HomeScreen.dart';
import 'package:untitled1/modules/login/loginScreen.dart';
import 'package:untitled1/providers/userProvider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (context) => UserProvider(), child: MyApp()));//initial fireBase before run App

}

class MyApp extends StatelessWidget {
  @override
  // State<MyApp> createState() => _MyAppState();

  late StreamSubscription<User?> user;

  void initState() {

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

  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return MaterialApp(
      home: LoginScreen(),
      initialRoute: provider.userAuth == null
          ? LoginScreen.routeName
          : homeScreen.routeName,
      routes: {
        createAccountScreen.routeName:(context) => createAccountScreen(),
        LoginScreen.routeName:(context) => LoginScreen(),
        homeScreen.routeName:(context) => homeScreen(),
        createRoomScreen.routeName:(context) => createRoomScreen(),
      },
      // home:createAccountScreen(),
      debugShowCheckedModeBanner: false,

    );
  }
}

