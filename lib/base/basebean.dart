
import 'package:json_annotation/json_annotation.dart';

part 'basebean.g.dart';

///genericArgumentFactories以支持泛型
@JsonSerializable(genericArgumentFactories: true)
class BaseBean<T> {
  T? data;
  int? status;
  String? message;

  BaseBean({this.data, this.status, this.message});

  ///注意这里的写法 方法fromJson中的参数T Function(dynamic json) fromJsonT 是一个数据类型为dynamic,参数名为json的函数
  factory BaseBean.fromJson(Map<String, dynamic> json, T Function(dynamic json) fromJsonT) => _$BaseBeanFromJson(json, fromJsonT);

  ///注意这里的写法
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) => _$BaseBeanToJson(this, toJsonT);

}