import 'package:flutter/material.dart';
import 'package:flutter_practice/viewmodel/providermodel3.dart';
import 'package:get/utils.dart';
import 'package:provider/provider.dart';

class ProviderDemo3 extends StatelessWidget with CommonInterface {
  ProviderDemo3({Key? key, this.info}) : super(key: key);
  final info;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ProviderViewModel3 newUserModel = new ProviderViewModel3();
    return MultiProvider(
      providers: [
        // 用户信息
        ListenableProvider<ProviderViewModel3>.value(value: newUserModel),
      ],
      child: ProviderWidget3(),
    );
  }
}

class ProviderWidget3 extends StatefulWidget {
  const ProviderWidget3({Key? key}) : super(key: key);

  @override
  State<ProviderWidget3> createState() => _ProviderWidget3State();
}

class _ProviderWidget3State extends State<ProviderWidget3> with CommonInterface{

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('自定義Provider3', style: TextStyle(color: Colors.green, fontSize: 24,), textAlign: TextAlign.center,),
            Text(getUser(context).isBlank == true ? '' : getUser(context).name.toString()),
          ],
        ),
      ],
    );
  }

}