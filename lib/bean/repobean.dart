import 'dart:core';

import 'package:flutter_practice/bean/licensebean.dart';
import 'package:flutter_practice/bean/userbean.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import '../utils/constants.dart';

part 'repobean.g.dart';

RepoBean RepoBeanFromJson(String jsonStr) => RepoBean.fromJson(json.decode(jsonStr));

String RepoBeanToJson(RepoBean data) => json.encode(data.toJson());

@RestApi(baseUrl: Constants.api)
abstract class RepoClient {
factory RepoClient(Dio dio, {String baseUrl}) = _RepoClient;

@GET("/posts")
Future<List<RepoBean>> getRepo();
}

@JsonSerializable(genericArgumentFactories: true)
class RepoBean {

int? id = 129629;
String? name = "Hello-World";
String? full_name = "octocat/Hello-World";
UserBean? owner;
RepoBean? parent;
bool? private = false;
String? description = "This your first repo!";
bool? fork = false;
String? language = "JavaScript";
int? forks_count = 9;
int? stargazers_count = 80;
int? size = 108;
String? default_branch = "master";
int? open_issues_count = 2;
String? pushed_at = "2011-01-26T19:06:43Z";
String? created_at = "2011-01-26T19:01:12Z";
String? updated_at = "2011-01-26T19:14:43Z";
int? subscribers_count = 42;
LicenseBean? license;

RepoBean({this.id, this.name, this.full_name, this.owner, this.parent,
    this.private, this.description, this.fork, this.language, this.forks_count,
    this.stargazers_count, this.size, this.default_branch,
    this.open_issues_count, this.pushed_at, this.created_at, this.updated_at,
    this.subscribers_count, this.license});

factory RepoBean.fromJson(Map<String, dynamic> json) => _$RepoBeanFromJson(json);
Map<String, dynamic> toJson() => _$RepoBeanToJson(this);

}