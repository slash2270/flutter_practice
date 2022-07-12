import 'package:flutter/material.dart';
import 'package:flutter_practice/gesturedetector/customtapgesturerecognizer.dart';
import 'package:flutter_practice/view/eight.dart';

class CustomGestureDetector extends StatefulWidget {
  const CustomGestureDetector ({Key? key}) : super(key: key);

  @override
  State<CustomGestureDetector> createState() => _CustomGestureDetectorState();
}

class _CustomGestureDetectorState extends State<CustomGestureDetector> {

  String _strClick1 = '點擊', _strClick2 = '點擊';

//创建一个新的GestureDetector，用我们自定义的 CustomTapGestureRecognizer 替换默认的
  RawGestureDetector customGestureDetector({
    GestureTapCallback? onTap,
    GestureTapDownCallback? onTapDown,
    Widget? child,
  }) {
    return RawGestureDetector(
      child: child,
      gestures: {
        CustomTapGestureRecognizer:
        GestureRecognizerFactoryWithHandlers<CustomTapGestureRecognizer>(
              () => CustomTapGestureRecognizer(),
              (detector) {
            detector.onTap = onTap;
          },
        )
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return customGestureDetector(
      onTap: () => setState(() {_strClick1 = 'OutSideTap';}), //点击
      child: Container(
        width: 200,
        height: 200,
        color: Colors.indigoAccent,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            set.initText2(_strClick1, Colors.black, Colors.transparent, 20), //点击
            GestureDetector(
              onTap: () => setState(() {_strClick2 = 'InSideTap';}), //点击
              child: Container(
                alignment: Alignment.topCenter,
                width: 120,
                height: 120,
                color: Colors.grey,
                child: set.initText2(_strClick2, Colors.black, Colors.transparent, 20),
              ),
            )
          ],
        ),
      ),
    );
  }

}