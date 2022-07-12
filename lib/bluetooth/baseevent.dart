import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'baseevent.g.dart';

/**
 * Create by laoge
 * on 2020/7/16 0016
 */

@JsonSerializable()

class BaseEvent {
  int code;
  dynamic data;

  BaseEvent(this.code, this.data);

  //不同的类使用不同的mixin即可
  factory BaseEvent.fromJson(Map<String, dynamic> json) => _$BaseEventFromJson(json);
  Map<String, dynamic> toJson() => _$BaseEventToJson(this);

}