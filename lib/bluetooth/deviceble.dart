import 'dart:convert';

import 'package:ble/Base.dart';

import 'package:json_annotation/json_annotation.dart';

part 'deviceble.g.dart';

/**
 * Create by laoge
 * on 2020/7/16 0016
 */

@JsonSerializable()

class DeviceBle extends Base<DeviceBle>{
  String name;
  int rssi;
  String address;

  DeviceBle({required this.name, required this.rssi, required this.address});

  factory DeviceBle.fromJson(Map<String, dynamic> json) => _$DeviceBleFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceBleToJson(this);

  @override
  String toString() {
    return '{"name": "$name", "rssi": $rssi, "address": "$address"}';
  }

  @override
  DeviceBle fromJson(String str) {
    return DeviceBle(name: name, rssi: rssi, address: address);
  }

}