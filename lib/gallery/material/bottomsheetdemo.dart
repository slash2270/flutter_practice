// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

class _BottomSheetContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          SizedBox(
            height: 70,
            child: Center(
              child: Text('標題', textAlign: TextAlign.center,),
            ),
          ),
          const Divider(thickness: 1),
          Expanded(
            child: ListView.builder(
              itemCount: 21,
              itemBuilder: (context, index) {
                return ListTile(
                  title: set.initText('物品: ${index + 1}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BottomSheetDemo extends StatefulWidget {
  @override
  BottomSheetDemoState createState() => BottomSheetDemoState();
}

class BottomSheetDemoState extends State<BottomSheetDemo> with RestorationMixin{
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  late VoidCallback? _showPersistentBottomSheetCallBack;
  final RestorableBool _showFab = RestorableBool(true);
  final RestorableInt _currentFabLocation = RestorableInt(0);

  static const List<FloatingActionButtonLocation> _fabLocations = [
    FloatingActionButtonLocation.endDocked,
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.endFloat,
    FloatingActionButtonLocation.centerFloat,
  ];

  @override
  String get restorationId => 'bottom_app_bar_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_showFab, 'show_fab');
    registerForRestoration(_currentFabLocation, 'fab_location');
  }

  @override
  void initState() {
    super.initState();
    _showPersistentBottomSheetCallBack = _showPersistentBottomSheet;
  }

  @override
  void dispose() {
    _showFab.dispose();
    _currentFabLocation.dispose();
    super.dispose();
  }

  void _showPersistentBottomSheet() {
    setState(() {
      _showPersistentBottomSheetCallBack = null;
    });
    _scaffoldKey.currentState?.showBottomSheet<void>((context) {
        return _BottomSheetContent();
      },
      elevation: 25,
    )
        .closed
        .whenComplete(() {
      if (mounted) {
        setState(() {
          // Re-enable the bottom sheet button.
          _showPersistentBottomSheetCallBack = _showPersistentBottomSheet;
        });
      }
    });
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return _BottomSheetContent();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: set.initText('FiftyTwo Page'),
      ),
      body: Padding(
        padding: set.initEdgeInsetsTop(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: _showPersistentBottomSheetCallBack,
              child: set.initText('顯示底部資訊1'),
            ),
            ElevatedButton(
              onPressed: (){
                _showModalBottomSheet(context);
              },
              child: set.initText('顯示底部資訊2'),
            ),
          ],
        ),
      ),
      floatingActionButton: _showFab.value
          ? FloatingActionButton(
        onPressed: () {},
        tooltip: 'BottomFAB',
        child: set.initIcon(Icons.add),
      )   : null ,
      floatingActionButtonLocation: _fabLocations[_currentFabLocation.value],
    );
  }
}