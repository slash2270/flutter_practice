// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Flutter App`
  String get title {
    return Intl.message(
      'Flutter App',
      name: 'title',
      desc: 'Title for the Demo application',
      args: [],
    );
  }

  /// `First`
  String get First {
    return Intl.message(
      'First',
      name: 'First',
      desc: '',
      args: [],
    );
  }

  /// `當前使用的是中文`
  String get language {
    return Intl.message(
      '當前使用的是中文',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `start searching for attached bluetooth devices`
  String get start_searching_for_attached_bluetooth_devices {
    return Intl.message(
      'start searching for attached bluetooth devices',
      name: 'start_searching_for_attached_bluetooth_devices',
      desc: '',
      args: [],
    );
  }

  /// `stop searching for attached bluetooth devices`
  String get stop_searching_for_attached_bluetooth_devices {
    return Intl.message(
      'stop searching for attached bluetooth devices',
      name: 'stop_searching_for_attached_bluetooth_devices',
      desc: '',
      args: [],
    );
  }

  /// `BLE connecting...`
  String get ble_connecting {
    return Intl.message(
      'BLE connecting...',
      name: 'ble_connecting',
      desc: '',
      args: [],
    );
  }

  /// `BLE disconnet connecting...`
  String get ble_disconnet_connecting {
    return Intl.message(
      'BLE disconnet connecting...',
      name: 'ble_disconnet_connecting',
      desc: '',
      args: [],
    );
  }

  /// `Connect time out,check whether ble is turned on`
  String get connect_time_out_check_whether_ble_is_turned_on {
    return Intl.message(
      'Connect time out,check whether ble is turned on',
      name: 'connect_time_out_check_whether_ble_is_turned_on',
      desc: '',
      args: [],
    );
  }

  /// `Please input order`
  String get please_input_order {
    return Intl.message(
      'Please input order',
      name: 'please_input_order',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Set Write Characteristics (Single choice)`
  String get set_write_characteristics {
    return Intl.message(
      'Set Write Characteristics (Single choice)',
      name: 'set_write_characteristics',
      desc: '',
      args: [],
    );
  }

  /// `Set Notify Characteristics (Multiple choice)`
  String get set_notify_characteristics {
    return Intl.message(
      'Set Notify Characteristics (Multiple choice)',
      name: 'set_notify_characteristics',
      desc: '',
      args: [],
    );
  }

  /// `All Service And Characteristics`
  String get all_service_and_characteristics {
    return Intl.message(
      'All Service And Characteristics',
      name: 'all_service_and_characteristics',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'TW'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
