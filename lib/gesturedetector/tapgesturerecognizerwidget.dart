import 'package:flutter/gestures.dart';

class TapGestureRecognizerWidget extends TapGestureRecognizer {

  @override
  void addPointer(PointerDownEvent event) {
    //会将 handleEvent 回调添加到 pointerRouter 中
    GestureBinding.instance.pointerRouter.addRoute(event.pointer, handleEvent);
  }

  @override
  void handleEvent(PointerEvent event) {
    //会进行手势识别，并决定是是调用 acceptGesture 还是 rejectGesture，
  }

  @override
  void acceptGesture(int pointer) {
    // 竞争胜出会调用
  }

  @override
  void rejectGesture(int pointer) {
    // 竞争失败会调用
  }

}