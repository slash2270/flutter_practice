import 'dart:core';

import 'package:flutter_practice/bean/cacheconfigbean.dart';
import 'package:flutter_practice/bean/userbean.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import '../utils/constants.dart';

part 'profilebean.g.dart';

ProfileBean ProfileBeanFromJson(String jsonStr) => ProfileBean.fromJson(json.decode(jsonStr));

String ProfileBeanToJson(CacheConfigBean data) => json.encode(data.toJson());

@RestApi(baseUrl: Constants.api)
abstract class ProfileClient {
factory ProfileClient(Dio dio, {String baseUrl}) = _ProfileClient;

@GET("/posts")
Future<List<ProfileBean>> getProfile();
}

@JsonSerializable(genericArgumentFactories: true)
class ProfileBean {
UserBean? user;
String? token;
int? theme;
CacheConfigBean? cache;
String? lastLogin;
String? locale;

ProfileBean({this.user, this.token, this.theme, this.cache, this.lastLogin, this.locale});

factory ProfileBean.fromJson(Map<String, dynamic> json) => _$ProfileBeanFromJson(json);
Map<String, dynamic> toJson() => _$ProfileBeanToJson(this);
}