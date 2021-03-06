import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/widgets/message_bubble.dart';
import 'package:flutter/material.dart';

class MessageStream extends StatelessWidget {
  final Stream stream;
  final String textKey;
  final String senderKey;
  final String currentUser;
  const MessageStream(
      {this.stream, this.textKey, this.senderKey, this.currentUser});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (!snapshot.hasError && snapshot.hasData) {
          final List<QueryDocumentSnapshot> messages = snapshot.data.docs;
          List<MessageBubble> messageBubbles = [];
          for (var message in messages) {
            final messageText = message.get(textKey);
            final messageSender = message.get(senderKey);
            messageBubbles.add(
              MessageBubble(
                message: messageText,
                sender: messageSender,
                isMe: currentUser == messageSender ? true : false,
              ),
            );
          }
          return Expanded(
            child: ListView(
              reverse: true, // List sticks at the bottom of the screen
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              children: messageBubbles,
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
              color: Colors.red,
            ),
          );
        }
      },
    );
  }
}
