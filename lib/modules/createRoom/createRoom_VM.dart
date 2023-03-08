// import 'package:flutter/foundation.dart';
import 'package:untitled1/dataBase/dataBaseUtilities.dart';
import 'package:untitled1/modules/createRoom/createRoom_navigator.dart';

import '../../base.dart';
import '../../models/Room.dart';
import '../../models/category.dart';

class createRoomVM extends BaseViewModel<createRoomNavigator> {
  void createRoom(
      String roomName, String roomDescription, String catName) {
    Room room = Room(
        roomName: roomName,
        roomDescription: roomDescription,
        catName: catName);
    DataBaseUtils.addRoomToFirebase(room).then((value) {
      // navigator!.hideDialog();
      navigator!.roomCreated();
    }).catchError((error) {
      navigator!.showMessage(error.toString());
    });
  }
}
