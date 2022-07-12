import 'dart:core';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/set.dart';

import '../builder/layoutbuilder.dart';
import '../builder/layoutlogprint.dart';
import '../renderobject/afterlayout.dart';

Set set = Set();

class Fourteen extends StatelessWidget {
  const Fourteen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: set.initText('Fourteen Page'),
        ),
      body: const SingleChildScrollView(
        child: (FourteenStateFul()),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}

class FourteenStateFul extends StatefulWidget {
  const FourteenStateFul({Key? key}) : super(key: key);

  @override
  State<FourteenStateFul> createState() => FourteenState();
}

class FourteenState extends State<FourteenStateFul> with WidgetsBindingObserver, AfterLayoutMixin<FourteenStateFul>  {

  late Widget greyBox;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('Fourteen initState');
    }
    greyBox = const DecoratedBox(
      decoration: BoxDecoration(color: Colors.grey),
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('Fourteen didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant FourteenStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('Fourteen didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('Fourteen setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('Fourteen deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('Fourteen dispose');
    }
    super.dispose();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // Calling the same function "after layout" to resolve the issue.
    afterLayoutDialog();
  }

  void afterLayoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: set.initText2(' AfterLayoutDialog ', Colors.black, Colors.transparent, 20),
        actions: <Widget>[
          set.initText2(' 在UI成型後才執行 ', Colors.black, Colors.transparent, 16),
          FlatButton(
            child: set.initText2(' Dismiss ', Colors.black, Colors.transparent, 20),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  String _text1 = 'Text1', _text2 = 'Text2', _text3 = 'Text3', _text4 = 'Text4';
  Size _size = Size.zero;
  late Size _size3;
  late Offset _offset3;
  late RenderAfterLayout _renderAfterLayout2, _renderAfterLayout3;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: set.initEdgeInsets(10.0, 20.0, 10.0, 20.0),
      child: Column(
        children: [
          Wrap(
            spacing: 15.0, // 主轴(水平)方向间距
            runSpacing: 5.0, // 纵轴（垂直）方向间距
            alignment: WrapAlignment.center, //沿主轴方向居中
            children: <Widget>[
              Chip(
                avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initText('A')),
                label: set.initText('Toyota')
              ),
              Chip(
                avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initText('B')),
                label: set.initText('Honda'),
              ),
              Chip(
                avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initText('C')),
                label: set.initText('Subaru'),
              ),
              Chip(
                avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initText('D')),
                label: set.initText('Suzuki'),
              ),
              Chip(
                avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initText('E')),
                label: set.initText('Yamaha'),
              ),
              Chip(
                avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initText('F')),
                label: set.initText('Kawasaki'),
              ),
              Chip(
                avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initText('G')),
                label: set.initText('MitsuBiShi'),
              ),
              Chip(
                avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initText('H')),
                label: set.initText('Mazda'),
              ),
              Chip(
                avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initText('I')),
                label: set.initText('Nissan'),
              ),
            ],
          ),
          Flow(
            delegate: TestFlowDelegate(margin: const EdgeInsets.all(10.0)),
            children: <Widget>[
              Container(width: 80.0, height:80.0, color: Colors.red,),
              Container(width: 80.0, height:80.0, color: Colors.green,),
              Container(width: 80.0, height:80.0, color: Colors.blue,),
              Container(width: 80.0, height:80.0,  color: Colors.yellow,),
              Container(width: 80.0, height:80.0, color: Colors.brown,),
              Container(width: 80.0, height:80.0,  color: Colors.purple,),
              Container(width: 80.0, height:80.0,  color: Colors.grey,),
              Container(width: 80.0, height:80.0, color: Colors.pink,),
              Container(width: 80.0, height:80.0,  color: Colors.orange,),
            ],
            clipBehavior: Clip.hardEdge,
          ),
          Padding(
              padding: set.initEdgeInsets(15.0, 20.0, 15.0, 0.0),
              child: Column(
                children: [
                  set.initText2('LayoutBuilder', Colors.black, Colors.transparent, 24),
                  const LayoutBuilderRoute(),
                ],
              )),
          Padding(
              padding: set.initEdgeInsets(15.0, 20.0, 15.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  set.initText2('AfterLayout', Colors.black, Colors.transparent, 24),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Builder(
                      builder: (context) {
                        return GestureDetector(
                            child: set.initText2(_text1, Colors.blue, Colors.transparent, 16),
                            onTap: () {
                              _text1 = '$_text1 尺寸: ${context.size}';
                              setState(() {});
                            });
                      },
                    ),
                  ),
                  AfterLayout(
                      callback: (RenderAfterLayout ral) {
                        _renderAfterLayout2 = ral;
                      },
                      child: GestureDetector(
                          child: set.initText2(_text2, Colors.blue, Colors.transparent, 16),
                          onTap: () {
                            _text2 = '$_text2 尺寸: ${_renderAfterLayout2.size} 座標: ${_renderAfterLayout2.offset}';
                            setState(() {});
                          })
                  ),
                  Builder(builder: (context) {
                    return Container(
                      color: Colors.grey.shade200,
                      alignment: Alignment.center,
                      child: Wrap(
                        children:[
                          AfterLayout(
                              callback: (RenderAfterLayout ral) {
                                Offset offset = ral.localToGlobal(
                                  Offset.zero,
                                  ancestor: context.findRenderObject(),
                                );
                                _size3 = ral.size;
                                _offset3 = offset;
                              },
                              child: GestureDetector(
                                  child: set.initText2(_text3, Colors.blue, Colors.transparent, 16),
                                  onTap: () {
                                    _text3 = '$_text3 尺寸: $_size3 座標: $_offset3';
                                    setState(() {});
                                  })
                          )
                        ],
                      ),
                    );
                  }),
                  const Divider(),
                  AfterLayout(
                    child: Text(_text4),
                    callback: (RenderAfterLayout value) {
                      setState(() {
                        //更新尺寸信息
                        _size = value.size;
                      });
                    },
                  ),
                  //显示上面 Text 的尺寸
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: set.initText2('$_text4 尺寸: $_size ', Colors.blue, Colors.transparent, 16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _text4 += '++';
                          });
                        },
                        child: set.initText('Text4追加字符串'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _text1 = 'Text1';
                            _text2 = 'Text2';
                            _text3 = 'Text3';
                            _text4 = 'Text4';
                          });
                        },
                        child: set.initText('cancel'),
                      ),
                    ],
                  ),
                ],
              )),
          Padding(
              padding: set.initEdgeInsets(15.0, 20.0, 15.0, 0.0),
              child: Column(
                children: [
                  set.initText2('ConstraintBox\n約束', Colors.black, Colors.transparent, 24),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                        minWidth: double.infinity, //宽度尽可能大
                        minHeight: 50.0 //最小高度为50像素
                    ),
                    child: const SizedBox(
                        height: 5.0,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Colors.grey),
                        )
                    ),
                  )
                ],
              )),
          Padding(
              padding: set.initEdgeInsets(15.0, 20.0, 15.0, 0.0),
              child: Column(
                children: [
                  set.initText2('MoreConstraints\n父子類最大限制', Colors.black, Colors.transparent, 24),
                  ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 60.0, minHeight: 60.0), //父
                    child: ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: 90.0, minHeight: 20.0),//子
                        child: const DecoratedBox(
                          decoration: BoxDecoration(color: Colors.grey),
                        )
                    ),
                  )
                ],
              )),
          Padding(
              padding: set.initEdgeInsets(15.0, 20.0, 15.0, 0.0),
              child: Column(
                children: [
                  set.initText2('UnConstraintsBox\n取消約束', Colors.black, Colors.transparent, 24),
                  UnconstrainedBox(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(children: [Text('xx' * 21)]),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

}

class TestFlowDelegate extends FlowDelegate {
  EdgeInsets margin;

  TestFlowDelegate({this.margin = EdgeInsets.zero});

  double width = 0;
  double height = 0;

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top + 10;
    //计算每一个子widget的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i)!.width + x + margin.right + 10;
      if (w < context.size.width) {
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i)!.height + margin.top + margin.bottom;
        //绘制子widget(有优化)
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i)!.width + margin.left + margin.right + 10;
      }
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    // 指定Flow的大小，简单起见我们让宽度竟可能大，但高度指定为200，
    // 实际开发中我们需要根据子元素所占用的具体宽高来设置Flow大小
    return const Size(double.maxFinite, 300.0);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}

class LayoutBuilderRoute extends StatelessWidget {
  const LayoutBuilderRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _children = List.filled(6, set.initText2(' Hello World ', Colors.black, Colors.transparent, 20));
    // Column在本示例中在水平方向的最大宽度为屏幕的宽度
    return Container(
        color: Colors.grey.shade300,
        child: Column(
          children: [
            // 限制宽度为190，小于 200
            SizedBox(width: 190, child: ResponsiveColumn(children: _children)), // 'A'
            ResponsiveColumn(children: _children), // 'AA'
            const LayoutLogPrint(child: Text("xx", style: TextStyle(color: Colors.black, backgroundColor: Colors.transparent, fontSize: 20),)) // 下面介绍
          ],
        )
    );
  }
}