import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/set.dart';

Set set = Set();

class Twelve extends StatelessWidget {
  const Twelve({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TwelveStateFul();
  }
}

class TwelveStateFul extends StatefulWidget {
  const TwelveStateFul({Key? key}) : super(key: key);

  @override
  State<TwelveStateFul> createState() => TwelveState();
}

class TwelveState extends State<TwelveStateFul> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('Twelve initState');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('Twelve didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant TwelveStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('Thirteen didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('Twelve setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('Twelve deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('Twelve dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: _setList(),
    );
  }

  Widget _setList() {
    // SliverFixedExtentList 是一个 Sliver，它可以生成高度相同的列表项。
    // 再次提醒，如果列表项高度相同，我们应该优先使用SliverFixedExtentList
    // 和 SliverPrototypeExtentList，如果不同，使用 SliverList.
    var fixedExtentList = SliverFixedExtentList(
      itemExtent: 50.0,
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          //创建列表项
          return Container(
            alignment: Alignment.center,
            color: Colors.lightBlue[100 * (index % 9)],
            child: Text('list item $index'),
          );
        },
        childCount: 10,
      ),
    );

    var appBarList = SliverAppBar(
      //title: const Text('Twelve Page'),
      pinned: true, // 滑动到顶端时会固定住
      //stretch: true,
      expandedHeight: 250.0,
      flexibleSpace: FlexibleSpaceBar(
        //title: const Text("FlexibleSpaceBar"),
        title: const Text('Twelve Page'),
        background: Image.network(
          'https://pic.baike.soso.com/ugc/baikepic2/0/20220228153746-316776821_jpg_1728_1080_515185.jpg/800',
          fit: BoxFit.cover,
        ),
      collapseMode: CollapseMode.parallax,
      stretchModes: const [
      StretchMode.blurBackground,
      StretchMode.zoomBackground,
      StretchMode.fadeTitle,
      ],
      ),
    );

    var paddingList = SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverGrid(
        //Grid
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, //Grid按两列显示
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 4.0,
        ),
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            //创建子widget
            return Container(
              alignment: Alignment.center,
              color: Colors.cyan[100 * (index % 9)],
              child: Text('grid item $index'),
            );
          },
          childCount: 10,
        ),
      ),
    );

    var boxAdapter = SliverToBoxAdapter( // 適配器
      child: SizedBox(
        height: 300,
        child: PageView(
          children: [
            Container(height: 100, alignment: Alignment.center, color: Colors.purpleAccent[100 * (0 % 6)], child: set.initText2('pager item 1', Colors.black, Colors.transparent, 36)),
            Container(height: 100, alignment: Alignment.center, color: Colors.purpleAccent[100 * (1 % 6)], child: set.initText2('pager item 2', Colors.black, Colors.transparent, 36)),
            Container(height: 100, alignment: Alignment.center, color: Colors.purpleAccent[100 * (2 % 6)], child: set.initText2('pager item 3', Colors.black, Colors.transparent, 36)),
            Container(height: 100, alignment: Alignment.center, color: Colors.purpleAccent[100 * (3 % 6)], child: set.initText2('pager item 4', Colors.black, Colors.transparent, 36)),
            Container(height: 100, alignment: Alignment.center, color: Colors.purpleAccent[100 * (4 % 6)], child: set.initText2('pager item 5', Colors.black, Colors.transparent, 36)),
            Container(height: 100, alignment: Alignment.center, color: Colors.purpleAccent[100 * (5 % 6)], child: set.initText2('pager item 6', Colors.black, Colors.transparent, 36)),
          ],
        ),
      ),
    );

    var prototypeList = SliverPrototypeExtentList( // 通过 prototypeItem 来传入一个原型
        prototypeItem: set.initText2('', Colors.black, Colors.transparent, 20),
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            //创建子widget
            return Container(
              height: 50,
              alignment: Alignment.center,
              color: Colors.amber[100 * (index % 9)],
              child: Text('protoType item $index'),
            );
          },
          childCount: 10,
        ),
    );

    var fillViewPortList = SliverFillViewport( // 接受一个 delegate，支持动态的加载，只不过内部的子元素会占满整个屏幕
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            //创建子widget
            return Container(
              height: 50,
              alignment: Alignment.center,
              color: Colors.red[100 * (index % 9)],
              child: Text('viewport item $index'),
            );
          },
          childCount: 10,
        ),
    );

    var opacityList = const SliverOpacity( // 透明度
      opacity: 0.5,
      sliver: SliverToBoxAdapter(
        child: FlutterLogo(
          size: 100,
        ),
      ),
    );

    var fillRemainList = const SliverFillRemaining( // 填满当前页面的剩余空间
      hasScrollBody: false, // 当前组件中是否有可滚动的组件
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );

    // 使用
    return CustomScrollView(
      slivers: [
        appBarList,
        SliverPersistentHeader(
          pinned: true,
          delegate: SliverHeaderDelegate(//有最大和最小高度
            maxHeight: 80,
            minHeight: 50,
            child: buildHeader(1),
          ),
        ),
        fixedExtentList,
        SliverPersistentHeader(
          pinned: true,
          delegate: SliverHeaderDelegate.fixedHeight( //固定高度
            height: 50,
            child: buildHeader(2),
          ),
        ),
        fixedExtentList,
        paddingList,
        prototypeList,
        fillViewPortList,
        boxAdapter,
        opacityList,
        fillRemainList,
      ],
    );
  }

  // 构建 header
  Widget buildHeader(int i) {
    return Container(
      color: Colors.lightGreen.shade200,
      alignment: Alignment.centerLeft,
      child: Text("PersistentHeader $i"),
    );
  }

}

typedef SliverHeaderBuilder = Widget Function(BuildContext context, double shrinkOffset, bool overlapsContent);

class SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  // child 为 header
  SliverHeaderDelegate({required this.maxHeight, this.minHeight = 0, required Widget child,})  : builder = ((a, b, c) => child),
        assert(minHeight <= maxHeight && minHeight >= 0);

  //最大和最小高度相同
  SliverHeaderDelegate.fixedHeight({
    required double height,
    required Widget child,
  })  : builder = ((a, b, c) => child),
        maxHeight = height,
        minHeight = height;

  //需要自定义builder时使用
  SliverHeaderDelegate.builder({
    required this.maxHeight,
    this.minHeight = 0,
    required this.builder,
  });

  final double maxHeight;
  final double minHeight;
  final SliverHeaderBuilder builder;

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
    Widget child = builder(context, shrinkOffset, overlapsContent);
    //测试代码：如果在调试模式，且子组件设置了key，则打印日志
    assert(() {
      if (child.key != null) {
        if (kDebugMode) {
          print('Twelve HeaderDelegate -> ${child.key}: shrink: $shrinkOffset，overlaps:$overlapsContent');
        }
      }
      return true;
    }());
    // 让 header 尽可能充满限制的空间；宽度为 Viewport 宽度，
    // 高度随着用户滑动在[minHeight,maxHeight]之间变化。
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverHeaderDelegate old) {
    return old.maxExtent != maxExtent || old.minExtent != minExtent;
  }
}