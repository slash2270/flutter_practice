// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repobean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepoBean _$RepoBeanFromJson(Map<String, dynamic> json) => RepoBean(
      id: json['id'] as int?,
      name: json['name'] as String?,
      full_name: json['full_name'] as String?,
      owner: json['owner'] == null
          ? null
          : UserBean.fromJson(json['owner'] as Map<String, dynamic>),
      parent: json['parent'] == null
          ? null
          : RepoBean.fromJson(json['parent'] as Map<String, dynamic>),
      private: json['private'] as bool?,
      description: json['description'] as String?,
      fork: json['fork'] as bool?,
      language: json['language'] as String?,
      forks_count: json['forks_count'] as int?,
      stargazers_count: json['stargazers_count'] as int?,
      size: json['size'] as int?,
      default_branch: json['default_branch'] as String?,
      open_issues_count: json['open_issues_count'] as int?,
      pushed_at: json['pushed_at'] as String?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
      subscribers_count: json['subscribers_count'] as int?,
      license: json['license'] == null
          ? null
          : LicenseBean.fromJson(json['license'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RepoBeanToJson(RepoBean instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'full_name': instance.full_name,
      'owner': instance.owner,
      'parent': instance.parent,
      'private': instance.private,
      'description': instance.description,
      'fork': instance.fork,
      'language': instance.language,
      'forks_count': instance.forks_count,
      'stargazers_count': instance.stargazers_count,
      'size': instance.size,
      'default_branch': instance.default_branch,
      'open_issues_count': instance.open_issues_count,
      'pushed_at': instance.pushed_at,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'subscribers_count': instance.subscribers_count,
      'license': instance.license,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _RepoClient implements RepoClient {
  _RepoClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://jsonplaceholder.typicode.com';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<RepoBean>> getRepo() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<RepoBean>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/posts',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => RepoBean.fromJson(i as Map<String, dynamic>))
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
