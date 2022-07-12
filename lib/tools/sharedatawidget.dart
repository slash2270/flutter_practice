import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_practice/viewmodel/sharedatamodel.dart';

class SharedDataWidget extends StatefulWidget{
  const SharedDataWidget ({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SharedDataWidgetState();
  }
}
class SharedDataWidgetState extends State<SharedDataWidget>{
  @override
  Widget build(BuildContext context) {
    return Text('總價: ${ShareDataWidget.of(context).data}');
  }

  /// 如果依赖的InheritedWidget改变了，framework将会调用这个方法来通知这个对象。
  /// 在这个方法中调用BuildContext.inheritFromWidgetOfExactType是安全的。
  /// 子类很少覆写这个方法，因为framework通常会在依赖的InheritedWidget改变后调用build方法，
  /// 覆写这个方法通常用来做一些耗时的工作，比如网络请求
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (kDebugMode) {
      print("Tools Text Dependencies Change");
    }
  }
}