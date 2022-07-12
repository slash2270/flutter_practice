import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import '../utils/constants.dart';

part 'eightbean.g.dart';

EightBean EightBeanFromJson(String jsonStr) => EightBean.fromJson(json.decode(jsonStr));

String EightBeanToJson(EightBean data) => json.encode(data.toJson());

@RestApi(baseUrl: Constants.api)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/posts")
  Future<List<EightBean>> getEightBean();
}

@JsonSerializable(genericArgumentFactories: true)
class EightBean {
  int? id ;
  String? title;
  String? body;

  EightBean({this.id, this.title, this.body});

  factory EightBean.fromJson(Map<String, dynamic> json) => _$EightBeanFromJson(json);
  Map<String, dynamic> toJson() => _$EightBeanToJson(this);
}