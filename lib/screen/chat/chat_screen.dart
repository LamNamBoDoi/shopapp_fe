import 'package:flutter/material.dart';
import 'package:shopapp_v1/view/custom_appbar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Chat'),
      body: Center(
        child: Text(
          'Chat Screen',
        ),
      ),
    );
  }
}
