import 'package:chat_app/models/chat_message.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage chatMessage;
  const MessageBubble(this.chatMessage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          chatMessage.isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          width: 140,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            color: chatMessage.isMine
                ? Colors.grey[300]
                : Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12),
              topRight: const Radius.circular(12),
              bottomLeft:
                  chatMessage.isMine ? const Radius.circular(12) : Radius.zero,
              bottomRight:
                  chatMessage.isMine ? Radius.zero : const Radius.circular(12),
            ),
          ),
          child: Column(
            crossAxisAlignment: chatMessage.isMine
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Text(
                chatMessage.userName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: chatMessage.isMine
                        ? Colors.black
                        : Theme.of(context).textTheme.headline1?.color),
              ),
              Text(
                chatMessage.text,
                style: TextStyle(
                    color: chatMessage.isMine
                        ? Colors.black
                        : Theme.of(context).textTheme.headline1?.color),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
