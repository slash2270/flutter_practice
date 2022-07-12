import 'package:flutter_practice/bean/fivebean.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../utils/constants.dart';

class DBHelper {

  static final DBHelper _instance = DBHelper.internal();

  factory DBHelper() => _instance;

  static Database? _db;

  DBHelper.internal();

  var dbClient;

  dynamic d;

  int transaction = 0;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    // 获取数据库文件的存储路径
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'Demo.db');

    // 根据数据库文件路径和数据库版本号创建数据库表
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    //here we execute a query to drop the table if exists which is called "tableName"
    //and could be given as method's input parameter too
    await db.execute("DROP TABLE IF EXISTS ${Constants.tableProduct}");

    //and finally here we recreate our beloved "tableName" again which needs
    //some columns initialization
    await db.execute('''
          CREATE TABLE ${Constants.tableProduct} (
            ${Constants.columnId} INTEGER PRIMARY KEY,
            ${Constants.columnName} TEXT,
            ${Constants.columnType} TEXT,
            ${Constants.columnSize} TEXT,
            ${Constants.columnProduct} TEXT,
            ${Constants.columnPrice} TEXT,
            ${Constants.columnCount} TEXT)
          ''');
  }

  //打开DB
  open() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'Demo.db');
    await openDatabase(path);
  }

  // 插入
  Future<int> insertBean(String tableName, FiveBean bean) async {
    dbClient = await db;
    await dbClient.transaction((txn) async {
      transaction =  await txn.insert(tableName, bean.toMap());
    });
    return transaction;
    //await dbClient.insert(tableName, bean.toMap());
    //return await dbClient.insert(tableName, bean.toMap());
  }

  // 查詢
  Future<List<FiveBean>> selectBean(String tableName, List<String> listColumns) async {
    dbClient = await db;
    List<Map> maps = await dbClient.query(tableName, columns: listColumns);
    List<FiveBean> listBean = [];

    switch(tableName){
      case Constants.tableProduct:
        for (int i = 0; i < maps.length; i++) {
          listBean.add(FiveBean.fromMap(maps[i]));
        }
        break;
    }

    return Future.value(listBean);
  }

  // 根據params查找
  Future<dynamic> selectParamBean(String tableName, List listColumns, String key, List args) async {
    dbClient = await db;
    List<Map> maps = await dbClient.query(tableName, columns: listColumns, where: key, whereArgs: args);
    switch(tableName){
      case Constants.tableProduct:
        d = FiveBean.fromMap(maps.first);
    }
    return Future.value(d);
  }

  Future<FiveBean> selectFiveBean(String tableName, List listColumns, String key, List args) async {
    dbClient = await db;
    List<Map> maps = await dbClient.query(tableName, columns: listColumns, where: key, whereArgs: args);
    return FiveBean.fromMap(maps.first);
  }

  // 刪除
  Future<int> delete(String tableName, String key, List args) async {
    dbClient = await db;
    await dbClient.transaction((txn) async {
      transaction =  await txn.delete(tableName, where: key, whereArgs: args);
    });
    return transaction;
  }

  Future<int> deleteTable() async {
    dbClient = await db;
    return await dbClient.rawDelete("Delete * from ${Constants.tableProduct}");
  }

  // 更新
  Future<int> update(String tableName, List list, String key, List args) async {
    dbClient = await db;
    int future = 0;
    switch(tableName){
      case Constants.tableProduct:
        for(var bean in list){
          FiveBean fiveBean = bean as FiveBean;
          future = await dbClient.update(tableName, fiveBean.toMap(), where: key, whereArgs: args);
          /*if (kDebugMode) {
            print('Five update ${fiveBean.id}');
          }*/
        }
        break;
    }
    return future;
  }

  // 關閉
  close() async {
    dbClient = await db;
    await dbClient.close();
  }

}