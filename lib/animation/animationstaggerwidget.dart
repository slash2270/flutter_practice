import 'package:flutter/material.dart';
import 'package:flutter_practice/animation/animatedimagewidget.dart';

import 'animationstagger.dart';

class AnimationStaggerWidget extends StatefulWidget {
  const AnimationStaggerWidget({Key? key}) : super(key: key);

  @override
  _AnimationStaggerWidgetState createState() => _AnimationStaggerWidgetState();
}

class _AnimationStaggerWidgetState extends State<AnimationStaggerWidget> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
  }

  _playAnimation() async {
    try {
      //先正向执行动画
      await _controller.forward().orCancel;
      //再反向执行动画
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () => _playAnimation(),
            child: set.initText2('start', Colors.white, Colors.transparent, 18),
          ),
          Container(
            width: 300.0,
            height: 400.0,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              border: Border.all(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            //调用我们定义的交错动画Widget
            child: AnimationStagger(controller: _controller),
          ),
        ],
      ),
    );
  }
}