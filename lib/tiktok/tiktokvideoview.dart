import 'package:flutter/material.dart';
import 'package:flutter_practice/tiktok/videomodel.dart';

import 'findvideoitempage.dart';

class TikTokVideoView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TikTokVideoViewState();
  }
}

class TikTokVideoViewState extends State<TikTokVideoView> with SingleTickerProviderStateMixin {

  List<String> tabTextList = ["關注", "推薦"];
  List<Tab> tabWidgetList = [];
  late TabController tabController;

  ///推荐模拟数据
  List <VideoModel> videoList =[];
  ///关注模拟数据
  List <VideoModel> videoList2 =[];

  @override
  void initState() {
    super.initState();
    for (var value in tabTextList) {
      tabWidgetList.add(Tab(
        text: "$value",
      ));
    }
    tabController = new TabController(length: tabTextList.length, vsync: this);
    _initViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return buildRootBody();
  }

  _initViewModel() {
    ///创建模拟数据
    VideoModel videoModel = VideoModel(videoUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4");
    for (int i = 0; i < 10; i++) {
      videoModel.videoName = "推薦測試數據$i";
      videoModel.likeCount = i * 22;
      if (i % 3 == 0) {
        videoModel.isAttention = true;
        videoModel.isLike = true;
      } else {
        videoModel.isAttention = false;
        videoModel.isLike = false;
      }
      videoModel.videoImage ="";
      videoModel.videoUrl ="";
      videoList.add(videoModel);
    }

    for (int i = 0; i < 3; i++) {
      videoModel.videoName = "關注測試數據$i";
      videoModel.likeCount = i * 22;
      videoModel.isAttention = true;
      if (i % 3 == 0) {
        videoModel.isLike = true;
      } else {
        videoModel.isLike = false;
      }
      videoModel.videoImage ="";
      videoModel.videoUrl ="";
      videoList2.add(videoModel);
    }
  }

  Widget buildRootBody() {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              color: Colors.black,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 15,
            bottom: 0,
            child: buildTableViewWidget(),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: buildTableViewItemWidget('推薦'),
          ),
        ],
      ),
    );
  }
  ///构建 TabBarView
  buildTableViewWidget() {
    return TabBarView(
      controller: tabController,
      children: tabTextList
          .map((value) => Container(
        alignment: Alignment.topCenter,
        child: Text("$value",style: TextStyle(color: Colors.white),),
      )).toList(),
    );
  }
  /*///构建顶部标签部分
  buildTabBarWidget() {
    return Container(
      ///对齐在顶部中间
      alignment: Alignment.topCenter,
      child: TabBar(
        controller: tabController,
        tabs: tabWidgetList,
        ///指示器的颜色
        indicatorColor: Colors.white,
        ///指示器的高度
        indicatorWeight: 2.0,
        isScrollable: true,
        ///指示器的宽度与文字对齐
        indicatorSize: TabBarIndicatorSize.label,
      ),
    );
  }*/
  /// 用来创建上下滑动的页面
  Widget buildTableViewItemWidget(String value) {
    List<VideoModel> list =[];
    if(value == "推薦") {
      list= videoList;
    }else{
      list = videoList2;
    }
    return PageView.builder(
        itemCount: list.length, /// PageView中 子条目的个数
        scrollDirection: Axis.vertical, /// 上下滑动
        itemBuilder: (BuildContext context, int index) {
          return buildPageViewItemWidget(value, VideoModel(videoUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"));
        }
    );
  }

  buildPageViewItemWidget(String value, VideoModel videoModel) {
    return FindVideoItemPage(value, videoModel);
  }

}