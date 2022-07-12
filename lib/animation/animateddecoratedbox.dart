import 'package:flutter/material.dart';

class AnimatedDecoratedBox extends StatefulWidget {
  const AnimatedDecoratedBox({Key? key, required this.decoration, required this.child, this.curve = Curves.linear, required this.duration, this.reverseDuration,}) : super(key: key);

  final BoxDecoration decoration;
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Duration? reverseDuration;

  //final BoxDecoration decoration;
  //final Widget child;

  @override
  _AnimatedDecoratedBoxState createState() => _AnimatedDecoratedBoxState();
}

class _AnimatedDecoratedBoxState extends State<AnimatedDecoratedBox> with SingleTickerProviderStateMixin {

  @protected
  AnimationController get controller => _controller;
  late AnimationController _controller;

  Animation<double> get animation => _animation;
  late Animation<double> _animation;

  late DecorationTween _tween;

  ///Tween<T> visitor(
  ///Tween<T> tween, //当前的tween，第一次调用为null
  ///    T targetValue, // 终止状态
  ///TweenConstructor<T> constructor，//Tween构造器，在上述三种情况下会被调用以更新tween
  ///);

  /*late DecorationTween _decoration;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _decoration = visitor(_decoration, widget.decoration, (value) => DecorationTween(begin: value),) as DecorationTween;
  }*/

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      reverseDuration: widget.reverseDuration,
      vsync: this,
    );
    _tween = DecorationTween(begin: widget.decoration);
    _updateCurve();
  }

  void _updateCurve() {
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
  }

  @override
  void didUpdateWidget(AnimatedDecoratedBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.curve != oldWidget.curve) _updateCurve();
    _controller.duration = widget.duration;
    _controller.reverseDuration = widget.reverseDuration;
    //正在执行过渡动画
    if (widget.decoration != (_tween.end ?? _tween.begin)) {
      _tween
        ..begin = _tween.evaluate(_animation)
        ..end = widget.decoration;
      _controller
        ..value = 0.0
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return DecoratedBox(
          decoration: _tween.animate(_animation).value,
          child: child,
        );
      },
      child: widget.child,
    );
    /*return DecoratedBox(
      decoration: _decoration.evaluate(animation),
      child: widget.child,
    );*/
  }
}