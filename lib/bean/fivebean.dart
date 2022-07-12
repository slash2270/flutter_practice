
import 'dart:core';
import '../utils/constants.dart';

class FiveBean{
  int id = 0;
  String name = '';
  String type = '';
  String size = '';
  String product = '';
  String price = '';
  String count = '';

  FiveBean(this.id, this.name, this.type, this.size, this.product, this.price, this.count);

  Map<String, Object> toMap() {
    var map = <String, Object>{
      Constants.columnName: name,
      Constants.columnType: type,
      Constants.columnSize: size,
      Constants.columnProduct: product,
      Constants.columnPrice: price,
      Constants.columnCount: count,
    };
    if (id > 0) {
      map[Constants.columnId] = id;
    }
    return map;
  }

  FiveBean.fromMap(Map<dynamic, dynamic> map) {
    id = map[Constants.columnId];
    name = map[Constants.columnName];
    type = map[Constants.columnType];
    size = map[Constants.columnSize];
    product = map[Constants.columnProduct];
    price = map[Constants.columnPrice];
    count = map[Constants.columnCount];
  }

}