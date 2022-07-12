import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WillPopScopeWidget extends StatefulWidget {
  const WillPopScopeWidget({Key? key}) : super(key: key);

  @override
  WillPopScopeWidgetState createState() {
    return WillPopScopeWidgetState();
  }
}

class WillPopScopeWidgetState extends State<WillPopScopeWidget> {
  DateTime? _lastPressedAt; //上次点击时间
  //final GlobalKey<NavigatorState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('WillPopScope build');
    }
   /* return WillPopScope(
        onWillPop: () async {
          if (_key.currentState!.canPop()) {
            _key.currentState!.pop();
            return false;
          }
          return true;
        },
        child: Column(
          children: <Widget>[
            Expanded(
              child: Navigator(
                key: _key,
                onGenerateRoute: (RouteSettings settings) =>
                    MaterialPageRoute(builder: (context) {
                      return const Second();
                    }),
              ),
            ),
            Container(
              color: Colors.blue,
              alignment: Alignment.center,
              child: const Text('底部Bar'),
            )
          ],
        ));*/

    return WillPopScope(
      onWillPop: () async {
        if (_lastPressedAt == null || DateTime.now().difference(_lastPressedAt!) > const Duration(milliseconds: 1000)) {
          //两次点击间隔超过1秒则重新计时
          _lastPressedAt = DateTime.now();
          EasyLoading.addStatusCallback((status) {
            print('EasyLoading Status $status');
          });
          EasyLoading.showToast("再點擊一次退出App");
          return false;
        }
        return true;
      },
      child: Container(
        /*width: 120,
        color: ColorValue.blue,
        alignment: Alignment.center,
        margin: set.initEdgeInsets(0.0, 15.0, 0.0, 0.0),*/
        child: const Text(''),
      ),
    );
  }
}