import 'package:flutter/material.dart';
import 'package:flutter_practice/watermarker/watermarkwidget.dart';

import 'dart:ui' as ui;

/// 文本水印画笔
class TextWaterMarkPainter2 extends WaterMarkPainter {
  TextWaterMarkPainter2({Key? key, double? rotate, EdgeInsets? padding, TextStyle? textStyle, required this.text,})
      : assert(rotate == null || rotate >= -90 && rotate <= 90),
        rotate = rotate ?? 0,
        padding = padding ?? const EdgeInsets.all(10.0),
        textStyle = textStyle ??
            const TextStyle(
              color: Color.fromARGB(20, 0, 0, 0),
              fontSize: 14,
            ),
        textDirection = TextDirection.rtl;

  double rotate; // 文本旋转的度数，是角度不是弧度
  TextStyle textStyle; // 文本样式
  EdgeInsets padding; // 文本的 padding
  String text; // 文本
  TextDirection textDirection;

  @override
  Size paintUnit(Canvas canvas, double devicePixelRatio) {

    //根据屏幕 devicePixelRatio 对文本样式中长度相关的一些值乘以devicePixelRatio
    final _textStyle = _handleTextStyle(devicePixelRatio);
    final _padding = padding * devicePixelRatio;

    //构建文本段落
    final builder = ui.ParagraphBuilder(_textStyle.getParagraphStyle(
      textDirection: textDirection,
      textAlign: TextAlign.start,
      textScaleFactor: devicePixelRatio,
    ));

    //添加要绘制的文本及样式
    builder
      ..pushStyle(_textStyle.getTextStyle()) // textStyle 为 ui.TextStyle
      ..addText(text);

    //layout 后我们才能知道文本占用的空间
    ui.Paragraph paragraph = builder.build()
      ..layout(const ui.ParagraphConstraints(width: double.infinity));

    //文本占用的真实宽度
    final textWidth = paragraph.longestLine.ceilToDouble();
    //文本占用的真实高度
    final fontSize = paragraph.height;

    //...//省略应用旋转和 padding 的相关代码

    //绘制文本
    canvas.drawParagraph(paragraph, Offset.zero);

    return Size(
      textWidth + _padding.horizontal,
      fontSize + _padding.vertical,
    );

  }

  TextStyle _handleTextStyle(double devicePixelRatio) {
    double _scale(attr) => attr == null ? 1.0 : devicePixelRatio;
    return textStyle.apply(
      decorationThicknessFactor: _scale(textStyle.decorationThickness),
      letterSpacingFactor: _scale(textStyle.letterSpacing),
      wordSpacingFactor: _scale(textStyle.wordSpacing),
      heightFactor: _scale(textStyle.height),
    );
  }

  @override
  bool shouldRepaint(TextWaterMarkPainter2 oldPainter) {
    return oldPainter.rotate != rotate ||
        oldPainter.text != text ||
        oldPainter.padding != padding ||
        oldPainter.textStyle != textStyle;
  }

}