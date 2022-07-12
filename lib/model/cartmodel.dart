import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_practice/bean/cartbean.dart';

class CartModel extends ChangeNotifier {
  // 用于保存购物车中商品列表
  final List<CartBean> _items = [];

  // 禁止改变购物车里的商品信息
  UnmodifiableListView<CartBean> get items => UnmodifiableListView(_items);

  // 购物车中商品的总价
  double get totalPrice => _items.fold(0, (value, item) => value + item.count * item.price);

  // 将 [item] 添加到购物车。这是唯一一种能从外部改变购物车的方法。
  void add(CartBean item) {
    _items.add(item);
  // 通知监听器（订阅者），重新构建InheritedProvider， 更新状态。
    notifyListeners();
  }

  void minus() {
    _items.removeAt(_items.length - 1);
    notifyListeners();
  }

}