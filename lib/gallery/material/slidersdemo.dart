// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;

import 'package:flutter/material.dart';

class SlidersDemo extends StatefulWidget {
  @override
  _SlidersState createState() => _SlidersState();
}

class _SlidersState extends State<SlidersDemo> with RestorationMixin {
  final RestorableDouble _continuousValue = RestorableDouble(25);
  final RestorableDouble _discreteValue = RestorableDouble(20);

  @override
  String get restorationId => 'slider_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_continuousValue, 'continuous_value');
    registerForRestoration(_discreteValue, 'discrete_value');
  }

  @override
  void dispose() {
    _continuousValue.dispose();
    _discreteValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Semantics(
                label: 'SlidersEditableNumericalValue',
                child: SizedBox(
                  width: 64,
                  height: 48,
                  child: TextField(
                    textAlign: TextAlign.center,
                    onSubmitted: (value) {
                      final newValue = double.tryParse(value);
                      if (newValue != null && newValue != _continuousValue.value) {
                        setState(() {
                          _continuousValue.value = newValue.clamp(0, 100) as double;
                        });
                      }
                    },
                    keyboardType: TextInputType.number,
                    controller: TextEditingController(
                      text: _continuousValue.value.toStringAsFixed(0),
                    ),
                  ),
                ),
              ),
              Slider(
                value: _continuousValue.value,
                min: 0,
                max: 100,
                onChanged: (value) {
                  setState(() {
                    _continuousValue.value = value;
                  });
                },
              ),
              Text('SlidersContinuousWithEditableNumericalValue'),
            ],
          ),
          const SizedBox(height: 80),
          Column(
            children: [
              Slider(
                value: _discreteValue.value,
                min: 0,
                max: 200,
                divisions: 5,
                label: _discreteValue.value.round().toString(),
                onChanged: (value) {
                  setState(() {
                    _discreteValue.value = value;
                  });
                },
              ),
              Text('SlidersDiscrete'),
            ],
          ),
        ],
      ),
    );
  }
}

