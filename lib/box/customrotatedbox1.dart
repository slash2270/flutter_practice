import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

class CustomRotatedBox1 extends SingleChildRenderObjectWidget {
  const CustomRotatedBox1 ({Key? key, Widget? child}) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return CustomRenderRotatedBox1();
  }
}

class CustomRenderRotatedBox1 extends RenderBox with RenderObjectWithChildMixin<RenderBox> {

  late Matrix4? _paintTransform;

  @override
  void performLayout() {
    if (child != null) {
      child!.layout(constraints, parentUsesSize: true);
      size = child!.size;
      //根据子组件大小计算出旋转矩阵
      _paintTransform = Matrix4.identity()
        ..translate(size.width / 2.0, size.height / 2.0)
        ..rotateZ(math.pi / 2) // 旋转90度
        ..translate(-child!.size.width / 2.0, -child!.size.height / 2.0);
    } else {
      size = constraints.smallest;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if(child != null){
      // 根据偏移，需要调整一下旋转矩阵
      final Matrix4 transform =
      Matrix4.translationValues(offset.dx, offset.dy, 0.0)
        ..multiply(_paintTransform!)
        ..translate(-offset.dx, -offset.dy);
      _paint(context, offset, transform);
    } else {
      //...
    }
  }

  void _paint(PaintingContext context, Offset offset, Matrix4 transform) {
    // 为了不干扰其它和自己在同一个layer上绘制的节点，所以需要先调用save然后在子元素绘制完后
    // 再restore显示，关于save/restore有兴趣可以查看Canvas API doc
    context.canvas
      ..save()
      ..transform(transform.storage);
    context.paintChild(child!, offset);
    context.canvas.restore();
  }

  @override
  void dispose() {
    _paintTransform = null;
    super.dispose();
  }

}