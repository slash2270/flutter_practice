import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/bean/fivebean.dart';
import 'package:flutter_practice/database/dbhelper.dart';
import 'package:flutter_practice/set.dart';

import 'package:flutter_practice/value/colorvalue.dart';

import '../utils/constants.dart';

Set set = Set();

class Five extends StatelessWidget {
  const Five({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*获取传递过来的参数*/
    Object? title = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: set.initText(title.toString()),
        ),
        body: const FiveStateFul());
  }
}

class FiveStateFul extends StatefulWidget {
  const FiveStateFul({Key? key}) : super(key: key);

  @override
  State<FiveStateFul> createState() => FiveState();
}

class FiveState extends State<FiveStateFul> {
  late var result;
  late Widget widgetResult;
  late FiveBean bean;
  late List params;
  late List columns;
  late List<FiveBean> beans;
  late String key;
  late String text;

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('initState Five');
    }
    bean = FiveBean(0, "", "", "", "", "", "");
    beans = [];
    params = [];
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('didChangeDependencies Five');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant FiveStateFul oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('didUpdateWidget Five');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      //print('setState Five');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('deactivate Five');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('dispose Five');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: RaisedButton(
                      child: set.initText('單筆增加'), onPressed: insertOne),
                ),
                Expanded(
                  flex: 1,
                  child: RaisedButton(
                      child: set.initText('多筆增加'), onPressed: insertData),
                ),
                Expanded(
                  flex: 1,
                  child: RaisedButton(
                      child: set.initText('單筆刪除'), onPressed: deleteOne),
                ),
                Expanded(
                  flex: 1,
                  child: RaisedButton(
                      child: set.initText('多筆刪除'), onPressed: deleteData),
                ),
                Expanded(
                  flex: 1,
                  child: RaisedButton(
                      child: set.initText('刪除表單'), onPressed: deleteTable),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 15,
            child: Row(
              children: [
              Expanded(
              flex: 1,
              child: Container(
                color: Colors.white,
                padding: set.initEdgeInsets(15.0, 20.0, 15.0, 20.0),
                child: ListView.builder(
                  primary: true,
                  itemCount: beans.length,
                  itemBuilder: (context, index) {
                    selectData();
                    text = '${beans[index].id}\n${beans[index].name} ${beans[index].type} ${beans[index].size}\n${beans[index].product} ${beans[index].price} ${beans[index].count}';
                    return ListTile(
                      leading: const Icon(Icons.event_seat),
                      title: Text(text,
                        maxLines: 5,
                        style: TextStyle(
                          color: ColorValue.blue,
                          backgroundColor: ColorValue.transParent,
                          fontSize: 16,
                        ),
                      ),
                      //subtitle: set.initText2(product, ColorValue.blue, ColorValue.transParent, 16),
                    );
                  },
                ),
              ),
            ),
            /*Expanded(
              flex: 1,
              child: Container(
                color: Colors.white,
                padding: set.initEdgeInsets(15.0, 20.0, 15.0, 20.0),
                child:
                GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      //mainAxisSpacing: 5,
                      crossAxisSpacing: 30,
                      childAspectRatio: 0.5,
                    ),
                    itemCount: beans.length,
                    itemBuilder: (BuildContext context, int index) {
                      text = '${beans[index].id}\n${beans[index].name} ${beans[index].type} ${beans[index].size}\n${beans[index].product} ${beans[index].price} ${beans[index].count}';
                      selectData();
                      return Text(text, maxLines: 5, style: TextStyle(color: ColorValue.blue, backgroundColor: ColorValue.transParent, fontSize: 16,),
                      );
                    }
                  /*GridView.count(
                        primary: false,
                        padding: set.initEdgeInsets(10.0, 10.0, 10.0, 10.0),
                        mainAxisSpacing: 8.0,//竖向间距
                        crossAxisCount: 2,//横向Item的个数
                        crossAxisSpacing: 8.0,//横向间距
                        children: gridTileList(beans.length)
                    ),*/
                ),
              ),
            ),*/
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: RaisedButton(
                      child: set.initText('多筆查詢'), onPressed: selectData),
                ),
                Expanded(
                  flex: 1,
                  child: RaisedButton(
                      child: set.initText('單筆查詢'), onPressed: selectOne),
                ),
                Expanded(
                  flex: 1,
                  child: RaisedButton(
                      child: set.initText('多筆更新'), onPressed: updateData),
                ),
                Expanded(
                  flex: 1,
                  child: RaisedButton(
                      child: set.initText('單筆更新'), onPressed: updateOne),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> gridTileList(int length) {
    selectData();
    List<Widget> listWidget = [];
    for (int i = 0; i < length; i++) {
      listWidget.add(getItemWidget());
    }
    return listWidget;
  }

  String url = "https://pic.baike.soso.com/ugc/baikepic2/0/20220228153746-316776821_jpg_1728_1080_515185.jpg/800";
  Widget getItemWidget() {//BoxFit 可设置展示图片时 的填充方式
    return Image(image: NetworkImage(url), fit: BoxFit.cover);
  }

  void insertOne() async {
    //if (kDebugMode) {
      //print('Five InsertOne1 ${beans.length}');
      await DBHelper.internal().open();
      if (beans.isEmpty) {
        bean = FiveBean(1, "名稱", "款式", "尺寸", "產品", "價格", "數量");
        DBHelper.internal().insertBean(Constants.tableProduct, bean);
        selectOne();
      } else {
        bean = FiveBean(beans.length + 1, "名稱", "款式", "尺寸", "產品", "價格", "數量");
        DBHelper.internal().insertBean(Constants.tableProduct, bean);
      }
      beans.add(bean);
      //print('Five InsertOne2 ${beans.length}');
    //}
  }

  void insertData() async {
    //if (kDebugMode) {
      //print('Five InsertData1 ${beans.length}');
      await DBHelper.internal().open();
      List<FiveBean> listBean = [];
      for (int i = beans.length + 1; i < (beans.length * 2) + 1; i++) {
        bean = FiveBean(i, "名稱", "款式", "尺寸", "產品", "價格", "數量");
        listBean.add(bean);
        DBHelper.internal().insertBean(Constants.tableProduct, bean);
      }
      beans = listBean;
      //print('Five InsertData2 ${beans.length}');
    //}
  }

  void deleteOne() async {
    //if (kDebugMode) {
      //print('Five deleteOne1 ${beans.length}');
      await DBHelper.internal().open();
      key = '${Constants.columnId} = ?';
      params = [beans.length];
      await DBHelper.internal().delete(Constants.tableProduct, key, params);
      beans.removeAt(beans.length - 1);
      //print('Five deleteOne2 ${beans.length}');
    //}
  }

  void deleteData() async {
    if (kDebugMode) {
      print('Five deleteData1 ${beans.length}');
      await DBHelper.internal().open();
      key = '${Constants.columnId} = ?';
      for (int i = 0; i < beans.length; i++) {
        bean = beans[i];
        params = [bean.id];
        await DBHelper.internal().delete(Constants.tableProduct, key, params);
      }
      //beans.clear();
      print('Five deleteData2 ${beans.length}');
    }
  }

  void deleteTable() async {
    await DBHelper.internal().open();
    DBHelper.internal().deleteTable();
    //await DBHelper.internal().close();
  }

  void selectData() async {
    //if (kDebugMode) {
      //print('Five selectData1 ${beans.length}');
      await DBHelper.internal().open();
      beans = await DBHelper.internal().selectBean(Constants.tableProduct, Constants.listColumnProduct);
      setState(() {
        for (int i = 0; i < beans.length; i++) {
          text = '${beans[i].id}\n${beans[i].name} ${beans[i].type} ${beans[i].size}\n${beans[i].product} ${beans[i].price} ${beans[i].count}';
        }
      });
      //print('Five selectData2 ${beans.length}');
    //}
  }

  void selectOne() async {
    //if (kDebugMode) {
      //print('Five selectOne1 ${beans.length}');
      await DBHelper.internal().open();
      params = [beans.length];
      columns = Constants.listColumnProduct;
      key = '${Constants.columnId} = ?';
      bean = await DBHelper.internal().selectFiveBean(Constants.tableProduct, columns, key, params);
      setState(() {
        text = '${bean.id}\n${bean.name} ${bean.type} ${bean.size}\n${bean.product} ${bean.price} ${bean.count}';
      });
      //print('Five selectOne2 ${beans.length}');
    //}
  }

  void updateOne() async {
    await DBHelper.internal().open();
    key = '${Constants.columnId} = ?';
    params = [beans.length];
    beans = [
      FiveBean(beans.length, 'hello', 'hello', 'hello', 'hello', 'hello', 'hello')
    ];
    await DBHelper.internal().update(Constants.tableProduct, beans, key, params);
  }

  void updateData() async {
    await DBHelper.internal().open();
    key = '${Constants.columnId} = ?';
    for (int i = 0; i < beans.length + 1; i++) {
      beans = [
        FiveBean(i, 'hi', 'hi', 'hi', 'hi', 'hi', 'hi')
      ];
      params = [i];
      await DBHelper.internal().update(Constants.tableProduct, beans, key, params);
    }
  }
}
