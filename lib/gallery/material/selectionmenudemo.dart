// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

// Pressing the PopupMenuButton on the right of this item shows
// a menu whose items have text labels and icons and a divider
// That separates the first three items from the last one.
class SectionedMenuDemo extends StatelessWidget {
  const SectionedMenuDemo({Key? key, required this.showInSnackBar})
      : super(key: key);

  final void Function(String value) showInSnackBar;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('MenuAnItemWithASectionedMenu'),
      trailing: PopupMenuButton<String>(
        padding: EdgeInsets.zero,
        onSelected: (value) =>
            showInSnackBar('MenuSelected $value'),
        itemBuilder: (context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'MenuPreview',
            child: ListTile(
              leading: const Icon(Icons.visibility),
              title: Text(
                'MenuPreview',
              ),
            ),
          ),
          PopupMenuItem<String>(
            value: 'MenuShare',
            child: ListTile(
              leading: const Icon(Icons.person_add),
              title: Text(
                'MenuShare',
              ),
            ),
          ),
          PopupMenuItem<String>(
            value: 'MenuGetLink',
            child: ListTile(
              leading: const Icon(Icons.link),
              title: Text(
                'MenuGetLink',
              ),
            ),
          ),
          const PopupMenuDivider(),
          PopupMenuItem<String>(
            value: 'MenuRemove',
            child: ListTile(
              leading: const Icon(Icons.delete),
              title: Text(
                'Remove',
              ),
            ),
          ),
        ],
      ),
    );
  }
}