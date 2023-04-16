import 'package:flutter/material.dart';
import 'package:untitled1/models/Room.dart';
import 'package:untitled1/modules/chat/chatScreen.dart';

class roomWidget extends StatelessWidget {
  // const roomWidget({Key? key}) : super(key: key);
  Room room;
  roomWidget(this.room);
  var txt='';
  @override
  Widget build(BuildContext context) {
    if(room.catName.toLowerCase()=='sports'){
      txt='sports';
    }
    else if (room.catName.toLowerCase()=='movies'){
      txt='movies';
    }
    else{
      txt='music';
    }
    return InkWell(
      onTap:  () {
        Navigator.pushNamed(context, chatScreen.routeName,arguments:room);
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow:[
            BoxShadow(
            color: Colors.black26,
            spreadRadius: 2,
            blurRadius: 5,
            blurStyle: BlurStyle.outer
          )],
          borderRadius: BorderRadius.circular(18)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Column(
            children: [
              Expanded(child: Image.asset('assets/images/$txt.png')),
              SizedBox(height: 5,),
              Text(room.roomName),
            ],
          ),
        ),
      ),
    );
  }
}
