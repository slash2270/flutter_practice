import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_practice/set.dart';
import 'package:path_provider/path_provider.dart';

Set set = Set();

class FileOperationWidget extends StatefulWidget {
  const FileOperationWidget({Key? key}) : super(key: key);

  @override
  _FileOperationWidgetState createState() => _FileOperationWidgetState();
}

class _FileOperationWidgetState extends State<FileOperationWidget> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    //从文件读取点击次数
    _readCounter().then((int value) {
      setState(() {
        _counter = value;
      });
    });
  }

  Future<File> _getLocalFile() async {
    // 获取应用目录
    String dir = (await getApplicationDocumentsDirectory()).path;
    return File('$dir/counter.txt');
  }

  Future<int> _readCounter() async {
    try {
      File file = await _getLocalFile();
      // 读取点击次数（以字符串）
      String contents = await file.readAsString();
      return int.parse(contents);
    } on FileSystemException {
      return 0;
    }
  }

  _incrementCounter() async {
    setState(() {
      _counter++;
    });
    await (await _getLocalFile()).writeAsString('$_counter');
  }

  _decrementCounter() async {
    setState(() {
      _counter--;
    });
    await (await _getLocalFile()).writeAsString('$_counter');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        set.initText2('$_counter', Colors.black, Colors.transparent, 20),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                child: set.initText2('increment', Colors.black, Colors.transparent, 18),
                onPressed: () {
                  _incrementCounter();
                }
            ),
            ElevatedButton(
                child: set.initText2('decrement', Colors.black, Colors.transparent, 18),
                onPressed: () {
                  _decrementCounter();
                }
            ),
          ],
        )
      ],
    );
  }

}