import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import '../utils/constants.dart';

part 'cacheconfigbean.g.dart';

CacheConfigBean CacheConfigBeanFromJson(String jsonStr) => CacheConfigBean.fromJson(json.decode(jsonStr));

String CacheConfigBeanToJson(CacheConfigBean data) => json.encode(data.toJson());

@RestApi(baseUrl: Constants.api)
abstract class CacheConfigClient {
factory CacheConfigClient(Dio dio, {String baseUrl}) = _CacheConfigClient;

@GET("/posts")
Future<List<CacheConfigBean>> getCacheConfig();
}

@JsonSerializable(genericArgumentFactories: true)
class CacheConfigBean {
bool? enable;
int? maxAge;
int? maxCount;

CacheConfigBean({this.enable, this.maxAge, this.maxCount});

factory CacheConfigBean.fromJson(Map<String, dynamic> json) => _$CacheConfigBeanFromJson(json);
Map<String, dynamic> toJson() => _$CacheConfigBeanToJson(this);
}