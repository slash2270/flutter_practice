import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practice/bloc/teststate.dart';

class TestCubit extends Cubit<TestState> {
  TestCubit() : super(TestState().init());

  /*TestCubit() : super(0);
    void increment() => emit(state + 1);
    void decrement() => emit(state - 1);

  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    if (kDebugMode) {
      print(change);
    }
  }*/

  @override
  void onError(Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      print('$error, $stackTrace');
    }
    super.onError(error, stackTrace);
  }

  void increment() => emit(state.clone()..count = ++state.count);
  void decrement() => emit(state.clone()..count = --state.count);

}