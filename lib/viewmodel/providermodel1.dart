// 一个通用的InheritedWidget，保存需要跨组件共享的状态
import 'package:flutter/widgets.dart';

class InheritedProvider<T> extends InheritedWidget {
  const InheritedProvider({required this.data, required Widget child,}) : super(child: child);

  final T data;

  @override
  bool updateShouldNotify(InheritedProvider<T> old) {
    //在此简单返回true，则每次更新都会调用依赖其的子孙节点的`didChangeDependencies`。
    return true;
  }
}

class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  const ChangeNotifierProvider({Key? key, required this.data, required this.child,});

  final Widget child;
  final T data;

  //定义一个便捷方法，方便子树中的widget获取共享数据 添加一个listen参数，表示是否建立依赖关系
  static T of<T>(BuildContext context, {bool listen = true}) {
    //final type = _typeOf<InheritedProvider<T>>();
    final provider = listen
        ? context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>() // 註冊依賴關係
        : context.getElementForInheritedWidgetOfExactType<InheritedProvider<T>>()?.widget // 破壞依賴關係 不再重建子組件
    as InheritedProvider<T>;
    return provider!.data;
  }

  @override
  _ChangeNotifierProviderState<T> createState() => _ChangeNotifierProviderState<T>();
}

class _ChangeNotifierProviderState<T extends ChangeNotifier> extends State<ChangeNotifierProvider<T>> {
  void update() {
    //如果数据发生变化（model类调用了notifyListeners），重新构建InheritedProvider
    setState(() => {});
  }

  @override
  void didUpdateWidget(ChangeNotifierProvider<T> oldWidget) {
    //当Provider更新时，如果新旧数据不"=="，则解绑旧数据监听，同时添加新数据监听
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // 给model添加监听器
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    // 移除model的监听器
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }
}

// 这是一个便捷类，会获得当前context和指定数据类型的Provider
class Consumer<T> extends StatelessWidget {
  const Consumer({Key? key, required this.builder,}) : super(key: key);

  final Widget Function(BuildContext context, T? value) builder;

  @override
  Widget build(BuildContext context) {
    return builder(
      context,
      ChangeNotifierProvider.of<T>(context),
    );
  }
}