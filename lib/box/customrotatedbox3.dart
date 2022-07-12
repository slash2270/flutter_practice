import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

class CustomRotatedBox3 extends SingleChildRenderObjectWidget {
  const CustomRotatedBox3 ({Key? key, Widget? child}) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return CustomRenderRotatedBox3();
  }
}

class CustomRenderRotatedBox3 extends RenderBox with RenderObjectWithChildMixin<RenderBox> {

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
      context.pushTransform(
        child!.isRepaintBoundary,
        offset,
        _paintTransform!,
        _paintChild,
        oldLayer: _transformLayer.layer,
      );
    } else {
      _transformLayer.layer = null;
    }
  }

  // 子节点绘制回调
  void _paintChild(PaintingContext context, Offset offset) {
    context.paintChild(child!, offset);
  }

  @override
  void dispose() {
    _paintTransform = null;
    _transformLayer.layer = null;
    super.dispose();
  }

}