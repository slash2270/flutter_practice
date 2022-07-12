// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class FilterChipDemo extends StatefulWidget {
  @override
  _FilterChipDemoState createState() => _FilterChipDemoState();
}

class _FilterChipDemoState extends State<FilterChipDemo>
    with RestorationMixin {
  final RestorableBool isSelectedElevator = RestorableBool(false);
  final RestorableBool isSelectedWasher = RestorableBool(false);
  final RestorableBool isSelectedFireplace = RestorableBool(false);

  @override
  String get restorationId => 'filter_chip_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(isSelectedElevator, 'selected_elevator');
    registerForRestoration(isSelectedWasher, 'selected_washer');
    registerForRestoration(isSelectedFireplace, 'selected_fireplace');
  }

  @override
  void dispose() {
    isSelectedElevator.dispose();
    isSelectedWasher.dispose();
    isSelectedFireplace.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chips = [
      FilterChip(
        label: Text('電梯'),
        selected: isSelectedElevator.value,
        onSelected: (value) {
          setState(() {
            isSelectedElevator.value = !isSelectedElevator.value;
          });
        },
      ),
      FilterChip(
        label: Text('洗衣機'),
        selected: isSelectedWasher.value,
        onSelected: (value) {
          setState(() {
            isSelectedWasher.value = !isSelectedWasher.value;
          });
        },
      ),
      FilterChip(
        label: Text('壁爐'),
        selected: isSelectedFireplace.value,
        onSelected: (value) {
          setState(() {
            isSelectedFireplace.value = !isSelectedFireplace.value;
          });
        },
      ),
    ];

    return Center(
      child: Wrap(
        children: [
          for (final chip in chips)
            Padding(
              padding: const EdgeInsets.all(4),
              child: chip,
            )
        ],
      ),
    );
  }
}

