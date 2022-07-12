// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';

class CupertinoSwitchDemo extends StatefulWidget {
  const CupertinoSwitchDemo({Key? key}) : super(key: key);

  @override
  State<CupertinoSwitchDemo> createState() => _CupertinoSwitchDemoState();
}

class _CupertinoSwitchDemoState extends State<CupertinoSwitchDemo>
    with RestorationMixin {
  final RestorableBool _switchValue = RestorableBool(false);

  @override
  String get restorationId => 'cupertino_switch_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_switchValue, 'switch_value');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Semantics(
          container: true,
          label: 'SelectionControlsSwitchTitle',
          child: CupertinoSwitch(
            value: _switchValue.value,
            onChanged: (value) {
              setState(() {
                _switchValue.value = value;
              });
            },
          ),
        ),
    );
  }
}