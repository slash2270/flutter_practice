import 'package:flutter/material.dart';
import 'package:flutter_practice/animation/animationreuse.dart';
import 'package:flutter_practice/set.dart';

import '../value/colorvalue.dart';

Set set = Set();
String imagePath = "images/ellen.jpeg";

class AnimatedImageWidget extends AnimatedWidget {
  const AnimatedImageWidget ({Key? key, required Animation<double> animation,}) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return  Center(
      child: Image.asset(
        imagePath,
        width: animation.value,
        height: animation.value,
      ),
    );
  }
}

class ScaleAnimationRoute extends StatefulWidget {
  const ScaleAnimationRoute({Key? key}) : super(key: key);

  @override
  _ScaleAnimationRouteState createState() => _ScaleAnimationRouteState();
}

//需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class _ScaleAnimationRouteState extends State<ScaleAnimationRoute> with TickerProviderStateMixin {
  late Animation<double> _animation, _animationListener; // 控制動畫
  late AnimationController _controller, _controllerListener;

  @override
  initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 3000),
        vsync: this
    );
    _controllerListener = AnimationController(
        duration: const Duration(milliseconds: 1000),
        vsync: this
    );

    //使用弹性曲线
    Animation<double> curve = CurvedAnimation(parent: _controller, curve: Curves.bounceIn);
    //图片宽高从0变到300
    _animation = Tween(begin: 0.0, end: 300.0).animate(curve)
      ..addListener(() {
        setState(() => {});
      });

    _animationListener = Tween(begin: 0.0, end: 300.0).animate(_controllerListener);
    _animationListener.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画执行结束时反向执行动画
        _controllerListener.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //动画恢复到初始状态时执行动画（正向）
        _controllerListener.forward();
      }
    });

    //启动动画(正向执行)
    _controller.forward();
    _controllerListener.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        set.initText2('Animated Widget', ColorValue.black, ColorValue.transParent, 20),
        widgetType(),
        set.initText2('Animation Builder', ColorValue.black, ColorValue.transParent, 20),
        builderType(),
        set.initText2('Animation Class', ColorValue.black, ColorValue.transParent, 20),
        classType(),
        set.initText2('Animation StatusListener', ColorValue.black, ColorValue.transParent, 20),
        listenerType(),
      ],
    );
  }

  Widget widgetType() {
    return AnimatedImageWidget (animation: _animation,);
  }

  Widget builderType() {
    return AnimatedBuilder(animation: _animation, child: Image.asset(imagePath), builder: (BuildContext ctx, child) {
        return Center(
          child: SizedBox(
            height: _animation.value,
            width: _animation.value,
            child: child,
          ),
        );
      },
    );
  }

  Widget classType() {
    return AnimationReuse(
      child: Image.asset(imagePath),
      animation: _animation,
    );
  }

  Widget listenerType(){
    return AnimationReuse(
      child: Image.asset(imagePath),
      animation: _animationListener,
    );
  }

  @override
  dispose() {
    //路由销毁时需要释放动画资源
    _controller.dispose();
    _controllerListener.dispose();
    super.dispose();
  }
}