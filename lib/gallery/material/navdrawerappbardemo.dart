// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

// Press the Navigation Drawer button to the left of AppBar to show
// a simple Drawer with two items.
class NavDrawerAppBarDemo extends StatefulWidget {
  const NavDrawerAppBarDemo({Key? key}) : super(key: key);

  @override
  State<NavDrawerAppBarDemo> createState() => _NavDrawerAppBarDemoState();
}

class _NavDrawerAppBarDemoState extends State<NavDrawerAppBarDemo> with RestorationMixin {
  final RestorableInt _selectedIndex = RestorableInt(0);

  @override
  String get restorationId => 'nav_rail_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedIndex, 'selected_index');
  }

  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String _text = '首頁';
    final destinationFirst = 'NavigationRailFirst';
    final destinationSecond = 'NavigationRailSecond';
    final destinationThird = 'NavigationRailThird';
    final selectedItem = <String>[
      destinationFirst,
      destinationSecond,
      destinationThird
    ];
    final drawerHeader = UserAccountsDrawerHeader(
      accountName: Text(
        'NavigationDrawerUserName',
      ),
      accountEmail: Text(
        'NavigationDrawerUserEmail',
      ),
      currentAccountPicture: const CircleAvatar(
        child: FlutterLogo(size: 42.0),
      ),
    );
    final drawerItems = ListView(
      children: [
        drawerHeader,
        ListTile(
          title: Text(
            'PageOne',
          ),
          leading: const Icon(Icons.favorite),
          onTap: () {
            Navigator.pop(context);
            setState(() {
              _text = 'PageOne';
            });
          },
        ),
        ListTile(
          title: Text(
            'PageTwo',
          ),
          leading: const Icon(Icons.comment),
          onTap: () {
            Navigator.pop(context);
            setState(() {
              _text = 'PageTwo';
            });
          },
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context){
          return IconButton(
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
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
      body: Row(
        children: [
          NavigationRail(
            leading: FloatingActionButton(
              onPressed: () {
                _text = '增加';
                setState(() {});
              },
              child: const Icon(Icons.add),
            ),
            selectedIndex: _selectedIndex.value,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex.value = index;
              });
            },
            labelType: NavigationRailLabelType.selected,
            destinations: [
              NavigationRailDestination(
                icon: const Icon(
                  Icons.favorite_border,
                ),
                selectedIcon: const Icon(
                  Icons.favorite,
                ),
                label: Text(
                  destinationFirst,
                ),
              ),
              NavigationRailDestination(
                icon: const Icon(
                  Icons.bookmark_border,
                ),
                selectedIcon: const Icon(
                  Icons.book,
                ),
                label: Text(
                  destinationSecond,
                ),
              ),
              NavigationRailDestination(
                icon: const Icon(
                  Icons.star_border,
                ),
                selectedIcon: const Icon(
                  Icons.star,
                ),
                label: Text(
                  destinationThird,
                ),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_text),
                Text(selectedItem[_selectedIndex.value])
              ],
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: drawerItems,
      ),
    );
  }
}