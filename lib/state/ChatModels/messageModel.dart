// import 'package:chitwan_hospital/state/ChatModels/userModel.dart';
abstract class MessageModel {
  String sender;
  String time;
  String text;
}

class Message extends MessageModel {
  String sender;
  String time;
  String text;
  // final bool isLiked;
  // final bool unread;

  Message({
    this.sender,
    this.text,
    this.time,
  });

  Message.fromJson(json) {
    this.sender = json['sender'];
    this.time = json['timestamp'];
    this.text = json['message'];
  }
}

// final UserModel currentUser =
//     UserModel(id: 0, name: 'Neha Mdr.', imageUrl: null);

// //users

// final UserModel neha = UserModel(id: 1, name: "Neha Mdr.", imageUrl: null);

// final UserModel ashish = UserModel(id: 2, name: "Ashish Kafle", imageUrl: null);

// List<Message> chats = [
//   Message(
//     sender: 'ashish',
//     time: '5:30 PM',
//     text: 'Hey, How are you? I hope you are doing well.',
//   ),
//   Message(
//     sender: 'neha',
//     time: '5:30 PM',
//     text: 'Hey!',
//   ),
// ];

// List<Message> messages = [
//   Message(
//     sender: 'ashish',
//     time: '7:11 PM',
//     text: 'love you too <3',
//   ),
//   Message(
//     sender: 'currentUser',
//     time: '7:10 PM',
//     text: 'Hus maya I will try my best. love you <3',
//   ),
//   Message(
//     sender: 'ashish',
//     time: '7:09 PM',
//     text: 'Thats nice maya, all the best. Ramro banau la <3',
//   ),
//   Message(
//     sender: 'currentUser',
//     time: '7:08 PM',
//     text: 'Hey babe, I am making a chat app right now.',
//   ),
// ];
