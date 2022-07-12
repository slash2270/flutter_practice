import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practice/bloc/testevent.dart';
import 'package:flutter_practice/bloc/teststate.dart';

class TestBloc extends Bloc<TestEvent, TestState> {

  TestBloc() : super(TestState().init()) {
    on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<TestState> emit) async {
    emit(state.clone());
  }

}