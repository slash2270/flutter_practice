import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

class CustomRotatedBox2 extends SingleChildRenderObjectWidget {
  const CustomRotatedBox2 ({Key? key, Widget? child}) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return CustomRenderRotatedBox2();
  }
}

class CustomRenderRotatedBox2 extends RenderBox with RenderObjectWithChildMixin<RenderBox> {

  late Matrix4? _paintTransform;
  // 创建一个持有 TransformLayer 的 handle.
  final LayerHandle<TransformLayer> _transformLayer = LayerHandle<TransformLayer>();

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
    if (child != null) {
      final Matrix4 transform =
      Matrix4.translationValues(offset.dx, offset.dy, 0.0)
        ..multiply(_paintTransform!)
        ..translate(-offset.dx, -offset.dy);
      if (child!.isRepaintBoundary) { // 添加判断
        _paintWithNewLayer(context, offset, transform);
      } else {
        _paint(context, offset, transform);
      }
    } else {
      _transformLayer.layer = null;
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

  // 子节点绘制回调
  void _paintChild(PaintingContext context, Offset offset) {
    context.paintChild(child!, offset);
  }

  void _paintWithNewLayer(PaintingContext context, Offset offset, Matrix4 transform) {
    //创建一个 TransformLayer，保存在handle中
    _transformLayer.layer = _transformLayer.layer ?? TransformLayer();
    _transformLayer.layer!.transform = transform;

    context.pushLayer(
      _transformLayer.layer!,
      _paintChild, // 子节点绘制回调；添加完layer后，子节点会在新的layer上绘制
      offset,
      childPaintBounds: MatrixUtils.inverseTransformRect(
        transform,
        offset & size,
      ),
    );
  }

  @override
  void dispose() {
    _paintTransform = null;
    _transformLayer.layer = null;
    super.dispose();
  }

}