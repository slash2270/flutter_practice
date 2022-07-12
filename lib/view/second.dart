import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/database/dbhelper.dart';
import 'package:flutter_practice/set.dart';
import 'package:flutter_practice/bean/fivebean.dart';
import 'package:flutter_practice/view/first.dart';

import 'package:flutter_practice/value/colorvalue.dart';
import 'package:flutter_practice/value/fontsizevalue.dart';
import 'package:flutter_practice/value/stringvalue.dart';
import 'package:flutter_practice/view/third.dart';

import '../route/faderoute.dart';
import '../utils/constants.dart';

Set set = Set();

class Second extends StatelessWidget {
  const Second({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: set.initText('Second Page'),
        ),
        body: const SecondContent());
  }
}

class SecondContent extends StatefulWidget {
  const SecondContent({Key? key}) : super(key: key);

  @override
  State<SecondContent> createState() => StateContent();
}

class StateContent extends State<SecondContent> {

  late Widget widgetResult;
  late var result;

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    result = FiveBean(0, '', '', '', '', '', '');
    if (kDebugMode) {
      print('initState Second');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() { // 依賴變化
    if (kDebugMode) {
      print('didChangeDependencies Second');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant SecondContent oldWidget) { // 元件發生變化
  if (kDebugMode) {
  print('didUpdateWidget Second');
  }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) { // 更新畫面
    if (kDebugMode) {
      print('setState Second');
    }
    super.setState(fn);
  }

  @override
  void deactivate() { // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('deactivate Second');
    }
    super.deactivate();
  }

  @override
  void dispose() { // 銷毀
    if (kDebugMode) {
      print('dispose Second');
    }
    super.dispose();
  }

  void jumpThirdPage(BuildContext context) async {
    Future future = thirdClick();

    future.then((value) {
      setState(() {});
      result = value;
      if (result.name.isNotEmpty) {
        widgetResult = Column(
            children:[
              set.initIconButton2(() => jumpThirdPage(context), set.initIcon(Icons.heart_broken), 40 , Colors.red),
              set.initText2('${result.id}\n${result.name}\n${result.type}\n${result.size}\n${result.product}\n${result.price}\n${result.count}', Colors.blue, Colors.grey, 16)
            ]
        );
        /*弹窗显示返回的数据*/
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: const Text("返回的结果"),
                content: widgetResult,
                actions: <Widget>[
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("確定")),
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("取消"))
                ],
              );
            });

        DBHelper dbHelper = DBHelper();
        dbHelper.insertBean(Constants.tableProduct, FiveBean(result.id, result.name, result.type, result.size, result.product, result.price, result.count));

         }
    });
  }

  Future thirdClick(){
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Third(),
      /*settings: const RouteSettings(
        arguments: 'Third Page',
      ),*/
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          color: Colors.green,
          alignment: Alignment.center,
          margin: set.initEdgeInsets(15.0, 20.0, 15.0, 20.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RaisedButton(
                  textColor: Colors.black,
                  child: set.initText('第三頁傳值'),
                  onPressed: () {
                    thirdClick();
                  },
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.lightGreen,
                    margin: set.initEdgeInsets(15.0, 10.0, 15.0, 10.0),
                    //constraints: set.initBoxConstraint(300, 500, 50, 50),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                OutlinedButton(
                                  child: set.initText2('第三頁返回值', Colors.black, Colors.transparent, 16),
                                  onPressed: () {
                                    jumpThirdPage(context);
                                  },
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      set.initText4(
                                          StringValue.test + '1',
                                          ColorValue.black,
                                          ColorValue.transParent,
                                          FontSizeValue.font18,
                                          FontWeight.w100),
                                      set.initText4(
                                          StringValue.test + '2',
                                          ColorValue.black,
                                          ColorValue.transParent,
                                          FontSizeValue.font18,
                                          FontWeight.w200),
                                      set.initText4(
                                          StringValue.test + '3',
                                          ColorValue.black,
                                          ColorValue.transParent,
                                          FontSizeValue.font18,
                                          FontWeight.w300),
                                    ],
                                  ),
                                ),
                                widgetResult = Text(StringValue.catchValue + "返回值", style: TextStyle(color: ColorValue.black)),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      set.initText3(
                                          StringValue.test + '4',
                                          ColorValue.black,
                                          ColorValue.transParent,
                                          FontSizeValue.font18,
                                          TextDecoration.overline),
                                      set.initText3(
                                          StringValue.test + '5',
                                          ColorValue.black,
                                          ColorValue.transParent,
                                          FontSizeValue.font18,
                                          TextDecoration.lineThrough),
                                      set.initText3(
                                          StringValue.test + '6',
                                          ColorValue.black,
                                          ColorValue.transParent,
                                          FontSizeValue.font18,
                                          TextDecoration.underline),
                                    ],
                                  ),
                                ),
                                const FlutterLogo(),
                              ]),
                          alignment: Alignment.center, // x,y 右下：1.0 1.0 右上:1.0 -1.0 左上：-1.0 -1.0 左下: -1.0 1.0 可超Screen
                          //heightFactor: 15, // max = 依size比例調整 center = 1, 最小 = 0
                          //widthFactor: 1.0, // max = 依size比例調整 center = 1, 最小 = 0
                        ),
                      ],
                    ),
                  ),
                ),
                FlatButton(
                  textColor: Colors.black,
                  child: set.initText('返回第一頁'),
                  onPressed: () {
                    Navigator.push(context, FadeRoute(builder: (context) {
                      return const First();
                    }));
                  },
                ),
              ])),
    );
  }
}
