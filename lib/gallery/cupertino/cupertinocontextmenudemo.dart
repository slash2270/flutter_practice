// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoContextMenuDemo extends StatelessWidget {
  const CupertinoContextMenuDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            width: 100,
            height: 100,
            child: CupertinoContextMenu(
              actions: [
                CupertinoContextMenuAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'CupertinoContextMenuActionOne',
                  ),
                ),
                CupertinoContextMenuAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'CupertinoContextMenuActionTwo',
                  ),
                ),
              ],
              child: const FlutterLogo(size: 250),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(30),
          child: Text(
            'CupertinoContextMenuActionText',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

