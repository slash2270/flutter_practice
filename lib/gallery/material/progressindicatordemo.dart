// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

enum ProgressIndicatorDemoType{
  circular,
  linear
}

class ProgressIndicatorDemo extends StatefulWidget {
  const ProgressIndicatorDemo({Key? key}) : super(key: key);

  @override
  State<ProgressIndicatorDemo> createState() => _ProgressIndicatorDemoState();
}

class _ProgressIndicatorDemoState extends State<ProgressIndicatorDemo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
      animationBehavior: AnimationBehavior.preserve,
    )..forward();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.9, curve: Curves.fastOutSlowIn),
      reverseCurve: Curves.fastOutSlowIn,
    )..addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        _controller.forward();
      } else if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.stop();
    super.dispose();
  }

  Widget _buildCircular(BuildContext context) {
    return Column(
      children: [
        set.initText2('CircularProgressIndicatorTitle', Colors.black, Colors.transparent, 18),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 30),
            CircularProgressIndicator(value: _animation.value),
          ],
        ),
      ],
    );
  }

  Widget _buildLinear(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        set.initText2('LinearProgressIndicatorTitle', Colors.black, Colors.transparent, 18),
        const SizedBox(height: 5),
        const LinearProgressIndicator(),
        const SizedBox(height: 30),
        LinearProgressIndicator(value: _animation.value),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCircular(context),
        SizedBox(
          height: 20.0
        ),
        _buildLinear(context)
      ],
    );
  }
}

