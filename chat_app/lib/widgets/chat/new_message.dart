import 'package:chat_app/models/chat_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _messageController = TextEditingController();
  var _enteredMessage = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(labelText: 'Send message'),
              controller: _messageController,
              onChanged: (msg) {
                setState(() {
                  _enteredMessage = msg;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _enteredMessage.trim().isNotEmpty ? _sendMessage : null,
            icon: const Icon(
              Icons.send,
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    FocusScope.of(context).unfocus();
    final message = ChatMessage(
      userId: FirebaseAuth.instance.currentUser!.uid,
      text: _enteredMessage,
      createdAt: Timestamp.now(),
    );
    FirebaseFirestore.instance.collection('chat').add(message.toMap());
    _messageController.clear();
  }
}
