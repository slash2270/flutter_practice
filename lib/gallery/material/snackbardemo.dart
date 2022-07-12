// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class SnackBarsDemo extends StatelessWidget {
  const SnackBarsDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('SnackBarsText'),
            action: SnackBarAction(
              label: 'SnackBarsActionButtonLabel',
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('SnackBarsAction',)));
              },
            ),
          ));
        },
        child: Text('SnackBarsButtonLabel'),
      ),
    );
  }
}