// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/gallery/cupertino/cupertinoalertdemo.dart';
import 'package:flutter_practice/gallery/cupertino/cupertinobuttondemo.dart';
import 'package:flutter_practice/gallery/cupertino/cupertinocontextmenudemo.dart';
import 'package:flutter_practice/gallery/cupertino/cupertinopickerdemo.dart';
import 'package:flutter_practice/gallery/cupertino/cupertinoprogressindicatordemo.dart';
import 'package:flutter_practice/gallery/cupertino/cupertinosliderdemo.dart';
import 'package:flutter_practice/gallery/cupertino/cupertinoswitchdemo.dart';
import 'package:flutter_practice/gallery/cupertino/cupertinotextfielddemo.dart';
import 'package:flutter_practice/gallery/material/actionchipdemo.dart';
import 'package:flutter_practice/gallery/material/checkboxdemo.dart';
import 'package:flutter_practice/gallery/material/checklistmenudemo.dart';
import 'package:flutter_practice/gallery/material/choicechipdemo.dart';
import 'package:flutter_practice/gallery/material/dialogdemo.dart';
import 'package:flutter_practice/gallery/material/filterchipdemo.dart';
import 'package:flutter_practice/gallery/material/horizontaldividerdemo.dart';
import 'package:flutter_practice/gallery/material/inputchipdemo.dart';
import 'package:flutter_practice/gallery/material/pickerdemo.dart';
import 'package:flutter_practice/gallery/material/progressindicatordemo.dart';
import 'package:flutter_practice/gallery/material/radiodemo.dart';
import 'package:flutter_practice/gallery/material/rangeslidersdemo.dart';
import 'package:flutter_practice/gallery/material/selectionmenudemo.dart';
import 'package:flutter_practice/gallery/material/simplemenudemo.dart';
import 'package:flutter_practice/gallery/material/slidersdemo.dart';
import 'package:flutter_practice/gallery/material/snackbardemo.dart';
import 'package:flutter_practice/gallery/material/switchdemo.dart';
import 'package:flutter_practice/gallery/material/tabnonscrollabledemo.dart';
import 'package:flutter_practice/gallery/material/textfielddemo.dart';
import 'package:flutter_practice/gallery/material/tooltipdemo.dart';
import 'package:flutter_practice/gallery/material/verticaldividerdemo.dart';
import 'package:flutter_practice/set.dart';

import 'contextmenudemo.dart';

Set set = Set();

enum CardType {
  standard,
  tappable,
  selectable,
}

class TravelDestination {
  const TravelDestination({
    required this.assetName,
    required this.assetPackage,
    required this.title,
    required this.description,
    required this.city,
    required this.location,
    this.cardType = CardType.standard,
  });

  final String assetName;
  final String assetPackage;
  final String title;
  final String description;
  final String city;
  final String location;
  final CardType cardType;
}

List<TravelDestination> destinations(BuildContext context) {
  return [
    TravelDestination(
      assetName: 'images/ellen.jpeg',
      assetPackage: 'package1',
      title: 'title1',
      description: 'description1',
      city: 'city1',
      location: 'location1',
    ),
    TravelDestination(
      assetName: 'images/ellen.jpeg',
      assetPackage: 'package2',
      title: 'title2',
      description: 'description2',
      city: 'city2',
      location: 'location2',
      cardType: CardType.tappable,
    ),
    TravelDestination(
      assetName: 'images/ellen.jpeg',
      assetPackage: 'package3',
      title: 'title3',
      description: 'description3',
      city: 'city3',
      location: 'location3',
      cardType: CardType.selectable,
    ),
  ];
}

class TravelDestinationItem extends StatelessWidget {
  const TravelDestinationItem({Key? key, required this.destination, this.shape})
      : super(key: key);

  // This height will allow for all the Card's content to fit comfortably within the card.
  static const height = 360.0;
  final TravelDestination destination;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SectionTitle(
                title: '一般'),
            SizedBox(
              height: height,
              child: Card(
                // This ensures that the Card's children are clipped correctly.
                clipBehavior: Clip.antiAlias,
                shape: shape,
                child: TravelDestinationContent(destination: destination),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TappableTravelDestinationItem extends StatelessWidget {
  const TappableTravelDestinationItem({
    Key? key,
    required this.destination,
    this.shape,
  }) : super(key: key);

  // This height will allow for all the Card's content to fit comfortably within the card.
  static const height = 298.0;
  final TravelDestination destination;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SectionTitle(
                title: '可輕觸'),
            SizedBox(
              height: height,
              child: Card(
                // This ensures that the Card's children (including the ink splash) are clipped correctly.
                clipBehavior: Clip.antiAlias,
                shape: shape,
                child: InkWell(
                  onTap: () {},
                  // Generally, material cards use onSurface with 12% opacity for the pressed state.
                  splashColor:
                  Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
                  // Generally, material cards do not have a highlight overlay.
                  highlightColor: Colors.transparent,
                  child: TravelDestinationContent(destination: destination),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectableTravelDestinationItem extends StatelessWidget {
  const SelectableTravelDestinationItem({
    Key? key,
    required this.destination,
    required this.isSelected,
    required this.onSelected,
    this.shape,
  }) : super(key: key);

  final TravelDestination destination;
  final ShapeBorder? shape;
  final bool isSelected;
  final VoidCallback onSelected;

  // This height will allow for all the Card's content to fit comfortably within the card.
  static const height = 298.0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SectionTitle(
                title: '可選取/長按'),
            SizedBox(
              height: height,
              child: Card(
                // This ensures that the Card's children (including the ink splash) are clipped correctly.
                clipBehavior: Clip.antiAlias,
                shape: shape,
                child: InkWell(
                  onLongPress: () {
                    onSelected();
                  },
                  // Generally, material cards use onSurface with 12% opacity for the pressed state.
                  splashColor: colorScheme.onSurface.withOpacity(0.12),
                  // Generally, material cards do not have a highlight overlay.
                  highlightColor: Colors.transparent,
                  child: Stack(
                    children: [
                      Container(
                        color: isSelected
                        // Generally, material cards use primary with 8% opacity for the selected state.
                        // See: https://material.io/design/interaction/states.html#anatomy
                            ? colorScheme.primary.withOpacity(0.08)
                            : Colors.transparent,
                      ),
                      TravelDestinationContent(destination: destination),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.check_circle,
                            color: isSelected
                                ? colorScheme.primary
                                : Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title, style: Theme.of(context).textTheme.subtitle1),
      ),
    );
  }
}

class TravelDestinationContent extends StatelessWidget {
  const TravelDestinationContent({Key? key, required this.destination})
      : super(key: key);

  final TravelDestination destination;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.headline5!.copyWith(color: Colors.white);
    final descriptionStyle = theme.textTheme.subtitle1!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 184,
          child: Stack(
            children: [
              Positioned.fill(
                // In order to have the ink splash appear above the image, you
                // must use Ink.image. This allows the image to be painted as
                // part of the Material and display ink effects above it. Using
                // a standard Image will obscure the ink splash.
                child: Ink.image(
                  image: AssetImage(
                    destination.assetName,
                    package: destination.assetPackage,
                  ),
                  fit: BoxFit.cover,
                  child: Container(),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    destination.title,
                    style: titleStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Description and share/explore buttons.
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: DefaultTextStyle(
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            style: descriptionStyle,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // This array contains the three line description on each card
                // demo.
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    destination.description,
                    style: descriptionStyle.copyWith(color: Colors.black54),
                  ),
                ),
                Text(destination.city),
                Text(destination.location),
              ],
            ),
          ),
        ),
        if (destination.cardType == CardType.standard)
        // share, explore buttons
          Padding(
            padding: const EdgeInsets.all(8),
            child: OverflowBar(
              alignment: MainAxisAlignment.start,
              spacing: 8,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text('分享'),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('探索'),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class CardsDemo extends StatefulWidget {
  const CardsDemo({Key? key}) : super(key: key);

  @override
  State<CardsDemo> createState() => _CardsDemoState();
}

class _CardsDemoState extends State<CardsDemo> with RestorationMixin {
  final RestorableBool _isSelected = RestorableBool(false);

  @override
  String get restorationId => 'cards_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_isSelected, 'is_selected');
  }

  @override
  void dispose() {
    _isSelected.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('FiftyThree Page'),
      ),
      body: Scrollbar(
        child: ListView(
          restorationId: 'cards_demo_list_view',
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
          children: [
            for (final destination in destinations(context))
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: (destination.cardType == CardType.standard)
                    ? TravelDestinationItem(destination: destination)
                    : destination.cardType == CardType.tappable
                    ? TappableTravelDestinationItem(
                    destination: destination)
                    : SelectableTravelDestinationItem(
                  destination: destination,
                  isSelected: _isSelected.value,
                  onSelected: () {
                    setState(() {
                      _isSelected.value = !_isSelected.value;
                    });
                  },
                ),
              ),
            ActionChipDemo(),
            ChoiceChipDemo(),
            FilterChipDemo(),
            InputChipDemo(),
            HorizontalDividerDemo(),
            VerticalDividerDemo(),
            SizedBox(
              height: 20.0,
            ),
            ContextMenuDemo(showInSnackBar: (String value) {
              set.snackBar(context, '已選取 $value', '取消');
            },),
            SectionedMenuDemo(showInSnackBar: (String value) {
              set.snackBar(context, '已選取 $value', '取消');
            },),
            ChecklistMenuDemo(showInSnackBar: (String value) {
              set.snackBar(context, '已選取 $value', '取消');
            },),
            SimpleMenuDemo(showInSnackBar: (String value) {
              set.snackBar(context, '已選取 $value', '取消');
            },),
            DialogDemo(),
            SizedBox(
              height: 20.0,
            ),
            PickerDemo(),
            SizedBox(
              height: 20.0,
            ),
            ProgressIndicatorDemo(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CheckboxDemo(),
                RadioDemo(),
              ],
            ),
            SwitchDemo(),
            SlidersDemo(),
            RangeSlidersDemo(),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SnackBarsDemo(),
                TooltipDemo(),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            CupertinoProgressIndicatorDemo(),
            SizedBox(
              height: 20.0,
            ),
            CupertinoAlertDemo(),
            SizedBox(
              height: 20.0,
            ),
            CupertinoButtonDemo(),
            SizedBox(
              height: 20.0,
            ),
            CupertinoContextMenuDemo(),
            SizedBox(
              height: 20.0,
            ),
            CupertinoPickerDemo(),
            SizedBox(
              height: 15.0,
            ),
            CupertinoSliderDemo(),
            SizedBox(
              height: 15.0,
            ),
            CupertinoSwitchDemo(),
            CupertinoTextFieldDemo(),




          ],
        ),
      ),
    );
  }
}

