import 'package:untitled1/models/category.dart';

class Room{
  static  String collectionName='Rooms';
  String id;
  String roomName;
  String roomDescription;
  String catName;


// without pass cause i will n't save  or generate it
  Room(
      { this.id='',
        required this.roomName,
        required this.roomDescription,
        required this.catName,
      });

  Room.fromJson(Map<String, dynamic> map)
      : this(
      id: map['id'],
      roomName: map['roomName'],
      roomDescription: map['roomDescription'],
      catName: map["catName"],
  );
  Map<String,dynamic> toJson(){
    return {
      "id":id,
      "roomName":roomName,
      "roomDescription":roomDescription,
      "catName":catName
    };
  }

}