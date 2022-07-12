import 'package:flutter/material.dart';
import 'package:flutter_practice/animation/slidetransitionreverse.dart';
import 'package:flutter_practice/animation/slidetransitionx.dart';
import 'package:flutter_practice/set.dart';

import '../value/colorvalue.dart';

Set set = Set();

class AnimatedSwitcherWidget extends StatefulWidget {
  const AnimatedSwitcherWidget({Key? key}) : super(key: key);

  @override
  _AnimatedSwitcherWidget createState() => _AnimatedSwitcherWidget();
}

class _AnimatedSwitcherWidget extends State<AnimatedSwitcherWidget> {
  int _countScale = 0, _countSlide = 0, _countSlideReverse = 0, _countSlideX = 0;
  final EdgeInsetsGeometry _paddingTop = const EdgeInsets.only(top: 10);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
              padding: _paddingTop,
              child: Column(
                children: [
                  set.initText2('Counter Scale', ColorValue.black, ColorValue.transParent, 18),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      //执行缩放动画
                      return ScaleTransition(child: child, scale: animation);
                    },
                    child: Text('$_countScale',
                      //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
                      key: ValueKey<int>(_countScale),
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        child: const Text('+1',),
                        onPressed: () {
                          setState(() {
                            _countScale += 1;
                          });
                        },
                      ),
                      ElevatedButton(
                        child: const Text('-1',),
                        onPressed: () {
                          setState(() {
                            _countScale -= 1;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              )
          ),
          Container(
              padding: _paddingTop,
              child: Column(
                children: [
                  set.initText2('Counter Slide', ColorValue.black, ColorValue.transParent, 18),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      var tween = Tween<Offset>(begin: const Offset(2, 0), end: const Offset(0, 0));
                      return SlideTransition( // 實現滑行動畫
                        child: child,
                        position: tween.animate(animation),
                      );
                    },
                    child: Text('$_countSlide',
                      //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
                      key: ValueKey<int>(_countSlide),
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        child: const Text('+1',),
                        onPressed: () {
                          setState(() {
                            _countSlide += 1;
                          });
                        },
                      ),
                      ElevatedButton(
                        child: const Text('-1',),
                        onPressed: () {
                          setState(() {
                            _countSlide -= 1;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              )
          ),
          Container(
              padding: _paddingTop,
              child: Column(
                children: [
                  set.initText2('Counter SlideReverse', ColorValue.black, ColorValue.transParent, 18),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      var tween = Tween<Offset>(begin: const Offset(2, 0), end: const Offset(0, 0));
                      return SlideTransitionReverse( // 實現滑行動畫
                        child: child,
                        position: tween.animate(animation),
                      );
                    },
                    child: Text('$_countSlideReverse',
                      //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
                      key: ValueKey<int>(_countSlideReverse),
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        child: const Text('+1',),
                        onPressed: () {
                          setState(() {
                            _countSlideReverse += 1;
                          });
                        },
                      ),
                      ElevatedButton(
                        child: const Text('-1',),
                        onPressed: () {
                          setState(() {
                            _countSlideReverse -= 1;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              )
           ),
          Container(
              padding: _paddingTop,
              child: Column(
                children: [
                  set.initText2('Counter SlideX', ColorValue.black, ColorValue.transParent, 18),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return SlideTransitionX( // 實現滑行動畫
                        child: child,
                        direction: AxisDirection.down, //上入下出
                        position: animation,
                      );
                    },
                    child: Text('$_countSlideX',
                      //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
                      key: ValueKey<int>(_countSlideX),
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        child: const Text('+1',),
                        onPressed: () {
                          setState(() {
                            _countSlideX += 1;
                          });
                        },
                      ),
                      ElevatedButton(
                        child: const Text('-1',),
                        onPressed: () {
                          setState(() {
                            _countSlideX -= 1;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              )
            ),
           ],
         );
       }
}