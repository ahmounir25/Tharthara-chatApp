import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/modules/connector.dart';
import 'package:untitled1/modules/createAccount/createAccount_vm.dart';

class createAccountScreen extends StatefulWidget  {
  static const String routeName = 'createAccount';

  @override
  State<createAccountScreen> createState() => _createAccountScreenState();
}

class _createAccountScreenState extends State<createAccountScreen> implements connector{
  GlobalKey<FormState> FormKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passController = TextEditingController();

  CreateAccount_vm View_Model = CreateAccount_vm();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    View_Model.connect=this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        View_Model;
      },
      child: Stack(
        children: [
          Image.asset(
            'assets/images/bg.png',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(
                'Create Account',
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  key: FormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: "First Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue),
                            )),
                        validator: (value) {
                          if (value == null || value!.isEmpty) {
                            return "Please Enter first Name ...";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: "Last Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue),
                            )),
                        validator: (value) {
                          if (value == null || value!.isEmpty) {
                            return "Please Enter last Name ...";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: "User Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue),
                            )),
                        validator: (value) {
                          if (value == null || value!.isEmpty) {
                            return "Please Enter User Name ...";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: "E-mail",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue),
                            )),
                        validator: (value) {
                          final bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value!);
                          if (value == null ||
                              value!.isEmpty ||
                              emailValid == false) {
                            return "Please Enter Email ...";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: passController,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue),
                            )),
                        validator: (value) {
                          if (value == null || value!.isEmpty) {
                            return "Please Enter Password ...";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            createAccount();
                          },
                          child: Text('Sign UP'))
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  void createAccount() async {
    if (FormKey.currentState!.validate()) {
      View_Model.createAccount(emailController.text, passController.text);
    }
  }

  @override
  void hideLoadind() {
    Navigator.pop(context);
  }

  @override
  void showLoading() {
    showDialog(context: context, builder:(context) {
      return AlertDialog(
        title: Center(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
            CircularProgressIndicator(),
            Text('Loading...'),
          ]),
        ),
      );
    },);
  }

  @override
  void showMessage(String message) {
    showDialog(context: context, builder:(context) {
      return AlertDialog(
        title: Center(
          child: Row(children: [
            Text('$message'),
          ]),
        ),
      );
    },);
  }
}
