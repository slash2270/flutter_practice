import 'dart:core';
import 'dart:io';

import 'package:ble/ble.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_practice/bluetooth/blueelvesdemo.dart';
import 'package:flutter_practice/generated/l10n.dart';
import 'package:flutter_practice/set.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

Set set = Set();

class SixtyFive extends StatelessWidget {
  const SixtyFive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SixtyFiveStateFul();
  }
}

class SixtyFiveStateFul extends StatefulWidget {
  const SixtyFiveStateFul({Key? key}) : super(key: key);

  //static final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  @override
  State<SixtyFiveStateFul> createState() => SixtyFiveStateFulState();
}

class SixtyFiveStateFulState extends State<SixtyFiveStateFul> with WidgetsBindingObserver {

  //String _platformVersion = 'Unknown';
  //late Locale _locale;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('$state');
  }

  @override
  void initState() {
    print('SixtyFive initState');
    /*requestPermission();
    // 初始化
    Ble.getInstance();
    initPlatformState();
    // 设置显示的默认语言
    _locale = Locale(SpUtil.getString(SpUtil.LANGUAGE, defValue: 'zh'), '');*/
    super.initState();
  }

  /*requestPermission() async {
    PermissionStatus permissionStatus = await Permission.location.status;
    if (permissionStatus.isGranted) {
      List<Permission> permissions = [];
      if (Platform.isIOS) {
        permissions = [Permission.storage, Permission.phone];
      } else {
        permissions = [Permission.location,Permission.storage, Permission.phone];
      }
      Map<Permission, PermissionStatus> statuses = await permissions.request();
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await Ble.getInstance().platformVersion;
      print(platformVersion);
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }*/

  @override
  void didChangeDependencies() {
    // 依賴變化
    print('SixtyFive didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant SixtyFiveStateFul oldWidget) {
    // 元件發生變化
    print('SixtyFive didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    print('SixtyFive setState');
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    print('SixtyFive deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    print('SixtyFive dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlueElvesDemo();
    /*return Localizations.override(
        context: context,
        locale: _locale,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text("SixtyFive Page"),
          ),
          body: Index(),
          floatingActionButton: FloatingActionButton(
            child: Text.rich(
              TextSpan(children: [
                TextSpan(text: "Lang\n", style: TextStyle(fontSize: 16)),
                TextSpan(
                    text: "(" + (_locale.languageCode == 'zh' ? 'ZH' : 'EN') + ")",
                    style: TextStyle(fontSize: 7))
              ]),
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              setState(() {
                print(_locale.languageCode);
                SpUtil.putString(SpUtil.LANGUAGE, _locale.languageCode == 'zh' ? 'en' : 'zh');
                _locale = Locale(_locale.languageCode == 'zh' ? 'en' : 'zh', '');
                Fluttertoast.showToast(msg: '${S.of(context).language}', gravity: ToastGravity.CENTER);
              });
            },
          ),
        ));*/
  }

}