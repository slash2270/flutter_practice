import 'dart:core';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/set.dart';
import 'package:flutter_practice/system/uuidwidget.dart';
import 'package:flutter_practice/cache/cachemanagerwidget.dart';
import 'package:flutter_practice/cache/cachenetworkimagewidget.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart';

Set set = Set();

class ThirtyEight extends StatelessWidget {
  const ThirtyEight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: set.initText('ThirtyEight Page'),
        ),
        body: SingleChildScrollView(
          child: ThirtyEightStateFul(),
        ),
      resizeToAvoidBottomInset: true,
    );
  }
}

class ThirtyEightStateFul extends StatefulWidget {
  const ThirtyEightStateFul({Key? key}) : super(key: key);

  @override
  State<ThirtyEightStateFul> createState() => ThirtyEightStateFulState();
}

class ThirtyEightStateFulState extends State<ThirtyEightStateFul> with WidgetsBindingObserver {

  late GetStorage _getStorage;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('ThirtyEight initState');
    }
    _getStorage = GetStorage();
    _getStorage.write('getStorage', '存值');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('ThirtyEight didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ThirtyEightStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('ThirtyEight didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('ThirtyEight setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('ThirtyEight deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('ThirtyEight dispose');
    }
    _getStorage.remove('getStorage');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: set.initEdgeInsets(0.0, 20.0, 0.0, 20.0),
      child: Column(
        children: [
          set.initSizedBox(20.0),
          set.initText2('GetStorage', Colors.black, Colors.transparent, 24),
          ElevatedButton(onPressed: ()=> _getStorageClick(), child: set.initText(_getStorage.read('getStorage'))),
          set.initSizedBox(20.0),
          set.initText2('Uuid', Colors.black, Colors.transparent, 24),
          UuidWidget(),
          set.initSizedBox(20.0),
          set.initText2('CacheNetWorkImageNetWork', Colors.black, Colors.transparent, 24),
          CacheNetWorkImageNetWorkWidget(),
          set.initSizedBox(20.0),
          set.initText2('CacheManager', Colors.black, Colors.transparent, 24),
          CacheManagerWidget(),
          set.initSizedBox(20.0),
        ],
      ),
    );
  }

  _getStorageClick(){
    if(_getStorage.read('getStorage') == '存值'){
      _getStorage.write('getStorage', '取值');
    }else if(_getStorage.read('getStorage') == '取值'){
      _getStorage.write('getStorage', '存值');
    }
    setState(() { });
  }

}