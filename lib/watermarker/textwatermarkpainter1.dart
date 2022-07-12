import 'package:flutter/material.dart';
import 'package:flutter_practice/watermarker/watermarkwidget.dart';

import 'dart:math' as math;

/// 文本水印画笔
class TextWaterMarkPainter1 extends WaterMarkPainter {
  TextWaterMarkPainter1({Key? key, double? rotate, EdgeInsets? padding, TextStyle? textStyle, required this.text,})
      : assert(rotate == null || rotate >= -90 && rotate <= 90),
        rotate = rotate ?? 0,
        padding = padding ?? const EdgeInsets.all(10.0),
        textStyle = textStyle ??
            const TextStyle(
              color: Color.fromARGB(20, 0, 0, 0),
              fontSize: 14,
            );

  double rotate; // 文本旋转的度数，是角度不是弧度
  TextStyle textStyle; // 文本样式
  EdgeInsets padding; // 文本的 padding
  String text; // 文本

  @override
  Size paintUnit(Canvas canvas, double devicePixelRatio) {

    double fontSize = 14.0;

    //构建文本画笔
    TextPainter painter = TextPainter(
      textDirection: TextDirection.ltr,
      textScaleFactor: devicePixelRatio,
    );
    //添加文本和样式
    painter.text = TextSpan(text: text, style: TextStyle(color: Colors.white, backgroundColor: Colors.transparent, fontSize: fontSize));
    //对文本进行布局
    painter.layout();

    //文本占用的真实宽度
    final textWidth = painter.width;
    //文本占用的真实高度
    final textHeight = painter.height;

    //...//省略应用旋转和 padding 的相关代码

    // 绘制文本
    painter.paint(canvas, Offset.zero);

    // 将弧度转化为度数
    final radians = math.pi * rotate / 180;

    //通过三角函数计算旋转后的位置和size
    final orgSin = math.sin(radians);
    final sin = orgSin.abs();
    final cos = math.cos(radians).abs();

    final width = textWidth * cos;
    final height = textWidth * sin;
    final adjustWidth = fontSize * sin;
    final adjustHeight = fontSize * cos;

    // 为什么要平移？下面解释
    if (orgSin >= 0) { // 旋转角度为正
      canvas.translate(
        adjustWidth + padding.left,
        padding.top,
      );
    } else { // 旋转角度为负
      canvas.translate(
        padding.left,
        height + padding.top,
      );
    }
    canvas.rotate(radians);
    // 绘制文本
    painter.paint(canvas, Offset.zero);
    // 返回水印单元所占的真实空间大小（需要加上padding）
    return Size(
      width + adjustWidth + padding.horizontal,
      height + adjustHeight + padding.vertical,
    );

  }

  @override
  bool shouldRepaint(TextWaterMarkPainter1 oldPainter) {
    return oldPainter.rotate != rotate ||
        oldPainter.text != text ||
        oldPainter.padding != padding ||
        oldPainter.textStyle != textStyle;
  }

}