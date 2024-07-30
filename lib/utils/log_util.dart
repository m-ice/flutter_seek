import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';



class LogUtil{
  static final  Logger logger=Logger();
  /// todo：完整日志打印
  static logUtil(dynamic msg,{String? tag}){
    /// todo：只在debug模式执行
    if(!kReleaseMode){
      log(msg,name: tag ?? 'Seek App日志：');
    }
  }
  static logInfo(dynamic  message,{Level level=Level.info}){
    logger.log(level,message);
  }
}

