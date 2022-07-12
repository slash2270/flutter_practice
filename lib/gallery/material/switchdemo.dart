// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class SwitchDemo extends StatefulWidget {
  @override
  _SwitchDemoState createState() => _SwitchDemoState();
}

class _SwitchDemoState extends State<SwitchDemo> with RestorationMixin {
  RestorableBool switchValue = RestorableBool(false);

  @override
  String get restorationId => 'switch_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(switchValue, 'switch_value');
  }

  @override
  void dispose() {
    switchValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Semantics(
        container: true,
        label: 'SelectionControlsSwitchTitle',
        child: Switch(
          value: switchValue.value,
          onChanged: (value) {
            setState(() {
              switchValue.value = value;
            });
          },
        ),
      ),
    );
  }
}