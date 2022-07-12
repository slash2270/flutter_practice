
import 'package:flutter/material.dart';

import 'localizationsdemo.dart';

//Locale代理类
class LocalizationsDelegateDemo extends LocalizationsDelegate<LocalizationsDemo> {
  const LocalizationsDelegateDemo();

  //是否支持某个Local
  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  // Flutter会调用此类加载相应的Locale资源类
  @override
  Future<LocalizationsDemo> load(Locale locale) {
    return LocalizationsDemo.load(locale);
    /*return SynchronousFuture<LocalizationsDemo>(
        LocalizationsDemo(locale.languageCode == 'zh')
    );*/
  }

  @override
  bool shouldReload(LocalizationsDelegateDemo old) => false;
}