
import 'package:flutter/material.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';

///沉浸式状态栏

enum StatusStyle { LIGHT_CONTENT, DARK_CONTENT } //明亮和黑暗

class StatusBarWidget extends StatelessWidget {
  final StatusStyle statusStyle;
  final Color color;
  final double height;
  final Widget child;

  const StatusBarWidget(
      {Key? key,
        required this.statusStyle,
        required this.color,
        this.height = 46,
        required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _statusBarInit();
    //状态栏高度
    var top = MediaQuery.of(context).padding.top;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: top + height,
      child: child,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(color: color),
    );
  }

  void _statusBarInit() {
    //沉浸式状态栏
    FlutterStatusbarManager.setColor(color, animated: false);
    FlutterStatusbarManager.setStyle(statusStyle == StatusStyle.DARK_CONTENT
        ? StatusBarStyle.DARK_CONTENT
        : StatusBarStyle.LIGHT_CONTENT);
  }
}