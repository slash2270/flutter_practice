// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deviceble.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceBle _$DeviceBleFromJson(Map<String, dynamic> json) => DeviceBle(
      name: json['name'] as String,
      rssi: json['rssi'] as int,
      address: json['address'] as String,
    );

Map<String, dynamic> _$DeviceBleToJson(DeviceBle instance) => <String, dynamic>{
      'name': instance.name,
      'rssi': instance.rssi,
      'address': instance.address,
    };
