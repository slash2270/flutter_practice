import 'dart:core';

import 'package:counter/counter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/generated/l10n.dart';
import 'package:flutter_practice/set.dart';
import 'package:flutter_practice/value/colorvalue.dart';
import 'package:flutter_practice/view/second.dart';
import 'package:shared_preferences/shared_preferences.dart';

Set set = Set();

const String secondTitle = "Second Page";
Second second = const Second();

enum fruitData { apple, banana, guava }

class First extends StatelessWidget {
  const First({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: FirstWidget());
  }
}

class FirstWidget extends StatefulWidget {
  const FirstWidget({Key? key}) : super(key: key);

  @override
  State<FirstWidget> createState() => FirstState();
}

class FirstState extends State<FirstWidget> with RestorationMixin {

  final isSelected1 = [
    RestorableBool(false),
    RestorableBool(false),
    RestorableBool(false),
  ];
  final isSelected2 = [
    RestorableBool(false),
    RestorableBool(false),
  ];
  final isSelected3 = [
    RestorableBool(false),
    RestorableBool(false),
  ];

  @override
  String get restorationId => 'toggle_button_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(isSelected1[0], 'first_item');
    registerForRestoration(isSelected1[1], 'second_item');
    registerForRestoration(isSelected1[2], 'third_item');
    registerForRestoration(isSelected2[0], 'first_item');
    registerForRestoration(isSelected2[1], 'second_item');
    registerForRestoration(isSelected3[0], 'first_item');
    registerForRestoration(isSelected3[1], 'second_item');
  }

  late bool isCheck;
  int _counter = 0;
  late SharedPreferences sP;
  final String keyCounter = "Counter";

  @override
  void initState() {
    if (kDebugMode) {
      print('initState Five');
    }
    isCheck = false;
    _setCounter();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('didChangeDependencies Five');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant FirstWidget oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('didUpdateWidget First');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('setState First');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('deactivate First');
    }
    //sP.remove(keyCounter);
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('dispose First');
    }
    for (final restartableBool in isSelected1) {
      restartableBool.dispose();
    }
    for (final restartableBool in isSelected2) {
      restartableBool.dispose();
    }
    for (final restartableBool in isSelected3) {
      restartableBool.dispose();
    }
    //sP.clear();
    super.dispose();
  }

  void _setCounter() async {
    sP = await SharedPreferences.getInstance();
    _counter = (sP.getInt(keyCounter) ?? 0);
  }

  void _add() {
    setState(() {
      _counter = (sP.getInt(keyCounter) ?? 0) + 1;
      sP.setInt(keyCounter, _counter);
    });
  }

  void _minus() {
    setState(() {
      _counter = (sP.getInt(keyCounter) ?? 0) - 1;
      sP.setInt(keyCounter, _counter);
    });
  }

  void onClick(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const Second(),
            settings: const RouteSettings(
              arguments: secondTitle,
            )
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
       title: set.initText(S.of(context).First),
       actions: [
           PopupMenuButton(
             onCanceled: () {
               if (kDebugMode) {
                 //print('First Menu Cancel');
               }
             },
             onSelected: (v) {
               switch(v){
                 case 1:
                   break;
                 case 2:
                   break;
                 case 3:
                   setState(() {
                     if(isCheck == true){
                       isCheck = false;
                     }else{
                       isCheck = true;
                     }
                   });
                   break;
               }
             },
             itemBuilder: (BuildContext context) {
               List<PopupMenuEntry> list = <PopupMenuEntry>[];
               list.add(
                 const PopupMenuItem(
                   value: 1,
                   child: Text('Item 1'),
                 ),
               );
               list.add(
                 const PopupMenuItem(
                   value: 2,
                   child: Text('Item 2'),
                 ),
               );
               list.add(
                 const PopupMenuDivider(),
               );
               list.add(
                 CheckedPopupMenuItem(
                   value: 3,
                   child: set.initText('Item 3'),
                   checked: isCheck,
                 ),
               );
               return list;
             },
           ),
         ],
      ),
      body: SingleChildScrollView(
        child: (Center(
          child: Column(
            children: <Widget>[
              Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.grey),
                    // margin: EdgeInsets.symmetric(
                    // horizontal: ScreenUtil().setWidth(50)),
                    height: 300,
                    width: double.infinity,
                    child: Stack(
                      children: const <Widget>[
                        Align(
                          child: Icon(Icons.home, size: 40, color: Colors.purple),
                          alignment: Alignment(-0.95, -0.95),
                          // x,y 右下：1.0 1.0 右上:1.0 -1.0 左上：-1.0 -1.0 左下: -1.0 1.0 可超Screen
                          //heightFactor: 15, // max = 依size比例調整 center = 1, 最小 = 0
                          //widthFactor: 1.0, // max = 依size比例調整 center = 1, 最小 = 0
                        ),
                        Align(
                          child: Icon(Icons.search, size: 40, color: Colors.red),
                          alignment: Alignment(-0.95, 0.95),
                          // x,y 右下：1.0 1.0 右上:1.0 -1.0 左上：-1.0 -1.0 左下: -1.0 1.0 可超Screen
                          //heightFactor: 15, // max = 依size比例調整 center = 1, 最小 = 0
                          //widthFactor: 1.0, // max = 依size比例調整 center = 1, 最小 = 0
                        ),
                        Align(
                          child: Icon(Icons.settings, size: 40, color: Colors.blue),
                          alignment: Alignment(0.95, -0.95),
                          // x,y 右下：1.0 1.0 右上:1.0 -1.0 左上：-1.0 -1.0 左下: -1.0 1.0 可超Screen
                          //heightFactor: 15, // max = 依size比例調整 center = 1, 最小 = 0
                          //widthFactor: 1.0, // max = 依size比例調整 center = 1, 最小 = 0
                        ),
                        Align(
                          child: Icon(Icons.phone, size: 40, color: Colors.yellow),
                          alignment: Alignment(0.95, 0.95),
                          // x,y 右下：1.0 1.0 右上:1.0 -1.0 左上：-1.0 -1.0 左下: -1.0 1.0 可超Screen
                          //heightFactor: 15, // max = 依size比例調整 center = 1, 最小 = 0
                          //widthFactor: 1.0, // max = 依size比例調整 center = 1, 最小 = 0
                        )
                      ],
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Counter(
                /// 最小值
                min: 0,
                /// 最大值
                max: 999999999999,
                /// 綁定值，默認為null，必須大於等於[min]且小於等於[max]。
                /// 當前值不能大於 [min] 並且小於 bound 如果 bound 不為 null 並且它被批准。
                /// 如果當前值為[min]，並且綁定值也大於[min]，並且點擊增加按鈕後該值將隨著綁定值一步步變化。
                /// 並且在點擊減少按鈕後，它會隨著 [min] 的值變化一步。
                bound: 3,
                /// 初始值，默認等於[min]，必須大於等於[min]且小於等於[max]。
                /// 並且初始值必須大於等於[bound]，而bound和初始值都不為null。
                initial: 5,
                /// 步進，默認1
                step: 1,
                /// 外觀配置，默認 DefaultConfiguration()
                /// 你也可以通過實現 [Configuration] 類來設置自定義外觀。
                configuration: DefaultConfiguration(),
                /// 值改變回調。
                onValueChanged: print,
              ),
              Container(
                child: set.initText('你必須重複點擊這個按鈕',),
                margin: set.initEdgeInsets(0.0, 20.0, 0.0, 0.0),
              ),
              Text('$_counter', style: Theme.of(context).textTheme.headline4,),
              Container(
                margin: set.initEdgeInsets(0.0, 10.0, 0.0, 0.0),
                child: Row(children: [
                  Expanded(
                    child: FloatingActionButton(
                      heroTag: "fabAdd",
                      onPressed: _add,
                      tooltip: 'add counter',
                      child: set.initIcon(Icons.arrow_drop_up),
                    ),
                  ),
                  Expanded(
                    child: FloatingActionButton(
                      heroTag: "fabMinus",
                      onPressed: _minus,
                      tooltip: 'minus counter',
                      child: set.initIcon(Icons.arrow_drop_down),
                    ),
                  ),
                ]),
              ),
              Container(
                  margin: set.initEdgeInsets(0.0, 20.0, 0.0, 0.0),
                  child: ToggleButtons(
                    onPressed: (index) {
                      switch(index){
                        case 0:
                          _setInputDialog(context);
                          break;
                        case 1:
                          _setOptionDialog(context);
                          break;
                        case 2:
                          set.setLoadingDialog(context, false);
                          break;
                      }
                      setState(() {
                        isSelected1[index].value = !isSelected1[index].value;
                      });
                    },
                    isSelected: isSelected1.map((element) => element.value).toList(),
                    children: [
                      set.initText4('InputDialog', Colors.black, Colors.transparent, 20.0, FontWeight.bold),
                      set.initText4('OptionDialog', Colors.black, Colors.transparent, 20.0, FontWeight.bold),
                      set.initText4('LoadingDialog', Colors.black, Colors.transparent, 20.0, FontWeight.bold),
                    ],
                  ),
              ),
              Container(
                  margin: set.initEdgeInsets(0.0, 20.0, 0.0, 0.0),
                  child: ToggleButtons(
                    onPressed: (index) {
                      switch(index){
                        case 0:
                          set.snackBar(context, '顯示訊息', '復原');
                          break;
                        case 1:
                          _setModalBottomSheet(context);
                          break;
                      }
                      setState(() {
                        isSelected2[index].value = !isSelected2[index].value;
                      });
                    },
                    isSelected: isSelected2.map((element) => element.value).toList(),
                    children: [
                      set.initText4('SnackBar', Colors.black, Colors.transparent, 20.0, FontWeight.bold),
                      set.initText4('BottomSheetDialog', Colors.black, Colors.transparent, 20.0, FontWeight.bold),
                    ],
                  ),
              ),
              Container(
                  margin: set.initEdgeInsets(0.0, 20.0, 0.0, 0.0),
                  child: ToggleButtons(
                    onPressed: (index) {
                      switch(index){
                        case 0:
                          _setAndroidDatePicker(context);
                          break;
                        case 1:
                          _setIOSDatePicker(context);
                          break;
                      }
                      setState(() {
                        isSelected3[index].value = !isSelected3[index].value;
                      });
                    },
                    isSelected: isSelected3.map((element) => element.value).toList(),
                    children: [
                      set.initText4('Android DatePicker', Colors.black, Colors.transparent, 20.0, FontWeight.bold),
                      set.initText4('IOS DatePicker', Colors.black, Colors.transparent, 20.0, FontWeight.bold),
                  ],
                ),
              ),
            ],
          ),
        )),
      ), //调用函数
      resizeToAvoidBottomInset: true,
    );
  }

}

//顯示 SnackBar 訊息與自定義按鈕
void _setSnackBar(BuildContext context) {
  final snackBar = SnackBar(
    onVisible: () {
      if (kDebugMode) {
        //print("顯示");
      }
    },
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.black,
    content: set.initText('顯示訊息'),
    action: SnackBarAction(
      label: '復原',
      onPressed: () {},
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Future<String?> _setInputDialog(BuildContext context) async {
  String inputData = '';
  return showDialog<String>(
    context: context,
    barrierDismissible: false, //控制點擊對話框以外的區域是否隱藏對話框
    builder: (BuildContext context) {
      return AlertDialog(
        title: set.initText('帶輸入框訊息視窗'),
        content: Row(
          children: <Widget>[
            Expanded(
                child: TextField(
              autofocus: true,
              decoration: const InputDecoration(labelText: '測試可輸入資料對話視窗', hintText: '請輸入資料...'),
              onChanged: (value) {
                inputData = value;
              },
            ))
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: set.initText('送出'),
            onPressed: () {
              Navigator.of(context).pop(inputData);
            },
          ),
        ],
      );
    },
  );
}

Future<fruitData?> _setOptionDialog(BuildContext context) async {
  return await showDialog<fruitData>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: set.initText('想要報名的課程'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, fruitData.apple);
              },
              child: set.initText('Apple'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, fruitData.banana);
              },
              child: set.initText('Banana'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, fruitData.guava);
              },
              child: set.initText('Guava'),
            ),
          ],
        );
      }
   );
}

// 弹出底部菜单列表模态对话框
Future<int?> _setModalBottomSheet(BuildContext context) {
  return showModalBottomSheet<int>(
    context: context,
    builder: (BuildContext context) {
      return ListView.builder(
        itemCount: 30,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: set.initText("$index"),
            onTap: () => Navigator.of(context).pop(index),
          );
        },
      );
    },
  );
}

Future<DateTime?> _setAndroidDatePicker(BuildContext context) {
  var date = DateTime.now();
  return showDatePicker(
    context: context,
    initialDate: date,
    firstDate: date,
    lastDate: date.add( //未来30天可选
      const Duration(days: 30),
    ),
  );
}

Future<DateTime?> _setIOSDatePicker(BuildContext context) {
  var date = DateTime.now();
  return showCupertinoModalPopup(
    context: context,
    builder: (ctx) {
      return SizedBox(
        height: 200,
        child: CupertinoDatePicker(
          backgroundColor: ColorValue.green,
          mode: CupertinoDatePickerMode.dateAndTime,
          minimumDate: date,
          maximumDate: date.add(
            const Duration(days: 30),
          ),
          maximumYear: date.year + 1,
          onDateTimeChanged: (DateTime value) {
            if (kDebugMode) {
              //print('First IOS DatePicker Value -> $value');
            }
          },
        ),
      );
    },
  );
}
