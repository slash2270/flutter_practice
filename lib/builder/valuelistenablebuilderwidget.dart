import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ValueListenableBuilderWidget extends StatefulWidget {
  const ValueListenableBuilderWidget ({Key? key}) : super(key: key);

  @override
  State<ValueListenableBuilderWidget> createState() => _ValueListenableState();
}

class _ValueListenableState extends State<ValueListenableBuilderWidget > {
  // 定义一个ValueNotifier，当数字变化时会通知 ValueListenableBuilder
  late ValueNotifier<int> _counter;

  @override
  void initState() {
    _counter = ValueNotifier<int>(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 添加 + 按钮不会触发整个 ValueListenableRoute 组件的 build
    if (kDebugMode) {
      print('ValueListenableBuilder build');
    }
    return ValueListenableBuilder<int>(
      builder: (BuildContext context, int value, Widget? child) {
        // builder 方法只会在 _counter 变化时被调用
        return Column(
          children: <Widget>[
            child!,
            Text('次數: $value'),
          ],
        );
      },
      valueListenable: _counter,
      // 当子组件不依赖变化的数据，且子组件收件开销比较大时，指定 child 属性来缓存子组件非常有用
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            child: const Text("Increment"),
            //每点击一次，将count自增，然后重新build,ShareDataWidget的data将被更新
            onPressed: () => setState(() => _counter.value += 1),
          ),
          ElevatedButton(
            child: const Text("Decrement"),
            //每点击一次，将count自增，然后重新build,ShareDataWidget的data将被更新
            onPressed: () => setState(() => _counter.value -= 1),
          )
        ],
      ),
    );
  }
}