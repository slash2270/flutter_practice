// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class TooltipDemo extends StatelessWidget {
  const TooltipDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'starterAppTooltipSearch',
      child: IconButton(
        color: Theme.of(context).colorScheme.primary,
        onPressed: () {},
        icon: const Icon(Icons.search),
      ),
    );
  }
}

