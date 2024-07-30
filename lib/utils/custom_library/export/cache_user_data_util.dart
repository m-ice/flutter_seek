import 'package:flutter_d0601/page/login/model/login_entity.dart';
import 'package:flutter_d0601/utils/log_util.dart';
import '../../../enum/cache_data_enum.dart';
import '../../../generated/json/base/json_convert_content.dart';
import '../../../page/home/sed/model/sliding_record_entity.dart';
import 'custom_cache_util.dart';

/// 缓存用户数据
class CacheUserDataUtil{

  static LoginData? getCacheLoginData(CacheDataEnum key){
    Map? map=CustomCacheUtil.getObject(key.toString());
    return map!=null? JsonConvert.fromJsonAsT<LoginData>(map):null;
  }
  static List<String> getStringListData(String key){
    List<String>? list=CustomCacheUtil.getStringList(key.toString());
    return list??[];
  }

  static bool? getBoolData(String key){
    bool? result=CustomCacheUtil.getBool(key.toString());
    return result;
  }
  static SlidingRecordEntity? getSlidingRecordData(String key){
    Map? map=CustomCacheUtil.getObject(key.toString());
    return map!=null? JsonConvert.fromJsonAsT<SlidingRecordEntity>(map):null;
  }
}