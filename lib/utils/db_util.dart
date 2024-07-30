
import 'package:flutter/cupertino.dart';
import 'package:flutter_d0601/page/home/discover/model/friend_entity.dart';
import 'package:flutter_d0601/page/home/discover/model/other_data_entity.dart';
import 'package:flutter_d0601/utils/log_util.dart';
import 'package:sqflite/sqflite.dart';

import '../common/constants.dart';

// //用户表
// class TableUser{
//   static String tableUser = 'Friend'; //好友表名
//   static String columnId = 'userId'; //用户id
//   static String columnRyUserId = 'ryUserId'; //用户融云id
//   static String columnName = 'nickname'; //用户昵称
//   static String columnUserPic = 'userPic'; //用户头像
// }
class Tables{
  /// 好友表
  static String friendTab='Friend';
  /// 聊天记录
  static String chatRecord='ChatRecord';
  /// 其他数据表
  static String otherDataTab='OtherData';
  /// 创建好友表
  static String createFriendTab='CREATE TABLE if not exists $friendTab (id INTEGER PRIMARY KEY,landerUID TEXT,userId TEXT,appId TEXT, nickname TEXT, message TEXT, targetId TEXT, '
      'portrait TEXT, alias TEXT, extra TEXT, messageType INTEGER,conversationType INTEGER, '
      'receivedTime INTEGER, sentTime INTEGER, unreadCount INTEGER,offLine INTEGER,top INTEGER)';
  /// 创建聊天记录表
  static String createChatRecord='CREATE TABLE if not exists $chatRecord (id INTEGER PRIMARY KEY,senderId TEXT,senderUid TEXT,senderAppId TEXT,receiveId TEXT,receiveUid TEXT,'
      'messageId INTEGER,messageType INTEGER,unRead INTEGER,senderHeadImg TEXT,senderNickName TEXT, extra TEXT,content TEXT,sentTime INTEGER)';
  /// 创建其他数据表
  static String createOtherData='CREATE TABLE if not exists $otherDataTab (landerUID TEXT,uid TEXT,userId TEXT,saveTime INTEGER, type INTEGER)';

}
class DBService{
  DBService._privateConstructor();
  static DBService? _dbService;

  static DBService getInstance() {
    if (_dbService == null) {
      _dbService = DBService._privateConstructor();
      _dbService!.initDB();
    }
    return _dbService!;
  }
   String tag='【${Constants.appTitle}_database】';
   String databasePath='';
   Database? database;

  /// 创建数据库及创建表
   Future<bool> initDB()async{
    if(database!=null&&database!.isOpen) return true;
    // Get a location using getDatabasesPath
    var path = await getDatabasesPath();
    databasePath ='$path/seek.db';
    debugPrint('我的数据地址$path ${_dbService.hashCode} $databasePath');
// Delete the database
//     await deleteDatabase(databasePath);

    await database?.close();
// open the database
    database = await openDatabase(
        readOnly: false,      //   是否只读
        singleInstance: true, //   是否单例
        databasePath, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(Tables.createFriendTab);
          await db.execute(Tables.createChatRecord);
          await db.execute(Tables.createOtherData);
          // num REAL
        });

    //检查需要生成的表
    List<String> noCreateTables =  await getNoCreateTables();
    LogUtil.logUtil("创建数据库及创建表:$noCreateTables",tag: tag);
    return true;
  }

  /// 检查数据库中是否有所有有表,返回需要创建的表
   Future<List<String>> getNoCreateTables() async {
    //已经存在的表
    List<String> existingTables = <String>[];
    //要创建的表
    // List<String> createTables = <String>[];
    List tableMaps = await database!.rawQuery('SELECT name FROM sqlite_master WHERE type = "table"');
    for (var item in tableMaps) {
      existingTables.add(item['name']);
    }
    // LogUtil.logUtil("统计已创建的表:$existingTables",tag: tag);
    return existingTables;
  }

}
class DBUtil<T>{
  T? model;
  static String tag='【${Constants.appTitle}_database】';
  // /// 插入当前服务器的全部用户数据
  // static Future insertAll(List<OtherData> otherList) async {
  //   // await database?.transaction((txn) async {
  //   //   Batch batch=txn!.batch();//批处理 Batch
  //   // });
  //   Batch batch=database!.batch();//批处理 Batch
  //   for (var element in otherList) {
  //     //// 批处理SQL语句 往Batch中添加语句 但是这些语句并不会执行 需要调用commit方法 然后一次性执行
  //     batch.insert("OtherData",element.toJson(),
  //         // 插入冲突策略，新的替换旧的
  //         conflictAlgorithm: ConflictAlgorithm.replace);
  //   }
  //  List<Object?> list= await batch.commit(noResult: true,continueOnError: true);
  //
  //   LogUtil.logUtil("批量插入",tag: tag);
  //   LogUtil.logInfo(list);
  // }
  // /// 查询所有记录 Get the records
  // static Future<List<OtherData>> selectOtherDataRecord()async{
  //   List<Map<String,dynamic>> list = await database!.rawQuery('SELECT * FROM OtherData WHERE landerUID=?',[Constants.loginData!.userInfo!.id.toString()]);
  //   LogUtil.logUtil("查询所有记录OtherData:$list",tag: tag);
  //   return list.map((v) => OtherData.fromJson(v)).toList();
  // }

  /// 插入记录 Insert some records in a transaction
  static Future<int?> insertRecord({required Map<String, dynamic> json,String? tableName})async{
    int? id1;
    debugPrint('inserted1: $json');
    await DBService.getInstance().database?.transaction((txn) async {
       id1 = await txn.insert(
           tableName??Tables.friendTab,json,
          conflictAlgorithm: ConflictAlgorithm.replace
      );
       LogUtil.logUtil("插入记录:$id1",tag: tag);
    });
    return id1;
  }
  /// 删除记录 Delete a record
  static Future<int?> deleteRecord({required String targetId})async{
    int count = await DBService.getInstance().database!.rawDelete('DELETE FROM Friend WHERE targetId = ? AND landerUID=?', [targetId,Constants.loginData!.userInfo!.id.toString()]);
    LogUtil.logUtil("删除记录:$count",tag: tag);
    return count;
  }

  /// 统计记录条数 Count the records  type  0:Likes you 1:Visitors 2:已匹配 3:已拉黑 4:已聊天
 static Future<int?> countRecords({ String? userId,int type=0,required String tabName})async{
   int? count;
   switch(tabName){
      case 'Friend':
         count = Sqflite
            .firstIntValue(await DBService.getInstance().database!.rawQuery('SELECT COUNT(*) FROM Friend WHERE userId= ? AND landerUID=?',[userId,Constants.loginData!.userInfo!.id.toString()]));
        break;
      case "OtherData":
        ///landerUID TEXT,uid TEXT,userId TEXT,saveTime INTEGER, type INTEGER)
      if(type==5){
        count = Sqflite.firstIntValue(await DBService.getInstance().database!
            .rawQuery('SELECT COUNT(*) FROM OtherData WHERE type=? AND landerUID=? ',
            [type,Constants.loginData!.userInfo!.id.toString()]));
      }else{
        count = Sqflite.firstIntValue(await DBService.getInstance().database!
            .rawQuery('SELECT COUNT(*) FROM OtherData WHERE userId=? AND type=? AND landerUID=? ',
            [userId,type,Constants.loginData!.userInfo!.id.toString()]));
      }
        break;
   }
    LogUtil.logUtil("统计记录条数:$count",tag: tag);
    return count;
  }
  /// 查询所有记录 Get the records
  static Future<List<FriendEntity>> selectRecordFriend()async{
    List<Map<String,dynamic>> list = await DBService.getInstance().database!
        .rawQuery('SELECT * FROM Friend WHERE landerUID=? order by sentTime desc',[Constants.loginData!.userInfo!.id.toString()]);
    LogUtil.logUtil("查询所有记录:$list",tag: tag);
    return list.map((v) => FriendEntity.fromJson(v)).toList();
  }

  /// 查询所有记录 Get the records type  0:Likes you 1:Visitors 2:已匹配 3:已拉黑 4:已聊天 5：记录滑动位置
  static Future<List<OtherDataEntity>> selectRecordOtherData({required int type})async{
    DateTime currentTime=DateTime.now();
    int startTime=DateTime(currentTime.year,currentTime.month,currentTime.day,currentTime.hour,0,0,0).millisecondsSinceEpoch;
    int endTime=DateTime(currentTime.year,currentTime.month,currentTime.day,currentTime.hour,23,59,59).millisecondsSinceEpoch;
    List<Map<String,dynamic>> list = await DBService.getInstance().database!
        .rawQuery('SELECT * FROM OtherData WHERE landerUID=? AND type=? AND saveTime BETWEEN ? AND ?',
        [Constants.loginData!.userInfo!.id.toString(),type,startTime,endTime]);
    LogUtil.logUtil("查询所有记录:$list",tag: tag);
    return list.map((v) => OtherDataEntity.fromJson(v)).toList();
  }

  /// 修改记录 Update some record
  static Future<int?> updateRecord(List<dynamic> list)async{
    list.add(Constants.loginData!.userInfo!.id.toString());
    int? count = await DBService.getInstance().database?.rawUpdate(
        'UPDATE Friend SET unreadCount=?, sentTime = ?, receivedTime = ?, messageType = ? , message = ?, nickname = ?, portrait = ?,'
            'alias=?,extra=?,top=?  WHERE userId = ?  AND landerUID=?',
        list);
    LogUtil.logUtil("根据userId修改记录:$count",tag: tag);
    return count;
  }
  /// 修改记录 Update some record
  static Future<int?> updateRecordByTargetId(List<dynamic> list)async{
    String sql="";
    if(list.length==3){
       sql='UPDATE Friend SET unreadCount=?,message=? WHERE targetId = ? AND landerUID=?';
    }else{
      sql='UPDATE Friend SET unreadCount=? WHERE targetId = ? AND landerUID=?';
    }
    list.add(Constants.loginData!.userInfo!.id.toString());
    int? count = await DBService.getInstance().database?.rawUpdate(sql, list);
    debugPrint('updated: $count');
    LogUtil.logUtil("根据uid(targetId)修改记录:$count",tag: tag);
    return count;
  }

  /// 关闭数据库
  static closeDataBase()async{
    try{
      await DBService.getInstance().database?.close();
    }catch(err){
      debugPrint("关闭数据库异常$err");
    }

    LogUtil.logUtil("关闭数据库",tag: tag);
  }
  /// 删除数据库  Delete the database
  static deleteData()async{
    await deleteDatabase(DBService.getInstance().databasePath);
    LogUtil.logUtil("删除数据库",tag: tag);
  }
}