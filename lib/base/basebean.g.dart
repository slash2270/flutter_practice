// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basebean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseBean<T> _$BaseBeanFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BaseBean<T>(
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      status: json['status'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$BaseBeanToJson<T>(
  BaseBean<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'status': instance.status,
      'message': instance.message,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
