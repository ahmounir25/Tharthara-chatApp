import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/base.dart';
import 'package:untitled1/modules/createRoom/createRoom_VM.dart';
import 'package:untitled1/modules/createRoom/createRoom_navigator.dart';
import 'package:untitled1/modules/homeScreen/HomeScreen.dart';

import '../../models/category.dart';

class createRoomScreen extends StatefulWidget {
  static const String routeName = 'addRoom';

  @override
  State<createRoomScreen> createState() => _createRoomScreenState();
}

class _createRoomScreenState extends BaseView<createRoomVM, createRoomScreen>
    implements createRoomNavigator {
  GlobalKey<FormState> FormKey = GlobalKey<FormState>();
  var roomNameController = TextEditingController();
  var roomDesController = TextEditingController();
  late Category category;
  var items = Category.getCategories();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
    category = items[0];
  }

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
                'Add Room',
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Card(
              elevation: 20,
              margin: EdgeInsets.symmetric(vertical: 42, horizontal: 21),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: FormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: AssetImage('assets/images/createRoom.png')),
                      Text(
                        'Create New Room :',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: roomNameController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: "Room Name",
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
                            return "Please Enter Room name ...";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      DropdownButton<Category>(
                        borderRadius: BorderRadius.circular(12),
                        elevation: 0,

                        value:category ,
                        items: items.map(
                              (e) => DropdownMenuItem<Category>(
                                value: e,
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(e.image,width:30),
                                    SizedBox(width: 5,),
                                    Text('${e.name}'),
                                  ],
                                ),
                              ),
                            ).toList(),
                        onChanged: (value) {
                          if(value==null)
                            return;
                          category=value;
                          setState(() {
                          });},
                      ),
                      TextFormField(
                        controller: roomDesController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: "Room Description",
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
                            return "Please Enter Description ...";
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
                          child: Text(' Create '))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void ValidateForm() {
    if(FormKey.currentState!.validate()){
      viewModel.createRoom(roomNameController.text, roomDesController.text, category.catId);

    }
  }

  @override
  createRoomVM init_VM() {
    return createRoomVM();
  }

  @override
  void roomCreated() {
    Navigator.pop(context);

  }
}
