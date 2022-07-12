import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

class FirebaseAppCheckDemo extends StatefulWidget {
  @override
  State<FirebaseAppCheckDemo> createState() => _FirebaseAppCheckDemoState();
}

class _FirebaseAppCheckDemoState extends State<FirebaseAppCheckDemo> {
  final appCheck = FirebaseAppCheck.instance;
  String _message = '';
  String _eventToken = '還沒有';
  late ElevatedButton _elevatedButton;
  late SizedBox _sizedBox;

  @override
  void initState() {
    appCheck.onTokenChange.listen(setEventToken);
    super.initState();
  }

  void setMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  void setEventToken(String? token) {
    setState(() {
      _eventToken = token ?? '還沒有';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: set.initEdgeInsetsTop(20.0),
      child: Center(
        child: Column(
          children: [
            set.initText2('FireBase AppCheck', Colors.black, Colors.transparent, 24),
            _elevatedButton= ElevatedButton(
              onPressed: () async {
                if (kIsWeb) {
                  print('如果在網絡平台上使用，請傳入您在 Firebase 控制台上找到的“webRecaptchaSiteKey”密鑰以激活',);
                }
                await appCheck.activate();
                setMessage('活性!');
              },
              child: const Text('activate()'),
            ),
            _elevatedButton = ElevatedButton(
              onPressed: () async {
                final token = await appCheck.getToken(true);
                setMessage('your token: $token');
              },
              child: const Text('getToken()'),
            ),
            _elevatedButton = ElevatedButton(
              onPressed: () async {
                await appCheck.setTokenAutoRefreshEnabled(true);
                setMessage('成功設置自動令牌刷新！');
              },
              child: const Text('setTokenAutoRefreshEnabled()'),
            ),
            _sizedBox = SizedBox(height: 10),
            Text(_message, //#007bff
              style: const TextStyle(
                color: Color.fromRGBO(47, 79, 79, 1),
                fontSize: 16,
              ),
            ),
            _sizedBox = SizedBox(height: 10),
            Text('Token received from tokenChanges() API: $_eventToken', //#007bff
              style: const TextStyle(
                color: Color.fromRGBO(128, 0, 128, 1),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}