// ignore_for_file: require_trailing_commas

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'message.dart';

/// 監聽傳入的前台消息並將它們顯示在列表中。
class MessageList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MessageList();
}

class _MessageList extends State<MessageList> {
  List<RemoteMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    getMessage();
  }

  void getMessage(){
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      setState(() {
        _messages = [..._messages, message];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_messages.isEmpty) {
      return const Text('No messages received');
    }
    return ListView.builder(
        shrinkWrap: true,
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          RemoteMessage message = _messages[index];
          return ListTile(
            title: Text(message.messageId ?? 'no RemoteMessage.messageId available'),
            subtitle: Text(message.sentTime?.toString() ?? DateTime.now().toString()),
            onTap: () => Navigator.pushNamed(context, '/message',
                arguments: MessageArguments(message, false)),
          );
        });
  }
}