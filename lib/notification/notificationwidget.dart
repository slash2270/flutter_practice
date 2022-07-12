import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/notification/notificationbean.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({Key? key}) : super(key: key);

  @override
  State<NotificationWidget> createState() => NotificationWidgetState();
}

class NotificationWidgetState extends State<NotificationWidget> {
  String _msg="";
  @override
  Widget build(BuildContext context) {
    //监听通知
    return NotificationListener<NotificationBean>(
      onNotification: (notification) {
        if (kDebugMode) { // 打印通知
          print(notification.msg);
        }
        return false;
      },
      child: NotificationListener<NotificationBean>(
          onNotification: (notification) {
            setState(() {
              if(_msg.isEmpty){
                _msg = notification.msg + '\n';
              }else{
                _msg = '';
              }
            });
            return false; // 只要子是true就不會通知
          },
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Builder(
                  builder: (context) {
                    return ElevatedButton(
                      //按钮点击时分发通知
                      onPressed: () => NotificationBean("接收通知").dispatch(context),
                      child: const Text("傳送通知"),
                    );
                  },
                ),
                Text(_msg)
              ],
            ),
          ),
      ),
    );
  }
}