// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class ActionChipDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ActionChip(
      onPressed: () {},
      avatar: const Icon(
        Icons.brightness_5,
        color: Colors.black54,
      ),
      label: Text('開燈'),
    );
  }
}

