// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class InputChipDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InputChip(
      onPressed: () {},
      onDeleted: () {},
      avatar: const Icon(
        Icons.directions_bike,
        size: 20,
        color: Colors.black54,
      ),
      deleteIconColor: Colors.black54,
      label: Text('騎自行車'),
    );
  }
}

