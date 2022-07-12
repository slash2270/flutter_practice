import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FutureBuilderWidget2 extends StatefulWidget {
  const FutureBuilderWidget2 ({Key? key}) : super(key: key);

  @override
  State<FutureBuilderWidget2> createState() => _FutureBuilderWidget2State();
}

class _FutureBuilderWidget2State extends State<FutureBuilderWidget2 > {

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('FutureBuilder2 build');
    }
    return FutureBuilder(
        future: Dio().get("https://api.github.com/orgs/flutterchina/repos"),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //请求完成
          if (snapshot.connectionState == ConnectionState.done) {
            Response response = snapshot.data;
            //发生错误
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            //请求成功，通过项目信息构建用于显示项目名称的ListView
            return ListView(
              children: response.data.map<Widget>((e) =>
                  ListTile(title: Text(e["full_name"]))
              ).toList(),
            );
          }
          //请求未完成时弹出loading
          return const CircularProgressIndicator();
        }
    );
  }

}