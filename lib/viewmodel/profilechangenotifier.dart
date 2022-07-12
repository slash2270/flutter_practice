import 'package:flutter/material.dart';
import 'package:flutter_practice/bean/profilebean.dart';

import '../utils/global.dart';

class ProfileChangeNotifier extends ChangeNotifier {
  ProfileBean get profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile(); //保存Profile变更
    super.notifyListeners(); //通知依赖的Widget更新
  }
}