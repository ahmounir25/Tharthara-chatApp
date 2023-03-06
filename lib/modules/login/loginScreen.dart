import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/base.dart';
import 'package:untitled1/modules/login/login_vm.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String routeName='LogIn';

  @override
  State<LoginScreen> createState() => _LoginScreenState();

}

class _LoginScreenState extends BaseView<login_vm, LoginScreen> {
  GlobalKey<FormState> FormKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) {
          return viewModel;
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
                    'LogIn',
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
                                textInputAction: TextInputAction.next,
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
                                  ValidateForm();
                                  },
                                  child: Text('LogIn'))
                            ]))))
          ],
        ));
  }
  void ValidateForm(){
    if(FormKey.currentState?.validate()==true){
      viewModel.login(emailController.text,passController.text);
    }
  }

  @override
  init_VM() {
    return login_vm();
  }
}
