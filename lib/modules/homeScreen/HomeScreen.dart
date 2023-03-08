import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/base.dart';
import 'package:untitled1/modules/createRoom/createRoomScreen.dart';
import 'package:untitled1/modules/homeScreen/homeScreen_Navigator.dart';
import 'package:untitled1/modules/homeScreen/homeScreen_VM.dart';
import 'package:untitled1/modules/homeScreen/roomWidget.dart';
import 'package:untitled1/modules/login/loginScreen.dart';

import '../../providers/userProvider.dart';

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
    viewModel.navigator = this;
    viewModel.getRoom();
  }

  @override
  Widget build(BuildContext context) {
    // var provider = Provider.of<UserProvider>(context);
    return ChangeNotifierProvider(
       create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(title: Text('Home page'), centerTitle: true, actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              icon: Icon(Icons.logout)),
        ]),
          body: Container(
            padding: const EdgeInsets.all(16.0),
            margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
            child: Consumer<homeScreen_VM>(
              builder: (_, homeVM, c) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 1),
                  itemBuilder: (context, index) {
                    return roomWidget(homeVM.rooms[index]);
                  },
                  itemCount: homeVM.rooms.length,
                );
              },
            ),
          ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, createRoomScreen.routeName);
            },
            child: Icon(Icons.add)),
      ),
    );
  }

  @override
  homeScreen_VM init_VM() {
    return homeScreen_VM();
  }
}
