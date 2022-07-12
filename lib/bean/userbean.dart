import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import '../utils/constants.dart';

part 'userbean.g.dart';

UserBean UserBeanFromJson(String jsonStr) => UserBean.fromJson(json.decode(jsonStr));

String UserBeanToJson(UserBean data) => json.encode(data.toJson());

@RestApi(baseUrl: Constants.api)
abstract class UserClient {
  factory UserClient(Dio dio, {String baseUrl}) = _UserClient;

  @GET("/posts")
  Future<List<UserBean>> getUser();
}

@JsonSerializable(genericArgumentFactories: true)
class UserBean {

  String? login = "octocat";
  String? avatar_url = "https://github.com/images/error/octocat_happy.gif";
  String? type = "User";
  String? name = "monalisa octocat";
  String? company = "GitHub";
  String? blog = "https://github.com/blog";
  String? location = "San Francisco";
  String? email = "octocat@github.com";
  bool? hireable = false;
  String? bio = "There once was...";
  int? public_repos = 2;
  int? followers = 20;
  int? following = 0;
  String? created_at = "2008-01-14T04:33:35Z";
  String? updated_at = "2008-01-14T04:33:35Z";
  int? total_private_repos = 100;
  int? owned_private_repos = 100;

  UserBean({
    this.login, this.avatar_url, this.type, this.name, this.company, this.blog, this.location, this.email, this.hireable, this.bio, this.public_repos, this.followers,
    this.following, this.created_at, this.updated_at, this.total_private_repos, this.owned_private_repos
  });

  factory UserBean.fromJson(Map<String, dynamic> json) => _$UserBeanFromJson(json);
  Map<String, dynamic> toJson() => _$UserBeanToJson(this);

}