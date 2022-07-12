import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practice/bloc/testcubit.dart';
import 'package:flutter_practice/bloc/teststate.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

class Nine extends StatelessWidget {
  const Nine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TestCubit(),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }
}

Widget _buildPage(BuildContext context) {
  final testCubit = BlocProvider.of<TestCubit>(context);

  return Container(
    color: Colors.white,
    padding: set.initEdgeInsets(15.0, 20.0, 15.0, 20.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<TestCubit, TestState>(
          builder: (context, testState) => Text(
            'BlocBuilder StateCount -> ${testCubit.state.count}',
            style: const TextStyle(
              fontSize: 32,
              color: Colors.blue,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlatButton(
                onPressed: () {
                  testCubit.increment();
                },
                child: const Text(
                  'add',
                )),
            FlatButton(
                onPressed: () async {
                  testCubit.decrement();
                },
                child: const Text(
                  'minus',
                )),
          ],
        )
      ],
    ),
  );
}

///自定义Builder
class BlocEasyBuilder<T extends BlocBase<V>, V> extends StatefulWidget {
  const BlocEasyBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final Function(BuildContext context, V state) builder;

  @override
  _BlocEasyBuilderState createState() => _BlocEasyBuilderState<T, V>();
}

class _BlocEasyBuilderState<T extends BlocBase<V>, V> extends State<BlocEasyBuilder<T, V>> {
  late T _bloc;
  late V _state;
  StreamSubscription<V>? _listen;

  @override
  void initState() {
    _bloc = BlocProvider.of<T>(context);
    _state = _bloc.state;

    //数据改变刷新Widget
    _listen = _bloc.stream.listen((event) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _state);
  }

  @override
  void dispose() {
    _listen?.cancel();
    super.dispose();
  }

}