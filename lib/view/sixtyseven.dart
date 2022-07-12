import 'dart:core';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/camera/camerademo.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

class SixtySeven extends StatelessWidget {
  const SixtySeven({Key? key, required this.listCamera}) : super(key: key);

  final List<CameraDescription> listCamera;

  @override
  Widget build(BuildContext context) {
    return SixtySevenStateFul(listCamera: listCamera,);
  }
}

class SixtySevenStateFul extends StatefulWidget {
  const SixtySevenStateFul({Key? key, required this.listCamera}) : super(key: key);

  final List<CameraDescription> listCamera;

  @override
  State<SixtySevenStateFul> createState() => SixtySevenStateFulState();
}

class SixtySevenStateFulState extends State<SixtySevenStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    print('SixtySeven initState');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    print('SixtySeven didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant SixtySevenStateFul oldWidget) {
    // 元件發生變化
    print('SixtySeven didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    print('SixtySeven setState');
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    print('SixtySeven deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    print('SixtySeven dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CameraDemo(listCamera: widget.listCamera);
  }

}