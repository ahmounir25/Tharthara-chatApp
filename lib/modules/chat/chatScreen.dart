import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/base.dart';
import 'package:untitled1/dataBase/dataBaseUtilities.dart';
import 'package:untitled1/models/message.dart';
import 'package:untitled1/modules/chat/chatNavigator.dart';
import 'package:untitled1/modules/chat/chatVM.dart';
import 'package:untitled1/providers/userProvider.dart';

import '../../models/Room.dart';
import 'messageWidget.dart';

class chatScreen extends StatefulWidget {
  static const String routeName = 'chat';

  @override
  State<chatScreen> createState() => _chatScreenState();
}

class _chatScreenState extends BaseView<chatVM, chatScreen>
    implements chatNavigator {
  var msgController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel!.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var room = ModalRoute
        .of(context)!
        .settings
        .arguments
    as Room; //receive push navigator arguments
    var provider = Provider.of<UserProvider>(context);
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
            // resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(
                room.roomName,
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Container(
              padding: const EdgeInsets.all(8.0),
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black54,
                      blurRadius: 10,
                      spreadRadius: 5,
                      blurStyle: BlurStyle.outer)
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Expanded(
                      child: StreamBuilder<QuerySnapshot<Message>>(
                          stream: DataBaseUtils.getMessageFromFirebase(room.id),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Text('Some Thing went Wrong ...');
                            }
                            var messages = snapshot.data?.docs
                                .map((e) => e.data())
                                .toList();
                            return ListView.builder(
                              itemBuilder: (context, index) {
                                return messageWidget(messages![index]);
                              },
                              itemCount: messages?.length ?? 0,
                            );
                          })),
                  Row(children: [
                    Expanded(
                      child: TextFormField(
                          controller: msgController,
                          decoration: InputDecoration(
                              hintText: "type a message ...",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(12),
                                      topLeft: Radius.circular(12))))),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * .097,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * .2,
                      child: ElevatedButton(
                          onPressed: () {
                            viewModel.sendMessage(
                                msgController.text, room.id, provider.user!);
                          },
                          child: Icon(Icons.send)),
                    )
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  chatVM init_VM() {
    // TODO: implement init_VM
    return chatVM();
  }

  @override
  void clearContent() {
    msgController.clear();
    setState(() {});
  }
}
