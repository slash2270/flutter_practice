import 'package:event_bus/event_bus.dart';

import 'package:rxdart/rxdart.dart';

//EventBus behaviorBus = EventBus.customController(BehaviorSubject());

//final eventBus = EventBus();

// 创建EventBus
class EventBusUtils {
  static EventBus? _instance;

  static EventBus getInstance() {
    if (_instance == null) {
      _instance = EventBus();
    }
    return _instance!;
  }
}

class EventBusBroadCast {

  String transaction;
  EventBusBroadCast(this.transaction);

}