// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

enum CheckedValue{
  one,
  two,
  three,
  four
}

// Pressing the PopupMenuButton on the right of this item shows a menu
// whose items have checked icons that reflect this app's state.
class ChecklistMenuDemo extends StatefulWidget {
  const ChecklistMenuDemo({
    Key? key,
    required this.showInSnackBar,
  }) : super(key: key);

  final void Function(String value) showInSnackBar;

  @override
  _ChecklistMenuDemoState createState() => _ChecklistMenuDemoState();
}

class _RestorableCheckedValues extends RestorableProperty<Set<CheckedValue>> {
  Set<CheckedValue> _checked = <CheckedValue>{};

  void check(CheckedValue value) {
    _checked.add(value);
    notifyListeners();
  }

  void uncheck(CheckedValue value) {
    _checked.remove(value);
    notifyListeners();
  }

  bool isChecked(CheckedValue value) => _checked.contains(value);

  Iterable<String> checkedValuesToString(BuildContext context) {
    return _checked.map((value) {
      return {
        CheckedValue.one: 'MenuOne',
        CheckedValue.two: 'MenuTwo',
        CheckedValue.three: 'MenuThree',
        CheckedValue.four: 'MenuFour',
      }[value]!;
    });
  }

  @override
  Set<CheckedValue> createDefaultValue() => _checked;

  @override
  Set<CheckedValue> initWithValue(Set<CheckedValue> a) {
    _checked = a;
    return _checked;
  }

  @override
  Object toPrimitives() => _checked.map((value) => value.index).toList();

  @override
  Set<CheckedValue> fromPrimitives(Object? data) {
    final checkedValues = data as List<dynamic>;
    return Set.from(checkedValues.map<CheckedValue>((dynamic id) {
      return CheckedValue.values[id as int];
    }));
  }
}

class _ChecklistMenuDemoState extends State<ChecklistMenuDemo>
    with RestorationMixin {
  final _RestorableCheckedValues _checkedValues = _RestorableCheckedValues()
    ..check(CheckedValue.three);

  @override
  String get restorationId => 'checklist_menu_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_checkedValues, 'checked_values');
  }

  void showCheckedMenuSelections(BuildContext context, CheckedValue value) {
    if (_checkedValues.isChecked(value)) {
      setState(() {
        _checkedValues.uncheck(value);
      });
    } else {
      setState(() {
        _checkedValues.check(value);
      });
    }
    widget.showInSnackBar(_checkedValues.checkedValuesToString(context).toString());
  }

  void setA(String value){

  }

  String checkedValueToString(BuildContext context, CheckedValue value) {
    return {
      CheckedValue.one: 'MenuOne',
      CheckedValue.two: 'MenuTwo',
      CheckedValue.three: 'MenuThree',
      CheckedValue.four: 'MenuFour',
    }[value]!;
  }

  @override
  void dispose() {
    _checkedValues.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'MenuAnItemWithAChecklistMenu',
      ),
      trailing: PopupMenuButton<CheckedValue>(
        padding: EdgeInsets.zero,
        onSelected: (value) => showCheckedMenuSelections(context, value),
        itemBuilder: (context) => <PopupMenuItem<CheckedValue>>[
          CheckedPopupMenuItem<CheckedValue>(
            value: CheckedValue.one,
            checked: _checkedValues.isChecked(CheckedValue.one),
            child: Text(
              checkedValueToString(context, CheckedValue.one),
            ),
          ),
          CheckedPopupMenuItem<CheckedValue>(
            value: CheckedValue.two,
            enabled: false,
            checked: _checkedValues.isChecked(CheckedValue.two),
            child: Text(
              checkedValueToString(context, CheckedValue.two),
            ),
          ),
          CheckedPopupMenuItem<CheckedValue>(
            value: CheckedValue.three,
            checked: _checkedValues.isChecked(CheckedValue.three),
            child: Text(
              checkedValueToString(context, CheckedValue.three),
            ),
          ),
          CheckedPopupMenuItem<CheckedValue>(
            value: CheckedValue.four,
            checked: _checkedValues.isChecked(CheckedValue.four),
            child: Text(
              checkedValueToString(context, CheckedValue.four),
            ),
          ),
        ],
      ),
    );
  }
}

