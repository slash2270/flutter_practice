import 'package:flutter/material.dart';
import 'package:flutter_practice/value/colorvalue.dart';
import 'package:flutter_practice/view/eight.dart';

class HitStackTest extends StatefulWidget {
  const HitStackTest({Key? key}) : super(key: key);

  @override
  State<HitStackTest> createState() => _HitStackTestState();
}

class _HitStackTestState extends State<HitStackTest> {
  String _strClick1 = '點擊', _strClick2 = '點擊', _strClick3 = '點擊', _strClick4 = '點擊';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        set.initText2('Stack 命中測試', ColorValue.black, ColorValue.transParent, 20),
        Container(
            alignment: Alignment.center,
            color: Colors.lime,
            width: 300.0,
            height: 225.0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                childContainer(1),
                childContainer(2),
              ],
            )),
        set.initText2('Behavior 命中測試', ColorValue.black, ColorValue.transParent, 20),
        Container(
            alignment: Alignment.center,
            color: Colors.indigo,
            width: 300.0,
            height: 225.0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                childBehavior1(1),
                childBehavior1(2),
              ],
            )),
        Container(
            alignment: Alignment.center,
            color: Colors.deepOrange,
            width: 300.0,
            height: 225.0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                childBehavior2(1),
                childBehavior2(2),
              ],
            )),
        set.initText2('Ignore 命中測試', ColorValue.black, ColorValue.transParent, 20),
        Container(
            alignment: Alignment.center,
            color: Colors.teal,
            width: 300.0,
            height: 225.0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                IgnorePointer(child: childIgnore(1)),
                IgnorePointer(child: childIgnore(2)),
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

  Widget childIgnore(int index) {
    return Listener(
      child: Container(
        alignment: Alignment.center,
        width: 200,
        height: 200,
        color: Colors.grey,
        child: set.initText2(_strClick4, Colors.black, ColorValue.transParent, 20),
      ),
      onPointerDown: (PointerDownEvent event) {
        setState(() {
          _strClick4 = '$index EventDown -> ${event.down}';
        });
      },
    );
  }

  Widget childBehavior1(int index) {
    return Listener(
      behavior: HitTestBehavior.translucent, // 放开此行，点击会同时输出 2 和 1
      child: Center(
        child: SizedBox.expand(
          child: Center(
            child: set.initText2(_strClick2, Colors.black, ColorValue.transParent, 20),
          ),
        ),
      ),
      onPointerDown: (PointerDownEvent event) {
        setState(() {
          _strClick2 = 'Translucent -> $index';
        });
      },
    );
  }

  Widget childBehavior2(int index) {
    return Listener(
      behavior: HitTestBehavior.opaque, // 放开此行，点击只会输出 2
      child: SizedBox.expand(
        child: Center(
          child: set.initText2(_strClick3, Colors.black, ColorValue.transParent, 20),
        ),
      ),
      onPointerDown: (PointerDownEvent event) {
        setState(() {
          _strClick3 = 'Opaque -> $index';
        });
      },
    );
  }

}
