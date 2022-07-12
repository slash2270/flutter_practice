import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_practice/view/four.dart';
import 'package:flutter_practice/view/third.dart';
import 'package:flutter_practice/set.dart';

class KeyBoardVisibility extends StatefulWidget {
  @override
  State<KeyBoardVisibility> createState() => _KeyBoardVisibilityState();
}

class _KeyBoardVisibilityState extends State<KeyBoardVisibility> {

  late StreamSubscription<bool> keyboardSubscription;

  @override
  void initState() {
    super.initState();
    var keyboardVisibilityController = KeyboardVisibilityController();
    // Query
    print('Keyboard Visibility direct query: ${keyboardVisibilityController.isVisible}');
    // Subscribe
    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
      print('Keyboard Visibility update. Is visible: $visible');
    });
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      dismissOnCapturedTaps: true, // 沒點擊不會自動打開
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Set().initText2('KeyboardVisibility 小鍵盤可視性', Colors.black, Colors.transparent, 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Third()),
                  );
                },
                child: Text('提供者演示'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Four()),
                  );
                },
                child: Text('鍵盤關閉演示'),
              ),
              Spacer(),
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: '鍵盤測試輸入框',
                ),
              ),
              Container(height: 60.0),
              KeyboardVisibilityBuilder(builder: (context, visible) {
                return Text('鍵盤是: ${visible ? '可見' : '不可見'}',);
              }),
              Spacer(),
            ],
          ),
        ),
      )
    );
  }
}