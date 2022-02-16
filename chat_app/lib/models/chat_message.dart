import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatMessage {
  String userId;
  String text;
  Timestamp createdAt;
  String userName = '...';
  String? imageUrl;

  ChatMessage(
      {required this.userId, required this.text, required this.createdAt});

  bool get isMine => FirebaseAuth.instance.currentUser!.uid == userId;

  Future<void> init() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((value) {
      userName = value.get('username');
      imageUrl = value.get('imageUrl');
    });
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) => ChatMessage(
        userId: map['userId'],
        text: map['text'],
        createdAt: map['createdAt'],
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'userId': userId,
        'text': text,
        'createdAt': createdAt,
      };
}
