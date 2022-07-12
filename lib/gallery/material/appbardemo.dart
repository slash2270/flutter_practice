// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class AppBarDemo extends StatefulWidget {
  const AppBarDemo({Key? key}) : super(key: key);

  @override
  State<AppBarDemo> createState() => _AppBarDemoState();
}

class _AppBarDemoState extends State<AppBarDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        title: Text(
          'FortyEight Page',
        ),
        actions: [
          IconButton(
            tooltip: 'Favorite',
            icon: const Icon(
              Icons.favorite,
            ),
            onPressed: () {},
          ),
          IconButton(
            tooltip: 'Search',
            icon: const Icon(
              Icons.search,
            ),
            onPressed: () {},
          ),
          PopupMenuButton<Text>(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text(
                    'First',
                  ),
                ),
                PopupMenuItem(
                  child: Text(
                    'Two',
                  ),
                ),
                PopupMenuItem(
                  child: Text(
                    'Three',
                  ),
                ),
              ];
            },
          )
        ],
      ),
      body: Center(
        child: Text('首頁',),
      ),
    );
  }
}

