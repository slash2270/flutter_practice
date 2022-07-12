import 'package:equatable/equatable.dart';

import 'bloc3.dart';

abstract class CounterEvent extends Equatable {
  const CounterEvent();
}

//重置数据 无需逻辑行为或返回参数,纯粹当指令用
class ButtonPressReset extends CounterEvent {
  @override
  List<Object> get props => [];
}

//点位增加 传入某个值，做更新操作
class ButtonPressAddX extends CounterEvent {
  final int x;

  const ButtonPressAddX({
    required this.x,
  });

  @override
  List<Object> get props => [x];

  @override
  String toString() {
    return 'ButtonPressAddX { x: $x }';
  }
}

//点位数值整体重置，所以传入整个状态对象, event 本身不对值进行篡改
class ButtonPressedAdd extends CounterEvent {
  final PointState point;

  const ButtonPressedAdd({
    required this.point,
  });

  @override
  List<Object> get props => [point];

  @override
  String toString() => getString();

  String getString() {
    var x = point.x;
    var y = point.y;
    var z = point.z;
    return 'ButtonPressedAdd { x: $x, y: $y , z: $z }';
  }
}

class ButtonPressedReduce extends CounterEvent {
  final PointState point;

  const ButtonPressedReduce({
    required this.point,
  });

  @override
  List<Object> get props => [point];

  @override
  String toString() => getString();

  String getString() {
    var x = point.x;
    var y = point.y;
    var z = point.z;
    return 'ButtonPressedReduce { x: $x, y: $y , z: $z }';
  }

}