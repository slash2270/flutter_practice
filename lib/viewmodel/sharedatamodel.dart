import 'package:flutter/material.dart';

class ShareDataWidget extends InheritedWidget {

  double data; //需要在子树中共享的数据，保存点击次数

  ShareDataWidget({Key? key, required this.data ,required Widget child}) : super(key: key, child: child);

  //定义一个方法，方便子树中的widget获取这个widget，进而获得共享数据。
  static ShareDataWidget of(BuildContext context){
    /**
     * 获取最近的给定类型的Widget，该widget必须是InheritedWidget的子类，
     * 并向该widget注册传入的context，当该widget改变时，
     * 这个context会重新构建以便从该widget获得新的值。
     * 这就是child向InheritedWidget注册的方法。
     */
    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>()!;

    ///如果我们只想在__TestWidgetState中引用ShareDataWidget数据，但却不希望在ShareDataWidget发生变化时调用__TestWidgetState的didChangeDependencies()方法应该怎么办？
    //return context.getElementForInheritedWidgetOfExactType<ShareDataWidget>()!.widget;

  }

  /// 该回调决定当data发生变化时，是否通知子树中依赖data的Widget重新build
  @override
  bool updateShouldNotify(ShareDataWidget oldWidget) {
    return oldWidget.data != data;
  }

}