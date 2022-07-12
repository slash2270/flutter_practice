// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;

import 'package:flutter/material.dart';

class RangeSlidersDemo extends StatefulWidget {
  @override
  _RangeSlidersState createState() => _RangeSlidersState();
}

class _RangeSlidersState extends State<RangeSlidersDemo> with RestorationMixin {
  final RestorableDouble _continuousStartValue = RestorableDouble(25);
  final RestorableDouble _continuousEndValue = RestorableDouble(75);
  final RestorableDouble _discreteStartValue = RestorableDouble(40);
  final RestorableDouble _discreteEndValue = RestorableDouble(120);

  @override
  String get restorationId => 'range_sliders_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_continuousStartValue, 'continuous_start_value');
    registerForRestoration(_continuousEndValue, 'continuous_end_value');
    registerForRestoration(_discreteStartValue, 'discrete_start_value');
    registerForRestoration(_discreteEndValue, 'discrete_end_value');
  }

  @override
  void dispose() {
    _continuousStartValue.dispose();
    _continuousEndValue.dispose();
    _discreteStartValue.dispose();
    _discreteEndValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final continuousValues = RangeValues(
      _continuousStartValue.value,
      _continuousEndValue.value,
    );
    final discreteValues = RangeValues(
      _discreteStartValue.value,
      _discreteEndValue.value,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              RangeSlider(
                values: continuousValues,
                min: 0,
                max: 100,
                onChanged: (values) {
                  setState(() {
                    _continuousStartValue.value = values.start;
                    _continuousEndValue.value = values.end;
                  });
                },
              ),
              Text('SlidersContinuous'),
            ],
          ),
          const SizedBox(height: 80),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RangeSlider(
                values: discreteValues,
                min: 0,
                max: 200,
                divisions: 5,
                labels: RangeLabels(
                  discreteValues.start.round().toString(),
                  discreteValues.end.round().toString(),
                ),
                onChanged: (values) {
                  setState(() {
                    _discreteStartValue.value = values.start;
                    _discreteEndValue.value = values.end;
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

