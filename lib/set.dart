import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_practice/bean/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_app_settings/open_app_settings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_platform/universal_platform.dart';

class Set{

  ///這個 model 只管理一個變數。
  late Text text = const Text("");
  late Icon icon = const Icon(null);
  late IconButton iconButton = IconButton(onPressed: (){}, icon: Container());
  late BoxConstraints boxConstraints = const BoxConstraints( maxWidth: 0, maxHeight: 0, minWidth: 0, minHeight: 0);
  late EdgeInsets edgeInsets = const EdgeInsets.only(left: 0.0, top: 0.0, right: 0.0, bottom: 0.0);
  late SizedBox sizedBox;
  late Padding padding;
  late String platForm;
  //late double displayHeight = MediaQueryData().size.height, displayWidth = MediaQueryData().size.width;

  ///操作變數
  Widget initIcon(IconData? iconData) {
    return icon = Icon(iconData);
  }

  Widget initIcon1(IconData? iconData, double? size) {
    return icon = Icon(iconData, size: size);
  }

  Widget initIcon2(IconData? iconData, double? size, Color? color) {
    return icon = Icon(iconData, size: size, color: color);
  }

  Widget initIconButton(Function()? function, Widget iconData) {
    return iconButton = IconButton(onPressed: function, icon: iconData);
  }

  Widget initIconButton1(Function()? function, Widget iconData, double? size) {
    return iconButton = IconButton(onPressed: function, icon: iconData, iconSize: size);
  }

  Widget initIconButton2(Function()? function, Widget iconData, double? size, Color? color) {
    return iconButton = IconButton(onPressed: function, icon: iconData, iconSize: size, color: color);
  }

  Widget initText(String? textStr) {
    return text = Text(textStr ?? "");
  }

  Widget initText1(String? textStr, Color? color, Color? backGroundColor) {
    return text = Text(textStr ?? "", style: TextStyle(color: color, backgroundColor: backGroundColor));
  }

  Widget initText2(String? textStr, Color? textColor, Color? backGroundColor, double? fontSize) {
    return text = Text(textStr ?? "", textAlign: TextAlign.center, style: TextStyle(color: textColor, backgroundColor: backGroundColor, fontSize: fontSize));
  }

  Widget initText3(String? textStr, Color? textColor, Color? backGroundColor, double? fontSize, TextDecoration decoration) {
    return text = Text(textStr ?? "", style: TextStyle(color: textColor, backgroundColor: backGroundColor, fontSize: fontSize, decoration: decoration));
  }

  Widget initText4(String? textStr, Color? textColor, Color? backGroundColor, double? fontSize, FontWeight fontWeight) {
    return text = Text(textStr ?? "", style: TextStyle(color: textColor, backgroundColor: backGroundColor, fontSize: fontSize, fontWeight: fontWeight));
  }

  BoxConstraints initBoxConstraint(double? maxWidth, double? maxHeight, double? minWidth, double? minHeight){
    return boxConstraints = BoxConstraints(maxWidth: maxWidth ?? 0.0, maxHeight: maxHeight?? 0.0, minWidth: minWidth ?? 0.0, minHeight: minHeight ?? 0.0);
  }

  EdgeInsets initEdgeInsets(double? left, double? top, double? right, double? bottom){
    return edgeInsets = EdgeInsets.only(left: left ?? 0.0, top: top ?? 0.0, right: right ?? 0.0, bottom: bottom ?? 0.0);
  }

  EdgeInsets initEdgeInsetsTop(double? top){
    return edgeInsets = EdgeInsets.only(top: top ?? 0.0);
  }

  SizedBox initSizedBox(double? height){
    return sizedBox = SizedBox(height: height);
  }

  Padding initPadding(double? left, double? top, double? right, double? bottom, Widget child){
    return padding = Padding(padding: initEdgeInsets(left, top, right, bottom), child: child,);
  }

  Widget textPainter(String string) {
    // 我们想提前知道 Text 组件的大小
    Text text = initText(string) as Text;
    // 使用 TextPainter 来测量
    TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
    // 将 Text 组件文本和样式透传给TextPainter
    painter.text = TextSpan(text:text.data, style:text.style);
    // 开始布局测量，调用 layout 后就能获取文本大小了
    painter.layout();
    // 自定义组件 AfterLayout 可以在布局结束后获取子组件的大小，我们用它来验证一下
    // TextPainter 测量的宽高是否正确
    return initText2('$string \nPainter 尺寸 ${painter.size}', Colors.green, Colors.transparent, 18);
  }

  void goOriginal() { // 底層創建方式

    //1.创建绘制记录器和Canvas
    PictureRecorder recorder = PictureRecorder();
    Canvas canvas = Canvas(recorder);
    //2.在指定位置区域绘制。
    var rect = const Rect.fromLTWH(30, 200, 300,300 );
    drawChessboard(canvas,rect); //画棋盘
    drawPieces(canvas,rect);//画棋子
    //3.创建layer，将绘制的产物保存在layer中
    var pictureLayer = PictureLayer(rect);
    //recorder.endRecording()获取绘制产物。
    pictureLayer.picture = recorder.endRecording();
    var rootLayer = OffsetLayer();
    rootLayer.append(pictureLayer);
    //4.上屏，将绘制的内容显示在屏幕上。
    final SceneBuilder builder = SceneBuilder();
    final Scene scene = rootLayer.buildScene(builder);
    window.render(scene);

  }

  void drawChessboard(Canvas canvas, Rect rect) {

    //棋盘背景
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill //填充
      ..color = const Color(0xFFDCC48C);
    canvas.drawRect(rect, paint);
    //画棋盘网格
    paint
      ..style = PaintingStyle.stroke //线
      ..color = Colors.black38
      ..strokeWidth = 1.0;
    //画横线
    for (int i = 0; i <= 15; ++i) {
      double dy = rect.top + rect.height / 15 * i;
      canvas.drawLine(Offset(rect.left, dy), Offset(rect.right, dy), paint);
    }
    for (int i = 0; i <= 15; ++i) {
      double dx = rect.left + rect.width / 15 * i;
      canvas.drawLine(Offset(dx, rect.top), Offset(dx, rect.bottom), paint);
    }

  }

  //画棋子
  void drawPieces(Canvas canvas, Rect rect) {

    double eWidth = rect.width / 15;
    double eHeight = rect.height / 15;
    //画一个黑子
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black;
    //画一个黑子
    canvas.drawCircle(
      Offset(rect.center.dx - eWidth / 2, rect.center.dy - eHeight / 2),
      min(eWidth / 2, eHeight / 2) - 2,
      paint,
    );
    //画一个白子
    paint.color = Colors.white;
    canvas.drawCircle(
      Offset(rect.center.dx + eWidth / 2, rect.center.dy - eHeight / 2),
      min(eWidth / 2, eHeight / 2) - 2,
      paint,
    );

  }

  //顯示 SnackBar 訊息與自定義按鈕
  void snackBar(BuildContext context, String message, String label) {
    final snackBar = SnackBar(
      onVisible: () {
        if (kDebugMode) {
          //print("顯示");
        }
      },
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.black,
      content: initText(message),
      action: SnackBarAction(
        label: label,
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // 保存图片的权限校验
  checkPermission(Future<dynamic> fun) {
    photosPermission().then((value) => {
      if (value)
        {
          // 执行操作
          fun
        }
      else
        {
          // 去授权 存储权限
          OpenAppSettings.openAppSettings()
        }
    });
  }

// 动态申请权限，ios 要在info.plist 上面添加
  Future<bool> photosPermission() async {
    if (Platform.isIOS) {
      var status = await Permission.photos.status;
      if (status.isDenied) {
        await [
          Permission.photos,
        ].request();
      }
      return status.isGranted;
    } else {
      var status = await Permission.storage.status;
      if (status.isDenied) {
        await [
          Permission.storage,
        ].request();
      }
      return status.isGranted;
    }
  }

  String getPlatForm(){

    platForm = 'Platform ';

    if(Platform.isFuchsia){
      platForm += "Fuchsia";
    }else if(Platform.isWindows){
      platForm += "Windows";
    }else if(Platform.isLinux){
      platForm += "Linux";
    }else if(Platform.isMacOS){
      platForm += "MacOS";
    }else if(Platform.isIOS){
      platForm += "IOS";
    }else if(Platform.isAndroid){
      platForm += "Android";
    }

    return platForm;
  }

  String getUniversalPlatform(){

    platForm = 'UniversalPlatform ';

    if(UniversalPlatform.isDesktopOrWeb){
      platForm += 'DesktopOrWeb';
    }else if(UniversalPlatform.isDesktop){
      platForm += 'Desktop';
    }else if(UniversalPlatform.isFuchsia){
      platForm += 'Fuchsia';
    }else if(UniversalPlatform.isWindows){
      platForm += 'Windows';
    }else if(UniversalPlatform.isLinux){
      platForm += 'Linux';
    }else if(UniversalPlatform.isMacOS){
      platForm += 'MacOS';
    }else if(UniversalPlatform.isWeb){
      platForm += 'Web';
    }else if(UniversalPlatform.isIOS){
      platForm += 'IOS';
    }else if(UniversalPlatform.isAndroid){
      platForm += 'Android';
    }

    return platForm;
  }

  Widget fortyThreePopScope(BuildContext context){
    return WillPopScope(
      onWillPop: () async {
        await Navigator.pushReplacementNamed(context, '/FortyThree');
        return true;
      },
      child: Container(),
    );
  }

  Future<void> sensSms(String mobile) async {
    print('發送驗證碼...');
    await Future.delayed(Duration(seconds: 1));
    print('發送驗證碼成功');
  }

  /// 用户登录。简单起见，返回User
  Future<User> login(String mobile, String sms) async {
    print('登入中...');
    await Future.delayed(Duration(seconds: 1));
    User user = User(1, 'Slash');
    print('登入成功: $user');
    return user;
  }

  void setLoadingDialog(BuildContext context, bool isDismiss) async{
    AlertDialog dialog = AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          CircularProgressIndicator(),
          Padding(
            padding: EdgeInsets.only(top: 26.0),
            child: Text("正在加載，請稍候..."),
          )
        ],
      ),
    );
    await showDialog(
      context: context,
      barrierDismissible: isDismiss, //点击遮罩不关闭对话框
      builder: (context) {
        return UnconstrainedBox(
          constrainedAxis: Axis.vertical,
          child: SizedBox(
              width: 280,
              child: dialog
          ),
        );
      },
    );
  }

  void showToast(String msg) async {
    await Fluttertoast.showToast(
        msg: msg,
        fontSize: 16,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT);
  }


}