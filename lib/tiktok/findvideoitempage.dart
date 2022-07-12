import 'package:flutter/material.dart';
import 'package:flutter_practice/tiktok/videomodel.dart';
import 'package:video_player/video_player.dart';

///播放视频的页面
class FindVideoItemPage extends StatefulWidget {
  final String tabValue;
  final VideoModel videoModel;
  FindVideoItemPage(this.tabValue, this.videoModel);

  @override
  State<StatefulWidget> createState() => FindVideoItemPageState();
}

class FindVideoItemPageState extends State<FindVideoItemPage> {
  ///创建视频播放控制 器
  late VideoPlayerController videoPlayerController;
  ///控制更新视频加载初始化完成状态更新
  late Future videoPlayFuture;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videoModel.videoUrl);
    videoPlayFuture = videoPlayerController.initialize().then((_) {
      ///视频初始完成后
      ///调用播放
      videoPlayerController.play();
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ///播放视频
        buildVideoWidget(),
        ///控制播放视频按钮
        //buildControllWidget(),
        ///底部区域的视频介绍
        //buildBottmFlagWidget(),
        ///右侧的用户信息按钮区域
        //buildRightUserWidget(),
      ],
    );
  }

  ///播放视频
  buildVideoWidget() {
    return FutureBuilder(
      future: videoPlayFuture,
      builder: (BuildContext context, value) {
        if (value.connectionState == ConnectionState.done) {
          ///点击事件
          return InkWell(
            onTap: () {
              if (videoPlayerController.value.isInitialized) {
                /// 视频已初始化
                if (videoPlayerController.value.isPlaying) {
                  /// 正播放 --- 暂停
                  videoPlayerController.pause();
                } else {
                  ///暂停 ----播放
                  videoPlayerController.play();
                }
                setState(() {});
              } else {
                ///未初始化
                videoPlayerController.initialize().then((_) {
                  videoPlayerController.play();
                  setState(() {});
                });
              }
            },
            ///居中
            child: Center(
              /// AspectRatio 组件用来设定子组件宽高比
              child: AspectRatio(
                ///设置视频的大小 宽高比。长宽比表示为宽高比。例如，16:9宽高比的值为16.0/9.0
                aspectRatio: 5.0/8.0,
                ///播放视频的组件
                child: VideoPlayer(videoPlayerController),
              ),
            ),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            ///圆形加载进度
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}