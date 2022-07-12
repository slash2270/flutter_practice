// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';

class CupertinoButtonDemo extends StatelessWidget {
  const CupertinoButtonDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CupertinoButton(
          onPressed: () {},
          child: Text(
            'cupertinoButton',
          ),
        ),
        const SizedBox(height: 16),
        CupertinoButton.filled(
          onPressed: () {},
          child: Text(
            'cupertinoButtonWithBackground',
          ),
        ),
      ],
    );
  }
}

