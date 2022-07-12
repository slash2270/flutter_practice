import 'package:flutter/material.dart';
import 'package:flutter_practice/pointerdownevent/hittestblockerwidget.dart';
import 'package:flutter_practice/value/colorvalue.dart';
import 'package:flutter_practice/view/eight.dart';

class HitTestBlockerTest extends StatefulWidget {
  const HitTestBlockerTest({Key? key}) : super(key: key);

  @override
  State<HitTestBlockerTest> createState() => _HitTestBlockerTestState();
}

class _HitTestBlockerTestState extends State<HitTestBlockerTest> {
  String _strClick1 = '點擊', _strClick2 = '點擊';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.center,
            color: Colors.pinkAccent,
            width: 300.0,
            height: 225.0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                HitTestBlockerWidget(child: childContainer(1),),
                HitTestBlockerWidget(child: childContainer(2),),
              ],
            )),
        set.initText2('GestureDetector 命中測試', ColorValue.black, ColorValue.transParent, 20),
        Container(
            alignment: Alignment.center,
            color: Colors.cyanAccent,
            width: 300.0,
            height: 225.0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                HitTestBlockerWidget(child: childGesture(1),),
                HitTestBlockerWidget(child: childGesture(2),),
              ],
            )),
      ],
    );
  }

  Widget childContainer(int index) {
    return Listener(
      child: Container(
        alignment: Alignment.center,
        width: 200,
        height: 200,
        color: Colors.grey,
        child: set.initText2(_strClick1, Colors.black, ColorValue.transParent, 20),
      ),
      onPointerDown: (PointerDownEvent event) {
        setState(() {
          _strClick1 = 'EventDown -> $index';
        });
      },
    );
  }

  Widget childGesture(int index) {
    return GestureDetector( // 将 Listener 换为 GestureDetector
      child: Container(
        alignment: Alignment.center,
        width: 200,
        height: 200,
        color: Colors.grey,
        child: set.initText2(_strClick2, Colors.black, ColorValue.transParent, 20),
      ),
      onTap: () {
        setState(() {
          _strClick2 = 'GestureDetector -> $index';
        });
      },
    );
  }

}
