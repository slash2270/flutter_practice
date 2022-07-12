import 'dart:core';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/set.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:math' as math;

import 'package:flutter_practice/view/twentyfive.dart';

Set set = Set();

class TwentyFour extends StatelessWidget {
  const TwentyFour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: set.initText('TwentyFour Page'),
      ),
        body: const SingleChildScrollView(
          child: TwentyFourStateFul(),
        ),
        resizeToAvoidBottomInset: true,
    );
  }
}

class TwentyFourStateFul extends StatefulWidget {
  const TwentyFourStateFul({Key? key}) : super(key: key);

  @override
  State<TwentyFourStateFul> createState() => TwentyFourState();
}

class TwentyFourState extends State<TwentyFourStateFul> with WidgetsBindingObserver {

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  int numA = 0, numB = 0, result = 0;

  //late Locale _locale;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('TwentyFour initState');
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _setNotification();
    });
    // _locale = Localizations.localeOf(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('TwentyFour didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant TwentyFourStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('TwentyFour didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('TwentyFour setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('TwentyFour deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('TwentyFour dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center,
        padding: set.initEdgeInsets(15.0, 20.0, 15.0, 20.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Text('LocalNotification\n本地廣播\nLocalizations\n多語言', textAlign: TextAlign.center, style: TextStyle(color: Colors.black, backgroundColor: Colors.transparent, fontSize: 24),),
              FlatButton(
                onPressed: _showNotification,
                child: Text('Single\nNotification', style: Theme.of(context).textTheme.headline1,),
              ),
              Padding(
                padding: _setPaddingTop(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _cancelNotification();
                      },
                      child: set.initText2('CancelSingleNotification', Colors.white, Colors.transparent, 12),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _cancelAllNotifications();
                      },
                      child: set.initText2('CancelAllNotification', Colors.white, Colors.transparent, 12),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: _setPaddingTop(20),
                child:GestureDetector(
                  child: NotificationListener<CustomNotification>(
                    onNotification: (notification) {
                      setState(() {
                        numA = notification.numA;
                        numB = notification.numB;
                        result = numA + numB;
                      });
                      switch (notification.runtimeType){
                        case ScrollStartNotification: '開始滾動'; break;
                        case ScrollUpdateNotification: '正在滾動'; break;
                        case ScrollEndNotification: '滾動停止'; break;
                        case OverscrollNotification: '滾動到邊界'; break;
                      }
                      //true 阻止冒泡  false 不阻止冒泡，父组件能够收到通知
                      return false;
                    },
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          set.initText2("$numA +$numB = $result", Colors.black, Colors.transparent, 24),
                          Builder(
                            builder: (context) {
                              return RaisedButton(
                                  child: const Text("NotificationListener\nreturn false", textAlign: TextAlign.center,),
                                  onPressed: () {
                                    CustomNotification(Random().nextInt(100), Random().nextInt(100)).dispatch(context);
                                  });
                            },
                          )
                        ],
                      ),
                    )),
              ),
            ),
            Padding(
                padding: _setPaddingTop(55),
                child: Container(
                  color: Colors.black,
                  child: Transform(
                    alignment: Alignment.topRight, //相对于坐标系原点的对齐方式
                    transform: Matrix4.skewY(0.3), //沿Y轴倾斜0.3弧度
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.deepOrange,
                      child: set.initText2('TransForm 傾斜', Colors.black, Colors.transparent, 18),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: _setPaddingTop(20),
                child: DecoratedBox(
                  decoration:const BoxDecoration(color: Colors.red),
                  //默认原点为左上角，左移20像素，向上平移5像素
                  child: Transform.translate(
                    offset: const Offset(-20.0, -5.0),
                    child: const Text("TransForm 平移"),
                  ),
                )
              ),
              Padding(
                  padding: _setPaddingTop(60),
                  child: DecoratedBox(
                    decoration:const BoxDecoration(color: Colors.red),
                    child: Transform.rotate(
                      //旋转90度
                      angle:math.pi/2 ,
                      child: const Text("TransForm 旋轉"),
                    ),
                  ),
              ),
              Padding(
                padding: _setPaddingTop(60),
                child: DecoratedBox(
                    decoration:const BoxDecoration(color: Colors.red),
                    child: Transform.scale(
                        scale: 1.5, //放大到1.5倍
                        child: const Text("TransForm 縮放"),
                    )
                )
              ),
              Padding(
                  padding: _setPaddingTop(40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      DecoratedBox(
                          decoration:const BoxDecoration(color: Colors.red),
                          child: Transform.scale(scale: 1.5,
                              child: const Text("Transform")
                          )
                      ),
                      const Text("重疊", style: TextStyle(color: Colors.green, fontSize: 18.0),)
                    ],
                  )
              ),
              Padding(
                  padding: _setPaddingTop(40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      DecoratedBox(
                        decoration: BoxDecoration(color: Colors.red),
                        //将Transform.rotate换成RotatedBox
                        child: RotatedBox(
                          quarterTurns: 1, //旋转90度(1/4圈)
                          child: Text("Transform"),
                        ),
                      ),
                      Text("平移旋轉", style: TextStyle(color: Colors.green, fontSize: 18.0),)
                    ],
                  ),
              ),
            ]
        ),
      )
    );

    /*return MaterialApp(
      localizationsDelegates: const [
        // 本地化的代理类
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        // 注册我们的Delegate
        LocalizationsDelegateDemo()
      ],
      supportedLocales: [  // 其它Locales
        _locale = const Locale('en', 'US'), // 美国英语
        _locale = const Locale('zh', 'CN'), // 中文简体
        _locale = const Locale('zh', 'TW'), // 中文繁體
      ],
      home: Container(
        alignment: Alignment.center,
        padding: set.initEdgeInsets(15.0, 20.0, 15.0, 20.0),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              set.initText2('LocalNotification\n     廣播通知\n Localizations\n     多語言', ColorValue.black, ColorValue.transParent, 24),
              FlatButton(
                onPressed: showNotification,
                child: Text('Demo', style: Theme.of(context).textTheme.headline1,),
              ),
            ]
        ),
      ),
    );*/
  }

  EdgeInsetsGeometry _setPaddingTop(double value) {
    return EdgeInsets.only(top: value);
  }

  //删除单个通知
  Future _cancelNotification() async {
    //参数 0 为需要删除的通知的id
    await flutterLocalNotificationsPlugin.cancel(0);
  }

  //删除所有通知
  Future _cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  void _setNotification() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = const AndroidInitializationSettings("@mipmap/ic_launcher");
    var iOS = const IOSInitializationSettings();
    // onSelect 直接跳出
    flutterLocalNotificationsPlugin.initialize(InitializationSettings(android: android, iOS: iOS), onSelectNotification: _onSelectNotification('Hello World'));
  }

  _onSelectNotification(String? payload) {
    debugPrint("TwentyFour payload : $payload");
    if(payload!.isNotEmpty){
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: set.initText('LocalNotification'),
          content: set.initText(payload),
        ),
      );
    }
    Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (context) => const TwentyFive()),
    );
  }

  // NotificationDetails 通知內容
  Future _showNotification() async {
    var android = const AndroidNotificationDetails('channel id', 'channel name', priority: Priority.high, importance: Importance.max);
    var iOS = const IOSNotificationDetails();
    var details = NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(0, 'Hi', 'Flutter Local Notification', details, payload: 'Hello World');
  }

}

//自定义通知
class CustomNotification extends Notification {
  int numA;
  int numB;
  CustomNotification(this.numA,this.numB);
}