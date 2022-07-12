// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userbean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBean _$UserBeanFromJson(Map<String, dynamic> json) => UserBean(
      login: json['login'] as String?,
      avatar_url: json['avatar_url'] as String?,
      type: json['type'] as String?,
      name: json['name'] as String?,
      company: json['company'] as String?,
      blog: json['blog'] as String?,
      location: json['location'] as String?,
      email: json['email'] as String?,
      hireable: json['hireable'] as bool?,
      bio: json['bio'] as String?,
      public_repos: json['public_repos'] as int?,
      followers: json['followers'] as int?,
      following: json['following'] as int?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
      total_private_repos: json['total_private_repos'] as int?,
      owned_private_repos: json['owned_private_repos'] as int?,
    );

Map<String, dynamic> _$UserBeanToJson(UserBean instance) => <String, dynamic>{
      'login': instance.login,
      'avatar_url': instance.avatar_url,
      'type': instance.type,
      'name': instance.name,
      'company': instance.company,
      'blog': instance.blog,
      'location': instance.location,
      'email': instance.email,
      'hireable': instance.hireable,
      'bio': instance.bio,
      'public_repos': instance.public_repos,
      'followers': instance.followers,
      'following': instance.following,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'total_private_repos': instance.total_private_repos,
      'owned_private_repos': instance.owned_private_repos,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _UserClient implements UserClient {
  _UserClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://jsonplaceholder.typicode.com';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<UserBean>> getUser() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<UserBean>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/posts',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => UserBean.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
