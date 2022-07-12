// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';

enum AlertDemoType{
  alert,
  alertTitle,
  alertButtons,
  alertButtonsOnly,
  actionSheet
}

class CupertinoAlertDemo extends StatefulWidget {
  const CupertinoAlertDemo({Key? key,}) : super(key: key);

  @override
  State<CupertinoAlertDemo> createState() => _CupertinoAlertDemoState();
}

class _CupertinoAlertDemoState extends State<CupertinoAlertDemo> with RestorationMixin {
  RestorableStringN lastSelectedValue = RestorableStringN(null);
  late RestorableRouteFuture<String> _alertDialogRoute;
  late RestorableRouteFuture<String> _alertWithTitleDialogRoute;
  late RestorableRouteFuture<String> _alertWithButtonsDialogRoute;
  late RestorableRouteFuture<String> _alertWithButtonsOnlyDialogRoute;
  late RestorableRouteFuture<String> _modalPopupRoute;

  @override
  String get restorationId => 'cupertino_alert_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(
      lastSelectedValue,
      'last_selected_value',
    );
    registerForRestoration(
      _alertDialogRoute,
      'alert_demo_dialog_route',
    );
    registerForRestoration(
      _alertWithTitleDialogRoute,
      'alert_with_title_press_demo_dialog_route',
    );
    registerForRestoration(
      _alertWithButtonsDialogRoute,
      'alert_with_title_press_demo_dialog_route',
    );
    registerForRestoration(
      _alertWithButtonsOnlyDialogRoute,
      'alert_with_title_press_demo_dialog_route',
    );
    registerForRestoration(
      _modalPopupRoute,
      'modal_popup_route',
    );
  }

  void _setSelectedValue(String value) {
    setState(() {
      lastSelectedValue.value = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _alertDialogRoute = RestorableRouteFuture<String>(
      onPresent: (navigator, arguments) {
        return navigator.restorablePush(_alertDemoDialog);
      },
      onComplete: _setSelectedValue,
    );
    _alertWithTitleDialogRoute = RestorableRouteFuture<String>(
      onPresent: (navigator, arguments) {
        return navigator.restorablePush(_alertWithTitleDialog);
      },
      onComplete: _setSelectedValue,
    );
    _alertWithButtonsDialogRoute = RestorableRouteFuture<String>(
      onPresent: (navigator, arguments) {
        return navigator.restorablePush(_alertWithButtonsDialog);
      },
      onComplete: _setSelectedValue,
    );
    _alertWithButtonsOnlyDialogRoute = RestorableRouteFuture<String>(
      onPresent: (navigator, arguments) {
        return navigator.restorablePush(_alertWithButtonsOnlyDialog);
      },
      onComplete: _setSelectedValue,
    );
    _modalPopupRoute = RestorableRouteFuture<String>(
      onPresent: (navigator, arguments) {
        return navigator.restorablePush(_modalRoute);
      },
      onComplete: _setSelectedValue,
    );
  }

  /*String _title(BuildContext context) {
    switch (widget.type) {
      case AlertDemoType.alert:
        return localizations.demoCupertinoAlertTitle;
      case AlertDemoType.alertTitle:
        return localizations.demoCupertinoAlertWithTitleTitle;
      case AlertDemoType.alertButtons:
        return localizations.demoCupertinoAlertButtonsTitle;
      case AlertDemoType.alertButtonsOnly:
        return localizations.demoCupertinoAlertButtonsOnlyTitle;
      case AlertDemoType.actionSheet:
        return localizations.demoCupertinoActionSheetTitle;
    }
  }*/

  static Route<String> _alertDemoDialog(BuildContext context, Object? arguments,) {
    return CupertinoDialogRoute<String>(
      context: context,
      builder: (context) => //ApplyTextOptions(child:
      CupertinoAlertDialog(
          title: Text('dialogDiscardTitle'),
          actions: [
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.of(
                  context,
                ).pop('cupertinoAlertDiscard');
              },
              child: Text(
                'cupertinoAlertDiscard',
              ),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => Navigator.of(
                context,
              ).pop(
                'cupertinoAlertCancel',
              ),
              child: Text(
                'cupertinoAlertCancel',
              ),
            ),
          ],
        ),
    );
  }

  static Route<String> _alertWithTitleDialog(BuildContext context, Object? arguments,) {
    //final localizations = GalleryLocalizations.of(context)!;
    return CupertinoDialogRoute<String>(
      context: context,
      builder: (context) => //ApplyTextOptions(child:
      CupertinoAlertDialog(
          title: Text(
            'cupertinoAlertLocationTitle',
          ),
          content: Text(
            'cupertinoAlertLocationDescription',
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.of(
                context,
              ).pop(
                'cupertinoAlertDontAllow',
              ),
              child: Text(
                'cupertinoAlertDontAllow',
              ),
            ),
            CupertinoDialogAction(
              onPressed: () => Navigator.of(
                context,
              ).pop(
                'cupertinoAlertAllow',
              ),
              child: Text(
                'cupertinoAlertAllow',
              ),
            ),
          ],
        ),
    );
  }

  static Route<String> _alertWithButtonsDialog(
      BuildContext context,
      Object? arguments,
      ) {
    return CupertinoDialogRoute<String>(
      context: context,
      builder: (context) => //ApplyTextOptions(child:
      CupertinoDessertDialog(
          title: Text(
            'cupertinoAlertFavoriteDessert',
          ),
          content: Text(
            'cupertinoAlertDessertDescription',
          ),
        ),
    );
  }

  static Route<String> _alertWithButtonsOnlyDialog(BuildContext context, Object? arguments,) {
    return CupertinoDialogRoute<String>(
      context: context,
      builder: (context) => CupertinoDessertDialog(),/*const ApplyTextOptions(
        child: CupertinoDessertDialog(),
      ),*/
    );
  }

  static Route<String> _modalRoute(BuildContext context, Object? arguments,) {
    return CupertinoModalPopupRoute<String>(
      builder: (context) => //ApplyTextOptions(child:
      CupertinoActionSheet(
          title: Text(
            'cupertinoAlertFavoriteDessert',
          ),
          message: Text(
            'cupertinoAlertDessertDescription',
          ),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(
                context,
              ).pop(
                'cupertinoAlertCheesecake',
              ),
              child: Text(
                'cupertinoAlertCheesecake',
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(
                context,
              ).pop(
                'cupertinoAlertTiramisu',
              ),
              child: Text(
                'cupertinoAlertTiramisu',
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(
                context,
              ).pop(
                'cupertinoAlertApplePie',
              ),
              child: Text(
                'cupertinoAlertApplePie',
              ),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () => Navigator.of(
              context,
            ).pop(
              'cupertinoAlertCancel',
            ),
            child: Text(
              'cupertinoAlertCancel',
            ),
          ),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoButton.filled(
          onPressed: () {
            _alertDialogRoute.present();
          },
          child: Text('alert',),
        ),
        SizedBox(
          height: 10.0,
        ),
        CupertinoButton.filled(
          onPressed: () {
            _alertWithTitleDialogRoute.present();
          },
          child: Text('alertTitle',),
        ),
        SizedBox(
          height: 10.0,
        ),
        CupertinoButton.filled(
          onPressed: () {
            _alertWithButtonsDialogRoute.present();
          },
          child: Text('alertButtons',),
        ),
        SizedBox(
          height: 10.0,
        ),
        CupertinoButton.filled(
          onPressed: () {
            _alertWithButtonsOnlyDialogRoute.present();
          },
          child: Text('alertButtonsOnly',),
        ),
        SizedBox(
          height: 10.0,
        ),
        CupertinoButton.filled(
          onPressed: () {
            _modalPopupRoute.present();
          },
          child: Text('ActionSheet',),
        ),
        if (lastSelectedValue.value != null)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              lastSelectedValue.value!,
              style: CupertinoTheme.of(context).textTheme.textStyle,
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}

class CupertinoDessertDialog extends StatelessWidget {
  const CupertinoDessertDialog({
    Key? key,
    this.title,
    this.content,
  }) : super(key: key);

  final Widget? title;
  final Widget? content;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: title,
      content: content,
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(
              context,
            ).pop(
              'cupertinoAlertCheesecake',
            );
          },
          child: Text(
            'cupertinoAlertCheesecake',
          ),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(
              context,
            ).pop(
              'cupertinoAlertTiramisu',
            );
          },
          child: Text(
            'cupertinoAlertTiramisu',
          ),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(
              context,
            ).pop(
              'cupertinoAlertApplePie',
            );
          },
          child: Text(
            'cupertinoAlertApplePie',
          ),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(
              context,
            ).pop(
              'cupertinoAlertChocolateBrownie',
            );
          },
          child: Text(
            'cupertinoAlertChocolateBrownie',
          ),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.of(
              context,
            ).pop(
              'cupertinoAlertCancel',
            );
          },
          child: Text(
            'cupertinoAlertCancel',
          ),
        ),
      ],
    );
  }
}