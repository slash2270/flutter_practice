import 'package:flutter/material.dart';

class AnimationStagger extends StatelessWidget {
  AnimationStagger({Key? key, required this.controller,}) : super(key: key) {
    //高度动画
    height = Tween<double>(
      begin: 0.0,
      end: 300.0,
    ).animate(
      CurvedAnimation( //间隔，前60%的动画时间
        parent: controller,
        curve: const Interval(0.0, 0.6, curve: Curves.ease,),
      ),
    );

    color = ColorTween(
      begin: Colors.green,
      end: Colors.white,
    ).animate(
      CurvedAnimation( //间隔，前60%的动画时间
        parent: controller,
        curve: const Interval(
          0.0, 0.6,
          curve: Curves.ease,
        ),
      ),
    );

    padding = Tween<EdgeInsets>(
      begin: const EdgeInsets.only(left: 0.0),
      end: const EdgeInsets.only(left: 100.0),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.6, 1.0, //间隔，后40%的动画时间
          curve: Curves.ease,
        ),
      ),
    );
  }

  late final Animation<double> controller;
  late final Animation<double> height;
  late final Animation<EdgeInsets> padding;
  late final Animation<Color?> color;

  Widget _buildAnimation(BuildContext context, child) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: padding.value,
      child: Container(
        color: color.value,
        width: 50.0,
        height: height.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}