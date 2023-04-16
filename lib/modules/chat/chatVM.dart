import 'package:untitled1/base.dart';
import 'package:untitled1/dataBase/dataBaseUtilities.dart';
import 'package:untitled1/models/message.dart';
import 'package:untitled1/models/myUser.dart';
import 'package:untitled1/modules/chat/chatNavigator.dart';

class chatVM extends BaseViewModel<chatNavigator> {
  void sendMessage(String content, String roomId,myUser user)
  {
    Message message = Message(
        content: content,
        dateTime: DateTime.now().millisecondsSinceEpoch,
        roomId: roomId,
        senderId: user.id,
        senderName: user.userName);
    DataBaseUtils.addMessageToFireStore(message).then((value) => navigator!.clearContent());
  }
}
