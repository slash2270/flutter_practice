// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

enum ListDemoType{
  twoLine,
}

class ListDemo1 extends StatelessWidget {
  const ListDemo1({Key? key, required this.type}) : super(key: key);

  final ListDemoType type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('FiftyEight Page'),
      ),
      body: Scrollbar(
        child: ListView(
          restorationId: 'list_demo_list_view',
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            for (int index = 1; index < 21; index++)
              ListTile(
                leading: ExcludeSemantics(
                  child: CircleAvatar(child: Text('$index')),
                ),
                title: Text(
                  'ListDemoItem'),
              ),
          ],
        ),
      ),
    );
  }

}
// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

class ListDemo2 extends StatelessWidget {
  const ListDemo2({Key? key, required this.type}) : super(key: key);

  final ListDemoType type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('ListsTitle'),
      ),
      body: Scrollbar(
        child: ListView(
          restorationId: 'list_demo_list_view',
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            for (int index = 1; index < 21; index++)
              ListTile(
                leading: ExcludeSemantics(
                  child: CircleAvatar(child: Text('$index')),
                ),
                title: Text(
                  'BottomSheetItem',
                ),
                subtitle: type == ListDemoType.twoLine
                    ? Text('Secondary')
                    : null,
              ),
          ],
        ),
      ),
    );
  }
}

