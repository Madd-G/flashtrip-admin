import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/views/chat_screen/views/chat_screen.dart';

final _firestore = FirebaseFirestore.instance;

class ChatSender extends StatelessWidget {
  const ChatSender({Key? key, required this.from}) : super(key: key);
  final String from;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blueAccent,
              ),
            );
          }
          final messages = snapshot.data?.docs;
          List messageSenders = [];
          for (var message in messages!) {
            final messageSender = message['sender'];
            final messageTo = message['to'];
            final place = message['place'];
            if (messageTo == 'admin@flashtrip.com' && place == from) {
              messageSenders.add(messageSender);
            }
          }
          var messageSenderSet = {...messageSenders};
          List senderList = messageSenderSet.toList();
          return ListView.builder(
              itemCount: senderList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            from: from,
                            sender: senderList[index],
                          ),
                        ),
                      );
                    },
                    child: Text(senderList[index]));
              });
        },
      )),
    );
  }
}
