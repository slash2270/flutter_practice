// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profilebean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileBean _$ProfileBeanFromJson(Map<String, dynamic> json) => ProfileBean(
      user: json['user'] == null
          ? null
          : UserBean.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String?,
      theme: json['theme'] as int?,
      cache: json['cache'] == null
          ? null
          : CacheConfigBean.fromJson(json['cache'] as Map<String, dynamic>),
      lastLogin: json['lastLogin'] as String?,
      locale: json['locale'] as String?,
    );

Map<String, dynamic> _$ProfileBeanToJson(ProfileBean instance) =>
    <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
      'theme': instance.theme,
      'cache': instance.cache,
      'lastLogin': instance.lastLogin,
      'locale': instance.locale,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _ProfileClient implements ProfileClient {
  _ProfileClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://jsonplaceholder.typicode.com';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<ProfileBean>> getProfile() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<ProfileBean>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/posts',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => ProfileBean.fromJson(i as Map<String, dynamic>))
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
