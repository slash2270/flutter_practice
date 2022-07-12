import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_practice/view/eight.dart';

class PointerDownListener extends SingleChildRenderObjectWidget {
  const PointerDownListener({Key? key, this.onPointerDown, Widget? child})
      : super(key: key, child: child);

  final PointerDownEventListener? onPointerDown;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      RenderPointerDownListener()..onPointerDown = onPointerDown;

  @override
  void updateRenderObject(
      BuildContext context, RenderPointerDownListener renderObject) {
    renderObject.onPointerDown = onPointerDown;
  }
}

class RenderPointerDownListener extends RenderProxyBox {
  PointerDownEventListener? onPointerDown;

  @override
  bool hitTestSelf(Offset position) => true; //始终通过命中测试

  @override
  void handleEvent(PointerEvent event, covariant HitTestEntry entry) {
    //事件分发时处理事件
    if (event is PointerDownEvent) onPointerDown?.call(event);
  }
}

class HitTestBehaviorWidget extends StatefulWidget {
  const HitTestBehaviorWidget({Key? key}) : super(key: key);

  @override
  State<HitTestBehaviorWidget> createState() => _HitTestBehaviorWidgetState();

}

class _HitTestBehaviorWidgetState extends State<HitTestBehaviorWidget> {
  String _strClick = '點擊';

  @override
  Widget build(BuildContext context) {
    return PointerDownListener(
      child: Container(
        alignment: Alignment.center,
        color: Colors.brown,
        width: 300.0,
        height: 225.0,
        child: Center(
          child: set.initText2(_strClick, Colors.white, Colors.transparent, 24)
        ),
      ),
      onPointerDown: (PointerDownEvent event) {
        setState(() {
          _strClick = '${event.down}';
        });
      }
    );
  }

}