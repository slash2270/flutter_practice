//Locale资源类
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../generated/intl/messages_all.dart';

class LocalizationsDemo {
  /*LocalizationsDemo(this.isZh);
  //是否为中文
  bool isZh = false;
  //为了使用方便，我们定义一个静态方法
  static LocalizationsDemo? of(BuildContext context) {
    return Localizations.of<LocalizationsDemo>(context, LocalizationsDemo);
  }
  //Locale相关值，title为应用标题
  String get title {
    return isZh ? 'DemoLocalizationsZH' : 'DemoLocalizationsEN';
  }*/
  static Future<LocalizationsDemo> load(Locale locale) {
    final String name = locale.countryCode!.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    //2
    return initializeMessages(localeName).then((b) {
      Intl.defaultLocale = localeName;
      return LocalizationsDemo();
    });
  }

  static LocalizationsDemo? of(BuildContext context) {
    return Localizations.of<LocalizationsDemo>(context, LocalizationsDemo);
  }

  String get title {
    return Intl.message(
      'Flutter APP',
      name: 'title',
      desc: 'Title for the Demo application',
    );
  }
}