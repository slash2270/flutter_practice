import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/set.dart';
import 'package:flutter_practice/bean/cartbean.dart';
import 'package:flutter_practice/builder/futurebuilder1.dart';
import 'package:flutter_practice/builder/streambuilder.dart';
import 'package:flutter_practice/builder/valuelistenablebuilderwidget.dart';
import 'package:flutter_practice/viewmodel/providerdemo2.dart';

import '../tools/sharedatawidget.dart';
import '../model/cartmodel.dart';
import '../viewmodel/providermodel1.dart';
import '../viewmodel/sharedatamodel.dart';

Set set = Set();

class Ten extends StatelessWidget {
  const Ten({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: set.initText('Ten Page'),
      ),
      body: const SingleChildScrollView(
        child: (TenContent()),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}

class TenContent extends StatefulWidget {
  const TenContent({Key? key}) : super(key: key);

  @override
  State<TenContent> createState() => TenState();
}

class TenState extends State<TenContent> with WidgetsBindingObserver {
  double countShare = 0.0;
  bool isCheck = false,
      isCheckList = false,
      isSwitch = false,
      isSwitchList = false,
      isCupertino = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('$state');
  }

  @override
  void initState() {
    print('Ten initState');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    print('Ten didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant TenContent oldWidget) {
    // 元件發生變化
    print('Ten didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    print('Ten setState');
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    print('Ten deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    print('Ten dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //使用InheritedWidget中的共享数据
    return Container(
        height: 800,
        color: Colors.white,
        padding: set.initEdgeInsets(15.0, 20.0, 15.0, 20.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ChangeNotifierProvider<CartModel>(
                data: CartModel(),
                child: Builder(builder: (context) {
                  return Column(
                    children: [
                      set.initText2('自定義Provider1', Colors.green, Colors.transparent, 24),
                      Consumer<CartModel>(
                        // 重新包裝一次 讓類別有意義 而不是viewModel或provider
                          builder: (context, cart) => Text('總價: ${cart?.totalPrice}')),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Builder(builder: (context) {
                            return ElevatedButton(
                              child: const Text("添加商品"),
                              onPressed: () {
                                //给购物车中添加商品，添加后总价会更新
                                ChangeNotifierProvider.of<CartModel>(context)
                                    .add(CartBean(20.0, 1));
                              },
                            );
                          }),
                          Builder(builder: (context) {
                            return ElevatedButton(
                              child: const Text("減少商品"),
                              onPressed: () {
                                //给购物车中添加商品，添加后总价会更新
                                ChangeNotifierProvider.of<CartModel>(context).minus();
                              },
                            );
                          }),
                        ],
                      ),
                    ],
                  );
                })),
            ProviderDemo2(),
            Column(
              children: [
                set.initText2('自定義ShareDataWidget', Colors.green, Colors.transparent, 24),
                ShareDataWidget(
                  //使用ShareDataWidget
                  data: countShare,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(bottom: 0.0),
                        child: SharedDataWidget(), //子widget中依赖ShareDataWidget
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            child: const Text("Increment"),
                            //每点击一次，将count自增，然后重新build,ShareDataWidget的data将被更新
                            onPressed: () => setState(() => ++countShare),
                          ),
                          ElevatedButton(
                            child: const Text("Decrement"),
                            //每点击一次，将count自增，然后重新build,ShareDataWidget的data将被更新
                            onPressed: () => setState(() => --countShare),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                set.initText2('自定義ValueListenableBuilder', Colors.green, Colors.transparent, 24),
                const ValueListenableBuilderWidget()
              ],
            ),
            Column(
              children: [
                set.initText2('自定義FutureBuilder', Colors.green, Colors.transparent, 24),
                set.initText('delay3秒演示載資料的時間'),
                const FutureBuilderWidget1()
              ],
            ),
            Column(
              children: [
                set.initText2('自定義StreamBuilder', Colors.green, Colors.transparent, 24),
                set.initText('+1/s count > 19 == done'),
                const StreamBuilderWidget()
              ],
            ),
          ],
        ),
    );
  }
}

class Delegate extends FlowDelegate {
  EdgeInsets margin;

  Delegate({this.margin = EdgeInsets.zero});

  double width = 0;
  double height = 0;

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    //计算每一个子widget的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i)!.width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i)!.height + margin.top + margin.bottom;
        //绘制子widget(有优化)
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i)!.width + margin.left + margin.right;
      }
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    // 指定Flow的大小，简单起见我们让宽度竟可能大，但高度指定为200，
    // 实际开发中我们需要根据子元素所占用的具体宽高来设置Flow大小
    return const Size(double.infinity, 200.0);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
