import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

import 'package:flutter_practice/set.dart';


Set set = Set();

class GoWidget extends LeafRenderObjectWidget {
  const GoWidget({Key? key}) : super(key: key);

  @override
  RenderObject createRenderObject(BuildContext context) {
    // 返回Render对象
    return RenderGo();
  }
//...省略updateRenderObject函数实现
}

class RenderGo extends RenderBox {

  // 定义一个新的 layerHandle
  final layerHandle = LayerHandle<PictureLayer>();

  @override
  void performLayout() {
    //确定ChessWidget的大小
    size = constraints.constrain(
      constraints.isTight ? Size.infinite : const Size(150, 150),
    );
  }

  // 保存之前的棋盘大小
  Rect _rect = Rect.zero;
  //PictureLayer _layer = PictureLayer(Rect.zero);

  _checkIfChessboardNeedsUpdate(Rect rect) {
    // 如果绘制区域大小没发生变化，则无需重绘棋盘
    if (_rect == rect) return;

    // 绘制区域发生了变化，需要重新绘制并缓存棋盘
    _rect = rect;
    if (kDebugMode) {
      //print("GoWidget paint board");
    }

    // 新建一个PictureLayer，用于缓存棋盘的绘制结果，并添加到layer中
    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);
    set.drawChessboard(canvas, rect); //绘制棋盘
    // 将绘制产物保存在pictureLayer中
    //_layer = PictureLayer(Rect.zero)..picture = recorder.endRecording();
    layerHandle.layer = PictureLayer(Rect.zero)..picture = recorder.endRecording();

  }

  @override
  void paint(PaintingContext context, Offset offset) {
    Rect rect = offset & size;
    //检查棋盘大小是否需要变化，如果变化，则需要重新绘制棋盘并缓存
    _checkIfChessboardNeedsUpdate(rect);
    //将缓存棋盘的layer添加到context中，每次重绘都要调用，原因下面会解释
    //context.addLayer(_layer);
    context.addLayer(layerHandle.layer!);
    //再画棋子
    if (kDebugMode) {
      //print("GoWidget paint pieces");
    }
    set.drawPieces(context.canvas, rect);
  }

  @override
  void dispose() {
    //layer通过引用计数的方式来跟踪自身是否还被layerHandle持有，
    //如果不被持有则会释放资源，所以我们必须手动置空，该set操作会
    //解除layerHandle对layer的持有。
    layerHandle.layer = null;
    //layerHandle.layer!.dispose();
    //_layer.dispose();
    super.dispose();
  }

}