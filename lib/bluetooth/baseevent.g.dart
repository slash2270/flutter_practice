// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'baseevent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseEvent _$BaseEventFromJson(Map<String, dynamic> json) => BaseEvent(
      json['code'] as int,
      json['data'],
    );

Map<String, dynamic> _$BaseEventToJson(BaseEvent instance) => <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
    };
