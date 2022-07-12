import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc1.dart';
import 'bloc3.dart';

class CounterBloc extends Bloc<CounterEvent, PointState> {
  var point;

  CounterBloc(PointState initialState) : super(initialState);

  //初始化 状态机 如果没传参 就构建一个(0,0,0)的对象
  PointState get initialState => point ?? PointState(0, 0, 0);

  Stream<PointState?> mapEventToState(CounterEvent event) async* {
    PointState currentState = PointState(state.x, state.y, state.z);
    if (event is ButtonPressedReduce) {
      currentState.x = state.x - 1;
      currentState.y = event.point.y;
      currentState.z = state.z - 1;
      yield currentState;
    } else if (event is ButtonPressedAdd) {
      currentState.x = state.x + 1;
      currentState.y = event.point.y;
      currentState.z = state.z + 1;
      yield currentState;
      //重置状态
    } else if (event is ButtonPressReset) {
      yield PointState.reset();
      //单点位数值增加
    } else if (event is ButtonPressAddX) {
      yield PointState.update(event.x, currentState.y, currentState.z);
    }
  }

}