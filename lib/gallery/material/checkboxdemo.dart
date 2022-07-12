// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class CheckboxDemo extends StatefulWidget {
  @override
  _CheckboxDemoState createState() => _CheckboxDemoState();
}

class _CheckboxDemoState extends State<CheckboxDemo> with RestorationMixin {
  RestorableBoolN checkboxValueA = RestorableBoolN(true);
  RestorableBoolN checkboxValueB = RestorableBoolN(false);
  RestorableBoolN checkboxValueC = RestorableBoolN(null);

  @override
  String get restorationId => 'checkbox_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(checkboxValueA, 'checkbox_a');
    registerForRestoration(checkboxValueB, 'checkbox_b');
    registerForRestoration(checkboxValueC, 'checkbox_c');
  }

  @override
  void dispose() {
    checkboxValueA.dispose();
    checkboxValueB.dispose();
    checkboxValueC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: checkboxValueA.value,
            onChanged: (value) {
              setState(() {
                checkboxValueA.value = value;
              });
            },
          ),
          Checkbox(
            value: checkboxValueB.value,
            onChanged: (value) {
              setState(() {
                checkboxValueB.value = value;
              });
            },
          ),
          Checkbox(
            value: checkboxValueC.value,
            tristate: true,
            onChanged: (value) {
              setState(() {
                checkboxValueC.value = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

