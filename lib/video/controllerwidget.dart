import 'package:flutter/material.dart';
import 'package:flutter_practice/video/videoplayercontrol.dart';
import 'package:video_player/video_player.dart';

class ControllerWidget extends InheritedWidget {

  final String title;
  final GlobalKey<VideoPlayerControlState> controlKey;
  final Widget child;
  final VideoPlayerController controller;
  final bool videoInit;

  ControllerWidget({required this.title, required this.controlKey, required this.controller, required this.videoInit, required this.child}) : super(child: child);

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static ControllerWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ControllerWidget>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

}