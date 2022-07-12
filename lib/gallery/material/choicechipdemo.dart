// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class ChoiceChipDemo extends StatefulWidget {
  @override
  _ChoiceChipDemoState createState() => _ChoiceChipDemoState();
}

class _ChoiceChipDemoState extends State<ChoiceChipDemo> with RestorationMixin {
  final RestorableIntN _indexSelected = RestorableIntN(null);

  @override
  String get restorationId => 'choice_chip_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_indexSelected, 'choice_chip');
  }

  @override
  void dispose() {
    _indexSelected.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: [
          ChoiceChip(
            label: Text('小'),
            selected: _indexSelected.value == 0,
            onSelected: (value) {
              setState(() {
                _indexSelected.value = value ? 0 : -1;
              });
            },
          ),
          const SizedBox(width: 8),
          ChoiceChip(
            label: Text('中'),
            selected: _indexSelected.value == 1,
            onSelected: (value) {
              setState(() {
                _indexSelected.value = value ? 1 : -1;
              });
            },
          ),
          const SizedBox(width: 8),
          ChoiceChip(
            label: Text('大'),
            selected: _indexSelected.value == 2,
            onSelected: (value) {
              setState(() {
                _indexSelected.value = value ? 2 : -1;
              });
            },
          ),
        ],
      ),
    );
  }
}

