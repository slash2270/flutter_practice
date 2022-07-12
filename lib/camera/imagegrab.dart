import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ImageGrab extends SingleChildRenderObjectWidget {
  final Function(ByteData) onImageGrab;

  ImageGrab({Key? key, required Widget child, required this.onImageGrab}) : super(key: key, child: child);

  @override
  RenderImageGrab createRenderObject(BuildContext context) => RenderImageGrab(onImageGrab: onImageGrab);
}

class RenderImageGrab extends RenderProxyBox {
  final Function(ByteData) onImageGrab;
  bool? imageGrabbed;

  RenderImageGrab({required this.onImageGrab, this.imageGrabbed});

  @override
  bool get isRepaintBoundary => true;

  @override
  void paint(PaintingContext context, Offset offset) {
    print('RenderImageGrab Size: $size');
    super.paint(context, offset);
    imageGrabbed ??= grabImage();
  }

  bool grabImage() {
    (layer as OffsetLayer)
        .toImage(Offset.zero & size)
        .then((image) => image.toByteData(format: ImageByteFormat.png));
    //.then(onImageGrab);
    return true;
  }
}