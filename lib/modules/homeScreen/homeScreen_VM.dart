import 'package:untitled1/base.dart';
import 'package:untitled1/dataBase/dataBaseUtilities.dart';
import 'package:untitled1/modules/homeScreen/homeScreen_Navigator.dart';

import '../../models/Room.dart';

class homeScreen_VM extends BaseViewModel<homeScreenNavigator>
{
  List<Room> rooms = [];

  void getRoom() async {
    try {
      rooms = await DataBaseUtils.getRoomFromFirebase();

      print(rooms.length);
    } catch (e) {
      navigator!.showMessage(e.toString());
    }
  }
}