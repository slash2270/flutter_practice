// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_TW locale. All the
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
  String get localeName => 'zh_TW';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "First": MessageLookupByLibrary.simpleMessage("第一頁"),
        "all_service_and_characteristics":
            MessageLookupByLibrary.simpleMessage("所有的服務及其子特徵值"),
        "ble_connecting": MessageLookupByLibrary.simpleMessage("正在連接藍牙..."),
        "ble_disconnet_connecting":
            MessageLookupByLibrary.simpleMessage("藍牙連接斷開，正在重新連接藍牙..."),
        "connect_time_out_check_whether_ble_is_turned_on":
            MessageLookupByLibrary.simpleMessage("藍牙連接超時，請檢查藍牙是否打開"),
        "language":
            MessageLookupByLibrary.simpleMessage("Currently Using Chinese"),
        "please_input_order": MessageLookupByLibrary.simpleMessage("請輸入命令"),
        "send": MessageLookupByLibrary.simpleMessage("發送"),
        "set_notify_characteristics":
            MessageLookupByLibrary.simpleMessage("設置通知特徵值（多選）"),
        "set_write_characteristics":
            MessageLookupByLibrary.simpleMessage("設置寫特徵值(單選)"),
        "start_searching_for_attached_bluetooth_devices":
            MessageLookupByLibrary.simpleMessage("開始搜索附近的藍牙設備"),
        "stop_searching_for_attached_bluetooth_devices":
            MessageLookupByLibrary.simpleMessage("開始搜索附近的藍牙設備"),
        "title": MessageLookupByLibrary.simpleMessage("Flutter 應用")
      };
}
