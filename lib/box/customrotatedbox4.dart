import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

class CustomRotatedBox4 extends SingleChildRenderObjectWidget {
  const CustomRotatedBox4 ({Key? key, Widget? child}) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return CustomRenderRotatedBox4();
  }
}

class CustomRenderRotatedBox4 extends RenderBox with RenderObjectWithChildMixin<RenderBox> {

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
        needCompositing(), //子树是否存在绘制边界节点
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

  //子树中递归查找是否存在绘制边界
  needCompositing() {
    bool result = false;
    _visit(RenderObject child) {
      // 修改判断条件改为
      if (child.isRepaintBoundary || child.alwaysNeedsCompositing) {
        result = true;
        return ;
      } else {
        //递归查找
        child.visitChildren(_visit);
      }
    }
    //遍历子节点
    visitChildren(_visit);
    return result;
  }

  @override
  void dispose() {
    _paintTransform = null;
    _transformLayer.layer = null;
    super.dispose();
  }

}