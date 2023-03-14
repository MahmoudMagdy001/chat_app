import 'package:chat_app/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String message;
  final String id;
  final Timestamp date;

  Message(this.message, this.id, this.date);

  factory Message.fromjson(jsonData) {
    return Message(jsonData[kMessage], jsonData['id'], jsonData[kCreatedAt]);
  }
}
