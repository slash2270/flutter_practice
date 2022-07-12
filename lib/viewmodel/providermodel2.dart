// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 這是使用提供程序重新實現默認 Flutter 應用程序 + [ChangeNotifier].

/// Mix-in [DiagnosticableTreeMixin] to have access to [debugFillProperties] for the devtool
// ignore: prefer_mixin
class ProviderViewModel2 with ChangeNotifier, DiagnosticableTreeMixin {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement(){
    _count--;
    notifyListeners();
  }

  /// 通過列出其所有屬性使`Counter`在開發工具中可讀
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', count));
  }
}

class ProviderViewModel2Widget extends StatelessWidget {
  const ProviderViewModel2Widget ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      /// 當 [Counter] 改變時，調用 `context.watch` 使 [Count] 重建。
        '${context.watch<ProviderViewModel2>().count}',
        key: const Key('counterState'),
        style: Theme.of(context).textTheme.headline4);
  }
}