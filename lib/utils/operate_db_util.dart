import 'package:flutter/material.dart';
import 'package:flutter_d0601/utils/db_util.dart';
import 'package:flutter_d0601/utils/log_util.dart';
import 'package:sqflite/sqflite.dart';

import '../common/constants.dart';
import '../generated/json/base/json_convert_content.dart';

class OperateDBUtil<T>{
   static String tag='【${Constants.appTitle}_database】';
  
  /// 增加数据
  static Future<int?> insertRecord({required Map<String, dynamic> json,String? tableName})async{
    int? id1;
    debugPrint('inserted1: $json');
    await DBService.getInstance().database?.transaction((txn) async {
      id1 = await txn.insert(
          tableName??Tables.chatRecord,json,
          conflictAlgorithm: ConflictAlgorithm.replace
      );
      LogUtil.logUtil("插入聊天记录:$id1",tag: tag);
    });
    return id1;
  }
   
   /// 查询记录 SELECT * FROM Friend WHERE landerUID=? order by sentTime desc
   Future<List<T?>> selectRecord({required String sql,List<dynamic>? arguments})async{
     List<Map<String,dynamic>> list=[];
    if(arguments!=null&&arguments.isNotEmpty){
      list = await DBService.getInstance().database!.rawQuery(sql,arguments);
    }else{
      list = await DBService.getInstance().database!.rawQuery(sql);
    }
     LogUtil.logUtil("查询所有记录:$list",tag: tag);
     return list.map((v) => JsonConvert.fromJsonAsT<T>(v)).toList();
   }
   
   /// 修改记录
  /// 'UPDATE Friend SET unreadCount=?, sentTime = ?, receivedTime = ?, messageType = ? , message = ?, nickname = ?, portrait = ?,'
  ///             'alias=?,extra=?,top=?  WHERE userId = ?  AND landerUID=?'
  static Future<int?> updateRecord({required String sql,required List<dynamic> arguments})async{
    int? count = await DBService.getInstance().database?.rawUpdate(sql, arguments);
    LogUtil.logUtil("根据userId修改记录:$count",tag: tag);
    return count;
  }

  /// 统计记录
  static Future<int?> countRecord({required String sql,required List<dynamic> arguments})async{
    int? count = Sqflite
        .firstIntValue(await DBService.getInstance().database!.rawQuery(sql,arguments));

    return count??0;
  }
}