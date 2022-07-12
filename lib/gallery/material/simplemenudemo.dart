// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

enum SimpleValue{
  one,
  two,
  three
}

// This entire list item is a PopupMenuButton. Tapping anywhere shows
// a menu whose current value is highlighted and aligned over the
// list item's center line.
class SimpleMenuDemo extends StatefulWidget {
  const SimpleMenuDemo({
    Key? key,
    required this.showInSnackBar,
  }) : super(key: key);

  final void Function(String value) showInSnackBar;

  @override
  _SimpleMenuDemoState createState() => _SimpleMenuDemoState();
}

class _SimpleMenuDemoState extends State<SimpleMenuDemo> {
  late SimpleValue _simpleValue;

  void showAndSetMenuSelection(BuildContext context, SimpleValue value) {
    setState(() {
      _simpleValue = value;
    });
    widget.showInSnackBar(simpleValueToString(context, value));
  }

  String simpleValueToString(BuildContext context, SimpleValue value) {
    return {
      SimpleValue.one: 'MenuItemValueOne',
      SimpleValue.two: 'MenuItemValueTwo',
      SimpleValue.three: 'MenuItemValueThree',
    }[value]!;
  }

  @override
  void initState() {
    super.initState();
    _simpleValue = SimpleValue.two;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SimpleValue>(
      padding: EdgeInsets.zero,
      initialValue: _simpleValue,
      onSelected: (value) => showAndSetMenuSelection(context, value),
      itemBuilder: (context) => <PopupMenuItem<SimpleValue>>[
        PopupMenuItem<SimpleValue>(
          value: SimpleValue.one,
          child: Text(simpleValueToString(
            context,
            SimpleValue.one,
          )),
        ),
        PopupMenuItem<SimpleValue>(
          value: SimpleValue.two,
          child: Text(simpleValueToString(
            context,
            SimpleValue.two,
          )),
        ),
        PopupMenuItem<SimpleValue>(
          value: SimpleValue.three,
          child: Text(simpleValueToString(
            context,
            SimpleValue.three,
          )),
        ),
      ],
      child: ListTile(
        title: Text('MenuAnItemWithASimpleMenu'),
        subtitle: Text(simpleValueToString(context, _simpleValue)),
      ),
    );
  }
}

