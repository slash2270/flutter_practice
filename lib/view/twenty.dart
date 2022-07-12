// @dart = 2.9

import 'dart:async';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/set.dart';
import 'package:flutter_practice/tools/statusbarwidget.dart';
import 'package:flutter_practice/view/sixteen.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../model/eventbus.dart';
import '../value/colorvalue.dart';

Set set = Set();

class Twenty extends StatelessWidget {
  const Twenty({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SingleChildScrollView(
        child: TwentyStateFul(),
      ),
        resizeToAvoidBottomInset: true,
    );
  }
}

class TwentyStateFul extends StatefulWidget {
  const TwentyStateFul({Key key}) : super(key: key);

  @override
  State<TwentyStateFul> createState() => TwentyState();
}

class TwentyState extends State<TwentyStateFul> with WidgetsBindingObserver, TickerProviderStateMixin{

  List<Image> _listImage;
  StreamSubscription _eventBusSubscript;
  String _catchBus = '顯示EventBus';

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('Twenty initState');
    }
    getEventBus();
    _listImage = [
      Image.asset(
        'images/ellen_cute1.jpeg',
        fit: BoxFit.cover,
      ),
      Image.asset(
        'images/ellen_cute2.jpeg',
        fit: BoxFit.cover,
      ),
      Image.asset(
        'images/soldier_cute1.jpeg',
        fit: BoxFit.cover,
      ),
    ];
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('Twenty didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant TwentyStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('Twenty didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('Twenty setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('Twenty deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('Twenty dispose');
    }
    _eventBusSubscript.cancel();
    super.dispose();
  }

  void getEventBus(){
    _eventBusSubscript = EventBusUtils.getInstance().on<EventBusBroadCast>().listen((event) {
      setState(() {
        _catchBus = event.transaction;
        debugPrint('Twenty CatchBus = $_catchBus');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
            children: [
              StatusBarWidget(
                color: Colors.white,
                statusStyle: StatusStyle.LIGHT_CONTENT,
                child: Container(
                  color: Colors.green,
                  child: set.initText2('Twenty Page', Colors.white, Colors.transparent, 36),
                ),
              ),
              _getBanner(),
              set.initText2(_catchBus, Colors.black, ColorValue.transParent, 20),
              ElevatedButton(
                  child: set.initText2('發送EventBus', Colors.black, ColorValue.transParent, 18),
                  onPressed: () {
                    EventBusUtils.getInstance().fire(EventBusBroadCast('Hello World!'));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Sixteen(),
                            settings: const RouteSettings(
                              arguments: '',
                            )
                        ));
                  }),
              set.initText2('Hero 動畫', ColorValue.black, ColorValue.transParent, 20),
              Hero(
                tag: "ellen", //唯一标记，前后两个路由页Hero的tag必须相同
                child: Image.asset("images/ellen.jpeg"),
              ),
              SizedBox(
                height: 400,
                child: Center(
                child: Text('內容'))),
      ],
    );
  }

  //广告图
  _getBanner() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 200.0,
        child: Swiper(
          itemBuilder: _swiperBuilder,
          itemCount: _listImage.length,
          pagination: new SwiperPagination(
              alignment: Alignment.bottomRight,
              builder: DotSwiperPaginationBuilder(
                color: Colors.grey,
                activeColor: Colors.white,
                size: 6,
                activeSize: 6,
              )),
          scrollDirection: Axis.horizontal,
          autoplay: true,
          onTap: (index) => set.initText2('$index', Colors.black, Colors.transparent, 24)
        ));
  }

  Widget _swiperBuilder(BuildContext context, int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(10),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            child: _listImage[index]),
      ),
    );
  }

}