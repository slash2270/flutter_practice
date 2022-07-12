// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';

class CupertinoSegmentedControlDemo extends StatefulWidget {
  const CupertinoSegmentedControlDemo({Key? key}) : super(key: key);

  @override
  State<CupertinoSegmentedControlDemo> createState() => _CupertinoSegmentedControlDemoState();
}

class _CupertinoSegmentedControlDemoState
    extends State<CupertinoSegmentedControlDemo> with RestorationMixin {
  RestorableInt currentSegment = RestorableInt(0);

  @override
  String get restorationId => 'cupertino_segmented_control';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(currentSegment, 'current_segment');
  }

  void onValueChanged(int? newValue) {
    setState(() {
      currentSegment.value = newValue!;
    });
  }

  @override
  Widget build(BuildContext context) {
    const segmentedControlMaxWidth = 500.0;
    final children = <int, Widget>{
      0: Text('大'),
      1: Text('中'),
      2: Text('小'),
    };
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        middle: Text(
          'CupertinoSegmentedControlTitle',
        ),
      ),
      child: DefaultTextStyle(
        style: CupertinoTheme.of(context)
            .textTheme
            .textStyle
            .copyWith(fontSize: 13),
        child: SafeArea(
          child: ListView(
            children: [
              SizedBox(height: 15),
              SizedBox(
                width: segmentedControlMaxWidth,
                child: CupertinoSegmentedControl<int>(
                  children: children,
                  onValueChanged: onValueChanged,
                  groupValue: currentSegment.value,
                ),
              ),
              SizedBox(
                width: segmentedControlMaxWidth,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: CupertinoSlidingSegmentedControl<int>(
                    children: children,
                    onValueChanged: onValueChanged,
                    groupValue: currentSegment.value,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                height: 300,
                alignment: Alignment.center,
                child: children[currentSegment.value],
              ),
            ],
          ),
        ),
      ),
    );
  }
}