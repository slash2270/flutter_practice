import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'licensebean.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class LicenseBean{

  String? key = "mit";
  String? name = "MIT License";
  String? spdx_id = "MIT";
  String? url = "https://api.github.com/licenses/mit";
  String? node_id = "MDc6TGljZW5zZW1pdA==";

  LicenseBean({this.key, this.name, this.spdx_id, this.url, this.node_id});

  factory LicenseBean.fromJson(Map<String, dynamic> json) => _$LicenseBeanFromJson(json);
  Map<String, dynamic> toJson() => _$LicenseBeanToJson(this);
}