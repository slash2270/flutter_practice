import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/value/colorvalue.dart';
import 'package:flutter_practice/view/eight.dart';

class GestureDetectorWidget extends StatefulWidget {
  const GestureDetectorWidget({Key? key}) : super(key: key);

  @override
  State<GestureDetectorWidget> createState() => _GestureDetectorWidgetState();
}

class _GestureDetectorWidgetState extends State<GestureDetectorWidget>
    with SingleTickerProviderStateMixin {
  String _operation = '點擊'; //保存事件名
  String _drag = '自由移動';
  String _dragOne = '單方向移動';
  String _zoom = '縮放';
  double _top = 0.0; //距顶部的偏移
  double _left = 0.0; //距左边的偏移
  double _topOne = 0.0; //距顶部的偏移
  double _leftOne = 0.0; //距左边的偏移
  double _size = 150.0; //通过修改图片宽度来达到缩放效果
  late GestureDetector _gestureDetector;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          _gestureDetector = GestureDetector(
            child: Container(
              alignment: Alignment.center,
              color: Colors.lightBlue,
              width: 300.0,
              height: 225.0,
              child: set.initText2(
                  _operation, Colors.white, ColorValue.transParent, 20),
            ),
            onTap: () => clickText("Tap"), //点击
            onDoubleTap: () => clickText("DoubleTap"), //双击
            onLongPress: () => clickText("LongPress"), //长按
          ),
          Container(
              alignment: Alignment.center,
              color: Colors.redAccent,
              width: 300.0,
              height: 225.0,
              child: Stack(
                children: <Widget>[
                  Positioned(
                      top: _top,
                      left: _left,
                      child: _gestureDetector = GestureDetector(
                        child: SizedBox(
                          height: 150,
                          width: 150,
                          child: CircleAvatar(
                              backgroundColor: ColorValue.black,
                              child: set.initText2(_drag, Colors.white,
                                  ColorValue.transParent, 20)),
                        ),
                        onPanDown: (DragDownDetails e) {
                          // 手指按下时会触发此回调
                          dragText(
                              '手指按下:\n${e.globalPosition}'); // 打印手指按下的位置(相对于屏幕)
                        },
                        onPanUpdate: (DragUpdateDetails e) {
                          // 手指滑动时会触发此回调
                          setState(() {
                            // 用户手指滑动时，更新偏移，重新构建
                            _left += e.delta.dx;
                            _top += e.delta.dy;
                          });
                          dragText('滑動刷新:\n左邊 -> $_left 上面 -> $_top');
                        },
                        onPanEnd: (DragEndDetails e) {
                          // 打印滑动结束时在x、y轴上的速度
                          dragText('滑動結束:\n${e.velocity}');
                        },
                      ))
                ],
              )),
          Container(
            alignment: Alignment.center,
            color: Colors.lightGreen,
            width: 300.0,
            height: 225.0,
            child: Positioned(
                top: _topOne,
                left: _leftOne,
                child: _gestureDetector = GestureDetector(
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: CircleAvatar(
                        backgroundColor: ColorValue.black,
                        child: set.initText2(_dragOne, Colors.white,
                            ColorValue.transParent, 20)),
                  ),
                  onVerticalDragUpdate: (DragUpdateDetails details) {
                    // 垂直方向拖动事件
                    setState(() {
                      _topOne += details.delta.dy;
                    });
                    dragOneText('垂直移動: $_topOne');
                  },
                  onHorizontalDragUpdate: (DragUpdateDetails details) {
                    // 水平方向拖动事件
                    setState(() {
                      _leftOne += details.delta.dx;
                    });
                    dragOneText('水平移動: $_leftOne');
                  },
                )),
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.yellowAccent,
            width: 300.0,
            height: 225.0,
            child: Positioned(
                top: _top,
                left: _left,
                child: _gestureDetector = GestureDetector(
                  child: SizedBox(
                    height: _size,
                    width: _size,
                    child: CircleAvatar(
                        backgroundColor: ColorValue.black,
                        child: set.initText2(
                            _zoom, Colors.white, ColorValue.transParent, 20)),
                  ),
                  onScaleUpdate: (ScaleUpdateDetails details) {
                    // 縮放
                    setState(() {
                      _size = 150 * details.scale.clamp(.8, 10.0);
                    });
                    zoomText('縮放刷新: $_size');
                  },
                )),
          ),
        ],
      ),
    );
  }

  void clickText(String text) {
    //更新显示的事件名
    setState(() {
      _operation = text;
    });
  }

  void dragText(String text) {
    //更新显示的事件名
    setState(() {
      _drag = text;
    });
  }

  void dragOneText(String text) {
    //更新显示的事件名
    setState(() {
      _dragOne = text;
    });
  }

  void zoomText(String text) {
    //更新显示的事件名
    setState(() {
      _zoom = text;
    });
  }
}
