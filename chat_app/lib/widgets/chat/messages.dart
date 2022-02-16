import 'package:chat_app/models/chat_message.dart';
import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt')
            .snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var messages = (snapshot.data as QuerySnapshot).docs;
          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (ctx, index) {
              final document = messages.elementAt(index);
              final chatMessage =
                  ChatMessage.fromMap(document.data() as Map<String, dynamic>);
              return FutureBuilder(
                future: chatMessage.init(),
                builder: (ctx2, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  }
                  return Container(
                    padding: const EdgeInsets.all(2),
                    child: MessageBubble(
                      chatMessage,
                      key: ValueKey(document.id),
                    ),
                  );
                },
              );
            },
          );
        });
  }
}
