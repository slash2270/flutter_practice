// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "First": MessageLookupByLibrary.simpleMessage("First"),
        "all_service_and_characteristics": MessageLookupByLibrary.simpleMessage(
            "All Service And Characteristics"),
        "ble_connecting":
            MessageLookupByLibrary.simpleMessage("BLE connecting..."),
        "ble_disconnet_connecting":
            MessageLookupByLibrary.simpleMessage("BLE disconnet connecting..."),
        "connect_time_out_check_whether_ble_is_turned_on":
            MessageLookupByLibrary.simpleMessage(
                "Connect time out,check whether ble is turned on"),
        "language": MessageLookupByLibrary.simpleMessage("當前使用的是中文"),
        "please_input_order":
            MessageLookupByLibrary.simpleMessage("Please input order"),
        "send": MessageLookupByLibrary.simpleMessage("Send"),
        "set_notify_characteristics": MessageLookupByLibrary.simpleMessage(
            "Set Notify Characteristics (Multiple choice)"),
        "set_write_characteristics": MessageLookupByLibrary.simpleMessage(
            "Set Write Characteristics (Single choice)"),
        "start_searching_for_attached_bluetooth_devices":
            MessageLookupByLibrary.simpleMessage(
                "start searching for attached bluetooth devices"),
        "stop_searching_for_attached_bluetooth_devices":
            MessageLookupByLibrary.simpleMessage(
                "stop searching for attached bluetooth devices"),
        "title": MessageLookupByLibrary.simpleMessage("Flutter App")
      };
}
