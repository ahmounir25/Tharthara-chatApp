import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/models/message.dart';
import 'package:untitled1/providers/userProvider.dart';

class messageWidget extends StatelessWidget {
  Message message;

  messageWidget(this.message);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return provider.user!.id == message.senderId
        ? senderMessage(message)
        : receiverMessage(message);
  }
}

class senderMessage extends StatelessWidget {
  Message message;
  senderMessage(this.message);

  @override
  Widget build(BuildContext context) {
    int time=message.dateTime;
    var date=DateTime.fromMillisecondsSinceEpoch(time);
    var finalDate=DateFormat('hh:mm a').format(date);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical:8 ,horizontal:15 ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  color: Colors.blue),
              child: Text(message.content)),
          Text(finalDate)
        ],
      ),
    );
  }
}

class receiverMessage extends StatelessWidget {
  Message message;

  receiverMessage(this.message);

  @override
  Widget build(BuildContext context) {
    int time=message.dateTime;
    var date=DateTime.fromMillisecondsSinceEpoch(time);
    var finalDate=DateFormat('hh:mm a').format(date);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.symmetric(vertical:8 ,horizontal:15 ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  color: Colors.grey),
              child: Text(message.content)),
          Text(finalDate)
        ],
      ),
    );
  }
}
