import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

final _firestore = FirebaseFirestore.instance;
User? loggedInUser = FirebaseAuth.instance.currentUser!;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.from, required this.sender})
      : super(key: key);
  final String from;
  final String sender;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  late String messageText;
  final messageTextController = TextEditingController();

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        // print(loggedInUser?.email);
      }
    } catch (e) {
      // print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.sender), backgroundColor: mainColor,),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(
              receiver: widget.from,
              sender: widget.sender,
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
                      _firestore.collection('messages').add(
                        {
                          'text': messageText,
                          'sender': 'admin@flashtrip.com',
                          'to': widget.sender,
                          'place': widget.from,
                          'timestamp': FieldValue.serverTimestamp()
                        }, //or DateTime.now()  serverTimestamp()
                      );
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream(
      {super.key, required this.receiver, required this.sender});

  final String receiver, sender;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blueAccent,
            ),
          );
        }
        final messages = snapshot.data?.docs;
        List<MessageBubble> messageWidgets = [];
        for (var message in messages!) {
          // final messageData = message.data();
          final messageText = message['text'];
          final messageSender = message['sender'];
          final messageFrom = message['to'];
          final place = message['place'];
          final messageTime = message['timestamp'];

          const currentUser = 'admin@flashtrip.com';

          if (currentUser == messageSender) {}
          final messageBubbles = MessageBubble(
            sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSender,
            time: messageTime,
          );
          print('+++++++++++++++++++++++++');
          print('messageFrom $messageFrom');
          print('receiver $receiver');
          print('messageSender $messageSender');
          print('sender $sender');
          if (messageFrom == receiver || messageSender == sender || messageSender == 'admin@flashtrip.com') {
            if (place == receiver) {
              messageWidgets.add(messageBubbles);

            }
          }
        }
        return Expanded(
          child: ListView(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            reverse: true,
            children: messageWidgets,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String text;
  final String sender;
  final Timestamp? time;
  final bool isMe;

  const MessageBubble(
      {super.key,
      required this.text,
      required this.sender,
      required this.isMe,
      this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          // isMe
          //     ? const SizedBox()
          //     : Text(
          //         sender,
          //         style: const TextStyle(color: Colors.grey, fontSize: 12),
          //       ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Material(
              elevation: 2.0,
              color: isMe ? Colors.blueAccent : Colors.white,
              borderRadius: isMe
                  ? const BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0))
                  : const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 15, color: isMe ? Colors.white : Colors.black),
                ),
              ),
            ),
          ),
          Text(
            '${time?.toDate().hour}:${time?.toDate().minute}',
            style: const TextStyle(fontSize: 10.0),
          )
        ],
      ),
    );
  }
}
