import 'package:flutter/material.dart';
import 'package:flutter_practice/viewmodel/providermodel2.dart';
import 'package:provider/provider.dart';

class ProviderDemo2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ProviderViewModel2()),],
      child: ProvideViewModel2Widget(),
    );
  }
}

class ProvideViewModel2Widget extends StatefulWidget {
  const ProvideViewModel2Widget({Key? key}) : super(key: key);

  @override
  State<ProvideViewModel2Widget> createState() => _ProvideViewModel2WidgetState();
}

class _ProvideViewModel2WidgetState extends State<ProvideViewModel2Widget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text('自定義Provider2', style: TextStyle(color: Colors.green, fontSize: 24,), textAlign: TextAlign.center,),
            Text('您已經多次按下按鈕：'),
            /// 提取為單獨的小部件以進行性能優化。
            /// 作為一個單獨的小部件，它將獨立於[MyHomePage]重建。
            ///
            /// 這完全是可選的（很少需要）。
            /// 同樣，我們也可以使用 [Consumer] 或 [Selector]。
            ProviderViewModel2Widget(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Builder(builder: (context) {
              return ElevatedButton(
                key: const Key('increment_floatingActionButton'),
                child: const Text("添加商品"),
                onPressed: () {
                  context.read<ProviderViewModel2>().increment();
                },
              );
            }),
            Builder(builder: (context) {
              return ElevatedButton(
                key: const Key('decrement_floatingActionButton'),
                child: const Text("減少商品"),
                onPressed: () {
                  context.read<ProviderViewModel2>().decrement();
                },
              );
            }),
          ],
        ),
      ],
    );
  }
}