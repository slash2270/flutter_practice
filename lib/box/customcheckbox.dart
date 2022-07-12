import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

class CustomCheckbox extends LeafRenderObjectWidget {
  const CustomCheckbox({
    Key? key,
    this.strokeWidth = 2.0,
    this.value = false,
    this.strokeColor = Colors.white,
    this.fillColor = Colors.blue,
    this.radius = 2.0,
    this.onChanged,
  }) : super(key: key);

  final double strokeWidth; // “勾”的线条宽度
  final Color strokeColor; // “勾”的线条宽度
  final Color? fillColor; // 填充颜色
  final bool value; //选中状态
  final double radius; // 圆角
  final ValueChanged<bool>? onChanged; // 选中状态发生改变后的回调

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCustomCheckbox(
      strokeWidth,
      strokeColor,
      fillColor ?? Theme.of(context).primaryColor,
      value,
      radius,
      onChanged,
    );
  }

  @override
  void updateRenderObject(context, RenderCustomCheckbox renderObject) {
    if (renderObject.value != value) {
      renderObject.animationStatus =
      value ? AnimationStatus.forward : AnimationStatus.reverse;
    }
    renderObject
      ..strokeWidth = strokeWidth
      ..strokeColor = strokeColor
      ..fillColor = fillColor ?? Theme.of(context).primaryColor
      ..radius = radius
      ..value = value
      ..onChanged = onChanged;
  }
}

class RenderCustomCheckbox extends RenderBox {
  bool value;
  int pointerId = -1;
  double strokeWidth;
  Color strokeColor;
  Color fillColor;
  double radius;
  ValueChanged<bool>? onChanged;

  // 下面的属性用于调度动画
  double progress = 0; // 动画当前进度
  int? _lastTimeStamp;//上一次绘制的时间
  //动画执行时长
  Duration get duration => const Duration(milliseconds: 150);
  //动画当前状态
  AnimationStatus _animationStatus = AnimationStatus.completed;
  set animationStatus(AnimationStatus v) {
    if (_animationStatus != v) {
      markNeedsPaint();
    }
    _animationStatus = v;
  }

  //背景动画时长占比（背景动画要在前40%的时间内执行完毕，之后执行打勾动画）
  final double bgAnimationInterval = .4;

  RenderCustomCheckbox(this.strokeWidth, this.strokeColor, this.fillColor,
      this.value, this.radius, this.onChanged)
      : progress = value ? 1 : 0;

  @override
  void performLayout() { //布局
    /**
     * 实现布局算法 为了使用户可以自定义宽高，我们的布局策略是：如果父组件指定了固定宽高，则使用父组件指定的，否则宽高默认置为 25：
     */
    size = constraints.constrain(
      constraints.isTight ? Size.infinite : const Size(25, 25),
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    Rect rect = offset & size;
    // 将绘制分为背景（矩形）和 前景（打勾）两部分，先画背景，再绘制'勾'
    _drawBackground(context, rect);
    _drawCheckMark(context, rect);
    // 调度动画
    _scheduleAnimation();
  }

  // 画背景
  void _drawBackground(PaintingContext context, Rect rect) {
    /**
     * 绘制背景
        当状态切换为选中状态时，将矩形逐渐从边缘向中心收缩填充，直到填满 Checkbox 区域。
        当状态切换为未选中状态时，填充从中间逐渐向边缘消散，直到只剩一个边框为止。
        实现的思路是先将整个背景矩形区域全部填充满蓝色，然后在上面绘制一个白色背景的矩形，根据动画进度来动态改变白色矩形区域大小即可。幸运的是 Canvas API 中已经帮助我们实现了我们期望的功能，drawDRRect 他可以指定内外两个矩形，然后画出不相交的部分，并且可以指定圆角，下面是具体实现
     */
    Color color = value ? fillColor : Colors.grey;
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill //填充
      ..strokeWidth
      ..color = color;

    // 我们需要算出每一帧里面矩形的大小，为此我们可以直接根据矩形插值方法来确定里面矩形
    final outer = RRect.fromRectXY(rect, radius, radius);
    var rects = [
      rect.inflate(-strokeWidth),
      Rect.fromCenter(center: rect.center, width: 0, height: 0)
    ];
    // 根据动画执行进度调整来确定里面矩形在每一帧的大小
    var rectProgress = Rect.lerp(
      rects[0],
      rects[1],
      // 背景动画的执行时长是前 40% 的时间
      min(progress, bgAnimationInterval) / bgAnimationInterval,
    )!;
    final inner = RRect.fromRectXY(rectProgress, 0, 0);
    // 绘制
    context.canvas.drawDRRect(outer, inner, paint);
  }

  //画 "勾"
  void _drawCheckMark(PaintingContext context, Rect rect) {
    /**
     * 绘制前景
        前景是一个"勾"，它有三个点的连线构成，为了简单起见，我们将起始点和中点拐点的位置根据 Checkbox 的大小算出固定的坐标，然后我们在每一帧中动态调整第三个点的位置就可以实现打勾动画
     */
    // 在画好背景后再画前景
    if (progress > bgAnimationInterval) {

      //确定中间拐点位置
      final secondOffset = Offset(
        rect.left + rect.width / 2.5,
        rect.bottom - rect.height / 4,
      );
      // 第三个点的位置
      final lastOffset = Offset(
        rect.right - rect.width / 6,
        rect.top + rect.height / 4,
      );

      // 我们只对第三个点的位置做插值
      final _lastOffset = Offset.lerp(
        secondOffset,
        lastOffset,
        (progress - bgAnimationInterval) / (1 - bgAnimationInterval),
      )!;

      // 将三个点连起来
      final path = Path()
        ..moveTo(rect.left + rect.width / 7, rect.top + rect.height / 2)
        ..lineTo(secondOffset.dx, secondOffset.dy)
        ..lineTo(_lastOffset.dx, _lastOffset.dy);

      final paint = Paint()
        ..isAntiAlias = true
        ..style = PaintingStyle.stroke
        ..color = strokeColor
        ..strokeWidth = strokeWidth;

      context.canvas.drawPath(path, paint..style = PaintingStyle.stroke);
    }
  }

  //调度动画
  void _scheduleAnimation() {
    /**
     * 我们的思路是：在一帧绘制结束后判断动画是否结束，如果动画未结束，则将将当前组件标记为”需要重绘“，然后等待下一帧即可
     */
    if (_animationStatus != AnimationStatus.completed) {
      // 需要在Flutter 当前frame 结束之前再执行，因为不能在绘制过程中又将组件标记为需要重绘
      SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
        if (_lastTimeStamp != null) {
          double delta = (timeStamp.inMilliseconds - _lastTimeStamp!) / duration.inMilliseconds;
          // 如果是反向动画，则 progress值要逐渐减小
          if (_animationStatus == AnimationStatus.reverse) {
            delta = -delta;
          }
          //更新动画进度
          progress = progress + delta;

          if (progress >= 1 || progress <= 0) {
            //动画执行结束
            _animationStatus = AnimationStatus.completed;
            progress = progress.clamp(0, 1);
          }
        }
        //标记为需要重绘
        markNeedsPaint();
        _lastTimeStamp = timeStamp.inMilliseconds;
      });
    } else {
      _lastTimeStamp = null;
    }
  }

  // 必须置为true，否则不可以响应事件
  @override
  bool hitTestSelf(Offset position) => true;

  // 只有通过点击测试的组件才会调用本方法
  @override
  void handleEvent(PointerEvent event, covariant BoxHitTestEntry entry) {
    if (event.down) {
      pointerId = event.pointer;
    } else if (pointerId == event.pointer) {
      // 判断手指抬起时是在组件范围内的话才触发onChange
      if(size.contains(event.localPosition)) {
        onChanged?.call(!value);
      }
    }
  }

}