import 'dart:ui';

import 'package:flutter/services.dart';

class ScreenUtilFunc{

  //横屏
  static void setHorizontal(){
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]
    );
  }

  //竖屏
  static void setVertical(){
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
    );
  }

  //修改顶部状态栏颜色
  static void setStatusBarColor(Color color){
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: color);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

}