import 'package:flutter/material.dart';
import 'package:untitled/views/chat_screen/views/chat_screen.dart';
import 'package:untitled/views/chat_screen/views/chat_sender.dart';

class ChatHomeScreen extends StatelessWidget {
  const ChatHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40.0,
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatSender(
                      from: 'Batu Love Garden',
                    ),
                  ),
                );
              },
              child: const Text('Batu Love Garden')),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChatSender(
                              from: 'Kedung Pedut',
                            )));
              },
              child: const Text('Kedung Pedut')),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatSender(
                      from: 'Kawah Ijen',
                    ),
                  ),
                );
              },
              child: const Text('Kawah Ijen')),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChatSender(
                              from: 'Lombok Wildlife Park',
                            )));
              },
              child: const Text('Lombok Wildlife Park')),
        ],
      ),
    ));
  }
}
