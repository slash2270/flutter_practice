// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

enum DialogDemoType {
  alert,
  alertTitle,
  simple,
  fullscreen
}

// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

class DialogDemo extends StatefulWidget {
  const DialogDemo({Key? key}) : super(key: key);

  //final DialogDemoType type;

  @override
  State<DialogDemo> createState() => _DialogDemoState();
}

class _DialogDemoState extends State<DialogDemo> with RestorationMixin {
  late RestorableRouteFuture<String> _alertDialogRoute;
  late RestorableRouteFuture<String> _alertDialogWithTitleRoute;
  late RestorableRouteFuture<String> _simpleDialogRoute;

  @override
  String get restorationId => 'dialog_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(
      _alertDialogRoute,
      'alert_demo_dialog_route',
    );
    registerForRestoration(
      _alertDialogWithTitleRoute,
      'alert_demo_with_title_dialog_route',
    );
    registerForRestoration(
      _simpleDialogRoute,
      'simple_dialog_route',
    );
  }

  // Displays the popped String value in a SnackBar.
  void _showInSnackBar(String value) {
    // The value passed to Navigator.pop() or null.
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'SelectedOption',
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _alertDialogRoute = RestorableRouteFuture<String>(
      onPresent: (navigator, arguments) {
        return navigator.restorablePush(_alertDialogDemoRoute);
      },
      onComplete: _showInSnackBar,
    );
    _alertDialogWithTitleRoute = RestorableRouteFuture<String>(
      onPresent: (navigator, arguments) {
        return navigator.restorablePush(_alertDialogWithTitleDemoRoute);
      },
      onComplete: _showInSnackBar,
    );
    _simpleDialogRoute = RestorableRouteFuture<String>(
      onPresent: (navigator, arguments) {
        return navigator.restorablePush(_simpleDialogDemoRoute);
      },
      onComplete: _showInSnackBar,
    );
  }

  /*String _title(BuildContext context) {
    switch (widget.type) {
      case DialogDemoType.alert:
        return 'AlertDialogTitle';
      case DialogDemoType.alertTitle:
        return 'AlertTitleDialogTitle';
      case DialogDemoType.simple:
        return 'SimpleDialogTitle';
      case DialogDemoType.fullscreen:
        return 'FullscreenDialogTitle';
    }
  }*/

  static Route<String> _alertDialogDemoRoute(BuildContext context, Object? arguments,) {
    final theme = Theme.of(context);
    final dialogTextStyle = theme.textTheme.subtitle1!.copyWith(color: theme.textTheme.caption!.color);

    return DialogRoute<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
              content: Text(
                'DiscardTitle',
                style: dialogTextStyle,
              ),
              actions: [
                _DialogButton(text: 'Cancel'),
                _DialogButton(text: 'Discard'),
              ],
            );
      },
    );
  }

  static Route<String> _alertDialogWithTitleDemoRoute(BuildContext context, Object? arguments,) {
    final theme = Theme.of(context);
    final dialogTextStyle = theme.textTheme.subtitle1!.copyWith(color: theme.textTheme.caption!.color);

    return DialogRoute<String>(
      context: context,
      builder: (context) {
        return //ApplyTextOptions(
          //child:
          AlertDialog(
            title: Text('LocationTitle'),
            content: Text(
              'LocationDescription',
              style: dialogTextStyle,
            ),
            actions: [
              _DialogButton(text: 'Disagree'),
              _DialogButton(text: 'Agree'),
            ],
         // ),
        );
      },
    );
  }

  static Route<String> _simpleDialogDemoRoute(BuildContext context, Object? arguments,) {
    final theme = Theme.of(context);

    return DialogRoute<String>(
      context: context,
      builder: (context) => //ApplyTextOptions(
        //child:
        SimpleDialog(
          title: Text('SetBackup'),
          children: [
            _DialogDemoItem(
              icon: Icons.account_circle,
              color: theme.colorScheme.primary,
              text: 'username@gmail.com',
            ),
            _DialogDemoItem(
              icon: Icons.account_circle,
              color: theme.colorScheme.secondary,
              text: 'user02@gmail.com',
            ),
            _DialogDemoItem(
              icon: Icons.add_circle,
              text: 'AddAccount',
              color: theme.disabledColor,
            ),
          ],
        //),
      ),
    );
  }

  static Route<void> _fullscreenDialogRoute(BuildContext context, Object? arguments,) {
    return MaterialPageRoute<void>(
      builder: (context) => _FullScreenDialogDemo(),
      fullscreenDialog: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
        onPressed: () {
          _alertDialogRoute.present();
         },
         child: Text('Alert'),
        ),
        ElevatedButton(
          onPressed: () {
            _alertDialogWithTitleRoute.present();
          },
          child: Text('AlertTitle'),
        ),
        ElevatedButton(
          onPressed: () {
            _simpleDialogRoute.present();
          },
          child: Text('Simple'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.restorablePush<void>(context, _fullscreenDialogRoute);
          },
          child: Text('FullScreen'),
        ),
      ],
    );
    /*return Navigator(
      // Adding [ValueKey] to make sure that the widget gets rebuilt when
      // changing type.
      key: ValueKey(widget.type),
      restorationScopeId: 'navigator',
      onGenerateRoute: (settings) {
        return _NoAnimationMaterialPageRoute<void>(
          settings: settings,
          builder: (context) => Center(
              child: ElevatedButton(
                onPressed: () {
                  switch (widget.type) {
                    case DialogDemoType.alert:
                      _alertDialogRoute.present();
                      break;
                    case DialogDemoType.alertTitle:
                      _alertDialogWithTitleRoute.present();
                      break;
                    case DialogDemoType.simple:
                      _simpleDialogRoute.present();
                      break;
                    case DialogDemoType.fullscreen:
                      Navigator.restorablePush<void>(
                          context, _fullscreenDialogRoute);
                      break;
                  }
                },
                child: Text(_title(context)),
            ),
          ),
        );
      },
    );*/
  }
}

/// A MaterialPageRoute without any transition animations.
class _NoAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  _NoAnimationMaterialPageRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
    builder: builder,
    maintainState: maintainState,
    settings: settings,
    fullscreenDialog: fullscreenDialog,
  );

  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return child;
  }
}

class _DialogButton extends StatelessWidget {
  const _DialogButton({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop(text);
      },
      child: Text(text),
    );
  }
}

class _DialogDemoItem extends StatelessWidget {
  const _DialogDemoItem({
    Key? key,
    this.icon,
    this.color,
    required this.text,
  }) : super(key: key);

  final IconData? icon;
  final Color? color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: () {
        Navigator.of(context).pop(text);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 36, color: color),
          Flexible(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 16),
              child: Text(text),
            ),
          ),
        ],
      ),
    );
  }
}

class _FullScreenDialogDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Remove the MediaQuery padding because the demo is rendered inside of a
    // different page that already accounts for this padding.
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      //child: ApplyTextOptions(
        child: Scaffold(
          appBar: AppBar(
            title: Text('FullscreenTitle'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'FullscreenSave',
                  style: theme.textTheme.bodyText2!.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
          body: Center(
            child: Text(
              'FullscreenDescription',
            ),
          ),
        ),
      //),
    );
  }
}



// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

enum CustomTextDirection {
  localeBased,
  ltr,
  rtl,
}

// See http://en.wikipedia.org/wiki/Right-to-left
const List<String> rtlLanguages = <String>[
  'ar', // Arabic
  'fa', // Farsi
  'he', // Hebrew
  'ps', // Pashto
  'ur', // Urdu
];

// Fake locale to represent the system Locale option.
const systemLocaleOption = Locale('system');

Locale? _deviceLocale;

Locale? get deviceLocale => _deviceLocale;

set deviceLocale(Locale? locale) {
  _deviceLocale ??= locale;
}

class GalleryOptions {
  const GalleryOptions({
    required this.themeMode,
    required double? textScaleFactor,
    required this.customTextDirection,
    required Locale? locale,
    required this.timeDilation,
    required this.platform,
    required this.isTestMode,
  })  : _textScaleFactor = textScaleFactor ?? 1.0,
        _locale = locale;

  final ThemeMode themeMode;
  final double _textScaleFactor, systemTextScaleFactorOption = 1.0;
  final CustomTextDirection customTextDirection;
  final Locale? _locale;
  final double timeDilation;
  final TargetPlatform? platform;
  final bool isTestMode; // True for integration tests.

  // We use a sentinel value to indicate the system text scale option. By
  // default, return the actual text scale factor, otherwise return the
  // sentinel value.
  double textScaleFactor(BuildContext context, {bool useSentinel = false}) {
    if (_textScaleFactor == systemTextScaleFactorOption) {
      return useSentinel
          ? systemTextScaleFactorOption
          : MediaQuery.of(context).textScaleFactor;
    } else {
      return _textScaleFactor;
    }
  }

  Locale? get locale => _locale ?? deviceLocale;

  /// Returns a text direction based on the [CustomTextDirection] setting.
  /// If it is based on locale and the locale cannot be determined, returns
  /// null.
  TextDirection? resolvedTextDirection() {
    switch (customTextDirection) {
      case CustomTextDirection.localeBased:
        final language = locale?.languageCode.toLowerCase();
        if (language == null) return null;
        return rtlLanguages.contains(language)
            ? TextDirection.rtl
            : TextDirection.ltr;
      case CustomTextDirection.rtl:
        return TextDirection.rtl;
      default:
        return TextDirection.ltr;
    }
  }

  /// Returns a [SystemUiOverlayStyle] based on the [ThemeMode] setting.
  /// In other words, if the theme is dark, returns light; if the theme is
  /// light, returns dark.
  SystemUiOverlayStyle resolvedSystemUiOverlayStyle() {
    Brightness brightness;
    switch (themeMode) {
      case ThemeMode.light:
        brightness = Brightness.light;
        break;
      case ThemeMode.dark:
        brightness = Brightness.dark;
        break;
      default:
        brightness = WidgetsBinding.instance.window.platformBrightness;
    }

    final overlayStyle = brightness == Brightness.dark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark;

    return overlayStyle;
  }

  GalleryOptions copyWith({
    ThemeMode? themeMode,
    double? textScaleFactor,
    CustomTextDirection? customTextDirection,
    Locale? locale,
    double? timeDilation,
    TargetPlatform? platform,
    bool? isTestMode,
  }) {
    return GalleryOptions(
      themeMode: themeMode ?? this.themeMode,
      textScaleFactor: textScaleFactor ?? _textScaleFactor,
      customTextDirection: customTextDirection ?? this.customTextDirection,
      locale: locale ?? this.locale,
      timeDilation: timeDilation ?? this.timeDilation,
      platform: platform ?? this.platform,
      isTestMode: isTestMode ?? this.isTestMode,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is GalleryOptions &&
          themeMode == other.themeMode &&
          _textScaleFactor == other._textScaleFactor &&
          customTextDirection == other.customTextDirection &&
          locale == other.locale &&
          timeDilation == other.timeDilation &&
          platform == other.platform &&
          isTestMode == other.isTestMode;

  @override
  int get hashCode => Object.hash(
    themeMode,
    _textScaleFactor,
    customTextDirection,
    locale,
    timeDilation,
    platform,
    isTestMode,
  );

  static GalleryOptions of(BuildContext context) {
    final scope =
    context.dependOnInheritedWidgetOfExactType<_ModelBindingScope>()!;
    return scope.modelBindingState.currentModel;
  }

  static void update(BuildContext context, GalleryOptions newModel) {
    final scope =
    context.dependOnInheritedWidgetOfExactType<_ModelBindingScope>()!;
    scope.modelBindingState.updateModel(newModel);
  }
}

// Applies text GalleryOptions to a widget
class ApplyTextOptions extends StatelessWidget {
  const ApplyTextOptions({
    Key? key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final options = GalleryOptions.of(context);
    final textDirection = options.resolvedTextDirection();
    final textScaleFactor = options.textScaleFactor(context);

    Widget widget = MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: textScaleFactor,
      ),
      child: child,
    );
    return textDirection == null
        ? widget
        : Directionality(
      textDirection: textDirection,
      child: widget,
    );
  }
}

// Everything below is boilerplate except code relating to time dilation.
// See https://medium.com/flutter/managing-flutter-application-state-with-inheritedwidgets-1140452befe1

class _ModelBindingScope extends InheritedWidget {
  const _ModelBindingScope({
    Key? key,
    required this.modelBindingState,
    required this.child,
  }) : super(key: key, child: child);

  final _ModelBindingState modelBindingState;
  final Widget child;

  @override
  bool updateShouldNotify(_ModelBindingScope oldWidget) => true;
}

class ModelBinding extends StatefulWidget {
  const ModelBinding({
    Key? key,
    required this.initialModel,
    required this.child,
  });

  final GalleryOptions initialModel;
  final Widget child;

  @override
  State<ModelBinding> createState() => _ModelBindingState();
}

class _ModelBindingState extends State<ModelBinding> {
  late GalleryOptions currentModel;
  Timer? _timeDilationTimer;

  @override
  void initState() {
    super.initState();
    currentModel = widget.initialModel;
  }

  @override
  void dispose() {
    _timeDilationTimer?.cancel();
    _timeDilationTimer = null;
    super.dispose();
  }

  void handleTimeDilation(GalleryOptions newModel) {
    if (currentModel.timeDilation != newModel.timeDilation) {
      _timeDilationTimer?.cancel();
      _timeDilationTimer = null;
      if (newModel.timeDilation > 1) {
        // We delay the time dilation change long enough that the user can see
        // that UI has started reacting and then we slam on the brakes so that
        // they see that the time is in fact now dilated.
        _timeDilationTimer = Timer(const Duration(milliseconds: 150), () {
          timeDilation = newModel.timeDilation;
        });
      } else {
        timeDilation = newModel.timeDilation;
      }
    }
  }

  void updateModel(GalleryOptions newModel) {
    if (newModel != currentModel) {
      handleTimeDilation(newModel);
      setState(() {
        currentModel = newModel;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _ModelBindingScope(
      modelBindingState: this,
      child: widget.child,
    );
  }
}