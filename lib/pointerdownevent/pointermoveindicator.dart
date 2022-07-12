import 'package:flutter/material.dart';
import 'package:flutter_practice/view/eight.dart';

class PointerMoveIndicator extends StatefulWidget { // 觸控事件攔截
  const PointerMoveIndicator({Key? key}) : super(key: key);

  @override
  State<PointerMoveIndicator> createState() => _PointerMoveIndicatorState();
}

class _PointerMoveIndicatorState extends State<PointerMoveIndicator> {
  PointerEvent? _event, _eventAbsorb, _eventIgnore;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Listener(
          child: Container(
              alignment: Alignment.center,
              color: Colors.blue,
              width: 300.0,
              height: 225.0,
              child: set.initText2('Normal ${_event?.localPosition ?? ''}', Colors.white, Colors.transparent, 24)),
          onPointerDown: (PointerDownEvent event) => setState(() => _event = event),
          onPointerMove: (PointerMoveEvent event) => setState(() => _event = event),
          onPointerUp: (PointerUpEvent event) => setState(() => _event = event),
        ),
        Listener(
          child: AbsorbPointer(
            // 本身是可以接收指针事件的，所以会输出
            child: Listener(
              child: Container(
                  alignment: Alignment.center,
                  color: Colors.red,
                  width: 300.0,
                  height: 225.0,
                  child: set.initText2('Absorb ${_eventAbsorb?.localPosition ?? ''}', Colors.white, Colors.transparent, 24)),
            ),
          ),
          onPointerDown: (PointerDownEvent event) => setState(() => _eventAbsorb = event),
          onPointerMove: (PointerMoveEvent event) => setState(() => _eventAbsorb = event),
          onPointerUp: (PointerUpEvent event) => setState(() => _eventAbsorb = event),
        ),
        Listener(
          child: IgnorePointer( // 本身不会参与
            child: Listener(
              child: Container(
                  alignment: Alignment.center,
                  color: Colors.green,
                  width: 300.0,
                  height: 225.0,
                  child: set.initText2('Ignore ${_eventIgnore?.localPosition ?? ''}', Colors.white, Colors.transparent, 24)),
              onPointerDown: (PointerDownEvent event) => setState(() => _eventIgnore = event),
              onPointerMove: (PointerMoveEvent event) => setState(() => _eventIgnore = event),
              onPointerUp: (PointerUpEvent event) => setState(() => _eventIgnore = event),
            ),
          ),
          onPointerDown: (PointerDownEvent event) => setState(() => _eventIgnore = event),
          onPointerMove: (PointerMoveEvent event) => setState(() => _eventIgnore = event),
          onPointerUp: (PointerUpEvent event) => setState(() => _eventIgnore = event),
        ),
      ],
    );
  }
}
