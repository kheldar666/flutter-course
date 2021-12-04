import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String sender;

  const MessageBubble({this.message, this.sender});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white54,
            ),
          ),
          Material(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20,
              ),
              child: Text(
                '$message',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            color: Colors.lightBlue,
            elevation: 50,
            borderRadius: BorderRadius.circular(30),
          ),
        ],
      ),
    );
  }
}
