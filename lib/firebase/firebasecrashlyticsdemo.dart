import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

class FirebaseCrashlyticsDemo extends StatefulWidget {
  @override
  State<FirebaseCrashlyticsDemo> createState() => _FirebaseCrashlyticsDemoState();
}

class _FirebaseCrashlyticsDemoState extends State<FirebaseCrashlyticsDemo> {
  late StackTrace? _stackTrace;

  @override Widget build(BuildContext context) {
    return Padding(
      padding: set.initEdgeInsetsTop(20.0),
      child: Center(
          child: Column(
            children: <Widget>[
              set.initText2('FireBase Crashlytics', Colors.black, Colors.transparent, 24),
              Column(
                children: [
                  RaisedButton(child: set.initText('Forcing a Crash'), onPressed: () {
                    FirebaseCrashlytics.instance.setUserIdentifier("770722");
                    FirebaseCrashlytics.instance.crash();
                    FirebaseCrashlytics.instance.log("自定義Forcing");
                  },),
                  RaisedButton(child: set.initText('Fatal Crash'), onPressed: () {
                    FirebaseCrashlytics.instance.setUserIdentifier("770722");
                    _stackTrace = StackTrace.current;
                    _setFatalError();
                    FirebaseCrashlytics.instance.log("自定義Fatal");
                  },),
                  RaisedButton(child: set.initText('NonFatal Crash'), onPressed: () {
                    FirebaseCrashlytics.instance.setUserIdentifier("770722");
                    _stackTrace = StackTrace.current;
                    _setNonFatalError();
                    FirebaseCrashlytics.instance.log("自定義NonFatal");
                  },),
                  RaisedButton(child: set.initText('Throw Error'), onPressed: () {
                    FirebaseCrashlytics.instance.setUserIdentifier("770722");
                    FirebaseCrashlytics.instance.log("自定義Error");
                    throw Error();
                  },),
                  RaisedButton(child: set.initText('Custom Log'), onPressed: () {
                    FirebaseCrashlytics.instance.log("自定義Crash Log\n已包在其他按鈕");
                  },),
                  RaisedButton(child: Text('User ID\n已包在其他按鈕', textAlign: TextAlign.center,),
                    onPressed: () {
                      FirebaseCrashlytics.instance.setUserIdentifier("770722");
                  },),
                ],
              ),
            ],
          )),
    );
  }

  void _setFatalError() async{
    await FirebaseCrashlytics.instance.recordError(
        '520',
        _stackTrace,
        reason: '致命錯誤',
        // Pass in 'fatal' argument
        fatal: true
    );
  }

  void _setNonFatalError() async{
    await FirebaseCrashlytics.instance.recordError(
        '我愛妳',
        _stackTrace,
        reason: '非致命錯誤',
        // Pass in 'fatal' argument
        fatal: true
    );
  }

}