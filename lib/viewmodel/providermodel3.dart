// @dart = 2.9

import 'package:flutter/material.dart';
import 'package:flutter_practice/bean/userbean.dart';
import 'package:flutter_practice/viewmodel/profilechangenotifier.dart';
import 'package:provider/provider.dart';

class ProviderViewModel3 extends ProfileChangeNotifier {
  UserBean get user => profile.user;

  // APP是否登录(如果有用户信息，则证明登录过)
  bool get isLogin => user != null;

  //用户信息发生变化，更新用户信息并通知依赖它的子孙Widgets更新
  set user(UserBean user) {
    if (user.login != profile.user?.login) {
      profile.lastLogin = profile.user?.login;
      profile.user = user;
      notifyListeners();
    }
  }
}

abstract class CommonInterface {
  UserBean getUser(BuildContext context) {
    return Provider.of<ProviderViewModel3>(context).user;
  }
}