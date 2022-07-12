import 'package:flutter/material.dart';
import 'package:flutter_practice/watermarker/textwatermarkpainter1.dart';
import 'package:flutter_practice/watermarker/textwatermarkpainter2.dart';
import 'package:flutter_practice/watermarker/watermarkwidget.dart';

import 'dart:math' as math;

/// 交错文本水印画笔，可以在水平或垂直方向上组合两个文本水印，
/// 通过给第二个文本水印指定不同的 padding 来实现交错效果。
class TextWaterMarkPainterStagger2 extends WaterMarkPainter {
  TextWaterMarkPainterStagger2({
    required this.text,
    this.padding1,
    this.padding2 = const EdgeInsets.all(30),
    this.rotate,
    this.textStyle,
    this.staggerAxis = Axis.vertical,
    String? text2,
  }) : text2 = text2 ?? text;
  //第一个文本
  String text;
  //第二个文本，如果不指定则和第二个文本相同
  String text2;
  //我们限制两个文本的旋转角度和文本样式必须相同，否则显得太乱了
  double? rotate;
  TextStyle? textStyle;
  //第一个文本的padding
  EdgeInsets? padding1;
  //第二个文本的padding
  EdgeInsets padding2;
  // 两个文本沿哪个方向排列
  Axis staggerAxis;

  @override
  Size paintUnit(Canvas canvas, double devicePixelRatio) {
    final TextWaterMarkPainter2 painter = TextWaterMarkPainter2(
      text: text,
      padding: padding1,
      rotate: rotate ?? 0,
      textStyle: textStyle
    );
    // 绘制第一个文本水印前保存画布状态，因为在绘制过程中可能会平移或旋转画布
    canvas.save();
    // 绘制第一个文本水印
    final size1 = painter.paintUnit(canvas, devicePixelRatio);
    // 绘制完毕后恢复画布状态。
    canvas.restore();
    // 确定交错方向
    bool vertical = staggerAxis == Axis.vertical;
    // 将 Canvas平移至第二个文本水印的起始绘制点
    canvas.translate(vertical ? 0 : size1.width, vertical ? size1.height : 0);
    // 设置第二个文本水印的 padding 和 text2
    painter
      ..padding = padding2
      ..text = text2;
    // 绘制第二个文本水印
    final size2 = painter.paintUnit(canvas, devicePixelRatio);
    // 返回两个文本水印所占用的总大小
    return Size(
      vertical ? math.max(size1.width, size2.width) : size1.width + size2.width,
      vertical
          ? size1.height + size2.height
          : math.max(size1.height, size2.height),
    );
  }

  @override
  bool shouldRepaint(TextWaterMarkPainterStagger2 oldPainter) {
    return oldPainter.rotate != rotate ||
        oldPainter.text != text ||
        oldPainter.text2 != text2 ||
        oldPainter.staggerAxis != staggerAxis ||
        oldPainter.padding1 != padding1 ||
        oldPainter.padding2 != padding2 ||
        //oldPainter.textDirection != textDirection ||
        oldPainter.textStyle != textStyle;
  }
}