import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/animation/animatedimagewidget.dart';
import 'package:flutter_practice/firebase/premissions.dart';
import 'package:flutter_practice/firebase/tokenmonitor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';
import 'message.dart';
import 'messagelist.dart';

/// 示例應用程序的入口點。
class FirebaseCloudMessageDemo extends StatelessWidget {
  const FirebaseCloudMessageDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Application();
  }
}

// Crude counter to make messages unique
int _messageCount = 0;

/// 此處的 API 端點接受原始 FCM 有效負載用於演示目的。
String constructFCMPayload(String? token) {
  _messageCount++;
  return jsonEncode({
    'token': token,
    'data': {
      'via': 'FlutterFire Cloud Messaging!!!',
      'count': _messageCount.toString(),
    },
    'notification': {
      'title': 'Hello FlutterFire!',
      'body': 'This notification (#$_messageCount) was created via FCM!',
    },
  });
}

/// 呈現示例應用程序。
class Application extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _Application();
}

class _Application extends State<Application> {
  String? _token;
  late ElevatedButton _elevatedButton;

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        _pushMessage(message);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              // one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      _pushMessage(message);
    });
  }

  void _pushMessage(RemoteMessage message){
    Navigator.pushNamed(
      context,
      '/message',
      arguments: MessageArguments(message, true),
    );
  }

  Future<void> sendPushMessage() async {
    if (_token == null) {
      print('Unable to send FCM message, no token exists.');
      return;
    }
    try {
      await http.post(
        Uri.parse('https://api.rnfirebase.io/messaging/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: constructFCMPayload(_token),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }

  void _setSubScribeToTopic() async{
    print('FlutterFire Messaging Example: Subscribing to topic "fcm_test".',);
    await FirebaseMessaging.instance.subscribeToTopic('fcm_test');
    print('FlutterFire Messaging Example: Subscribing to topic "fcm_test" successful.',);
  }

  void _setUnSubScribe() async{
    print('FlutterFire Messaging Example: Unsubscribing from topic "fcm_test".',);
    await FirebaseMessaging.instance.unsubscribeFromTopic('fcm_test');
    print('FlutterFire Messaging Example: Unsubscribing from topic "fcm_test" successful.',);
  }

  void _getApnsToken() async{
    if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS) {
      print('FlutterFire Messaging Example: Getting APNs token...');
      String? token = await FirebaseMessaging.instance.getAPNSToken();
      print('FlutterFire Messaging Example: Got APNs token: $token');
    } else {
      print('FlutterFire Messaging Example: Getting an APNs token is only supported on iOS and macOS platforms.',);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: set.initEdgeInsetsTop(20.0),
        child: Column(
          children: [
            set.initText2('FireBase CloudMessage', Colors.black, Colors.transparent, 24),
            _elevatedButton = ElevatedButton(
              onPressed: _setSubScribeToTopic,
              child: set.initText('Subscribe to topic'),
            ),
            _elevatedButton = ElevatedButton(
              onPressed: _setUnSubScribe,
              child: set.initText('Unsubscribe to topic'),
            ),
            _elevatedButton = ElevatedButton(
              onPressed: _getApnsToken,
              child: set.initText('Get APNs token (Apple only)'),
            ),
            _elevatedButton = ElevatedButton(
              onPressed: sendPushMessage,
              child: const Icon(Icons.send),
            ),
            MetaCard('Permissions', Permissions()),
            MetaCard('FCM Token',
            TokenMonitor((token) {
                _token = token;
                return token == null ? const CircularProgressIndicator() : Text(token, style: const TextStyle(fontSize: 12));
              }),
            ),
            MetaCard('Message Stream', MessageList()),
          ],
        ),
    );
  }
}

/// 用於顯示元數據的 UI 小部件。
class MetaCard extends StatelessWidget {
  final String _title;
  final Widget _children;

  // ignore: public_member_api_docs
  MetaCard(this._title, this._children);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: set.initEdgeInsets(8.0, 8.0, 8.0, 0.0),
      child: Card(
        child: Padding(
          padding: set.initEdgeInsets(16.0, 16.0, 16.0, 16.0),
          child: Column(
            children: [
              Container(
                margin: set.initEdgeInsets(0.0, 0.0, 0.0, 16.0),
                child: Text(_title, style: const TextStyle(fontSize: 18)),
              ),
              _children,
            ],
          ),
        ),
      ),
    );
  }
}