import 'package:flutter_d0601/http/dio_service.dart';
import 'package:flutter_d0601/page/home/sed/model/query_seek_likes_visitors_entity.dart';
import 'package:flutter_d0601/utils/custom_library/custom_library_export_util.dart';
import 'package:flutter_d0601/utils/db_util.dart';
import 'package:flutter_d0601/utils/log_util.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../common/constants.dart';

class CircleController extends GetxController{
  int currentIndex=0;
  double interval=0.0;
  PageController pageController=PageController(initialPage:0);


  @override
  void onInit(){
    super.onInit();
    pageController.addListener(() {
      interval=pageController.page!;
      update();
    });
    querySeekLikesVisitors(type: 0);
    querySeekLikesVisitors(type: 1,up: false);
  }

  int queryNewSeekLikesCount=0;
  int querySeekVisitorsCount=0;
  List<QuerySeekLikesVisitorsItems> querySeekLikesList=[];
  List<QuerySeekLikesVisitorsItems> querySeekVisitorsList=[];
  // /// Links You 的数量
  // int  zeroType=0;
  // /// Visitors 的数量
  // int  oneType=0;
  /// 页码
  int pageNo=1;

  /// 是否已经查阅
  bool haveYouChecked(int index){
    if(currentIndex==0){
      return Constants.circleDataListZero
          .contains(querySeekLikesList[index].userId);
    }else{
      return Constants.circleDataListOne
          .contains(querySeekVisitorsList[index].userId);
    }
  }
  /// querySeekLikes Visitors-likes/visitors列表
  querySeekLikesVisitors({bool load=false,int? type,bool up=true})async{
      if((type??currentIndex)==0){
        queryNewSeekLikesCount=0;
        Constants.circleDataListZero=CacheUserDataUtil.getStringListData('circleDataZero_${Constants.loginData!.userInfo!.id}');
        // List<OtherDataEntity> list= await DBUtil.selectRecordOtherData(type: 0);
        // print('我的数据0--${list.length}--$list');
        // print('我的数据-0-${Constants.circleDataListZero}');
      }else{
        querySeekVisitorsCount=0;
        Constants.circleDataListOne=CacheUserDataUtil.getStringListData('circleDataOne_${Constants.loginData!.userInfo!.id}');
        // List<OtherDataEntity> list= await DBUtil.selectRecordOtherData(type: 1);
        // print('我的数据1--${list.length}--$list');
        // print('我的数据-1-${Constants.circleDataListOne}');
      }
    load?pageNo++:pageNo=1;
    Map<String,dynamic> business={
      // 'productId':301,//产品id，301
      // 'appId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',//用户appId
      'userId':Constants.loginData!.userInfo!.userId,//用户userId
      'type':type??currentIndex,//0-Likes, 1-Visitors
      'pageNo':pageNo,//页码
      'pageSize':20,//每页大小
      // 'packageAppId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',//马甲包appId
      // 'countryCode':'US',//国家码，ISO 3166-1对应的两位大写
      // 'device':AppPackageInfoUtil.deviceId,// 设备号
      // 'sign':MD5Util.generateMd5("28cb238c-1f8f-44e8-b41d-3e3dcf27c0de7TvmahX0289h523RueRa5G2fv0NSIshw8Cq21B6dwD78I698wECoKp0vEFPgB2gn"),//签名，appId+appSecret  md5 to upperCase，其中appSecret由server提供
      // 'appKey':AppPackageInfoUtil.appKey,//客户端版本号
    };
    dynamic data=Constants.getRequestParameter(
        business: business
    );
    QuerySeekLikesVisitorsEntity querySeekLikesVisitorsEntity= await DioService<QuerySeekLikesVisitorsEntity>().querySeekLikesVisitors(data);
    if(querySeekLikesVisitorsEntity.success??false){
      updateSeekLikesOrSeekVisitorsList(querySeekLikesVisitorsEntity.items??[], type: type??currentIndex, load: load, up: up);
      update();
    }
  }

  // insertData(querySeekVisitorsList: tmpList,type: 0);
  // insertData(querySeekVisitorsList: tmpList,type: 1);
  /// 更新列表数据
  updateSeekLikesOrSeekVisitorsList(List<QuerySeekLikesVisitorsItems> tmpSeekList,{required int type,required bool load,required bool up}){
    if(type==0){
      if(load){
        querySeekLikesList.addAll(tmpSeekList);
        queryNewSeekLikesCount=(tmpSeekList).takeWhile((value) => !Constants.circleDataListZero.contains(value.userId.toString())).toList().length;
      }else{
        querySeekLikesList=tmpSeekList;
        queryNewSeekLikesCount=(tmpSeekList).takeWhile((value) => !Constants.circleDataListZero.contains(value.userId.toString())).toList().length;
      }
    }else{
      if(load){
        querySeekVisitorsList.addAll(tmpSeekList);
        querySeekVisitorsCount=(tmpSeekList).takeWhile((value) => !Constants.circleDataListOne.contains(value.userId.toString())).toList().length;
      }else{
        querySeekVisitorsList=tmpSeekList;
        querySeekVisitorsCount=(tmpSeekList).takeWhile((value) => !Constants.circleDataListOne.contains(value.userId.toString())).toList().length;
      }
    }
    if(up){
      saveLoadSeekData(tmpSeekList,type: type);
    }
    update();

  }

  /// 记录已经浏览过的数据
  saveLoadSeekData(List<QuerySeekLikesVisitorsItems> tmpSeekList,{required int type})async{
    screenLikeData(type: type);
    List<String> currentResultDataList=(tmpSeekList).map((e) => e.userId.toString()).toList();
    bool? result;
    if(type==0){
      currentResultDataList.addAll(Constants.circleDataListZero);
      result=await CustomCacheUtil.putStringList('circleDataZero_${Constants.loginData!.userInfo!.id}', currentResultDataList.toSet().toList());
    }else{
      currentResultDataList.addAll(Constants.circleDataListOne);
      result=await CustomCacheUtil.putStringList('circleDataOne_${Constants.loginData!.userInfo!.id}', currentResultDataList.toSet().toList());
    }
    LogUtil.logUtil('Visitors数据缓存在本地:$result');
  }

  insertData({required List<QuerySeekLikesVisitorsItems> querySeekVisitorsList,required int type}){
    for(QuerySeekLikesVisitorsItems querySeekLikesVisitorsItems in querySeekVisitorsList){
      DBUtil.countRecords(tabName: Tables.otherDataTab,type: type,userId: querySeekLikesVisitorsItems.userId.toString()).then((value){
        if(value!=null&&value==0){
          Map<String,dynamic> otherData={
            "landerUID":Constants.loginData!.userInfo!.id.toString(),
            "uid":querySeekLikesVisitorsItems.uid.toString(),
            "userId":querySeekLikesVisitorsItems.userId.toString(),
            "saveTime":DateTime.now().millisecondsSinceEpoch,
            "type":type, ///  0:Likes you 1:Visitors 2:已匹配 3:已拉黑 4:已聊天 5：记录滑动位置
          };
          DBUtil.insertRecord(json: otherData,tableName: Tables.otherDataTab);
        }
      });
    }
  }

  /// 筛选出被拉黑的人
  screenLikeData({int? type}){
    if((type??currentIndex)==0){
      for(String userId in Constants.blockDataList){
        int indexWhere=querySeekLikesList.indexWhere((element) => element.userId==userId);
        if(indexWhere!=-1){
          querySeekLikesList.removeAt(indexWhere);
        }
      }
    }else{
      for(String userId in Constants.blockDataList){
        int indexWhere=querySeekVisitorsList.indexWhere((element) => element.userId==userId);
        if(indexWhere!=-1){
          querySeekVisitorsList.removeAt(indexWhere);
        }
      }
    }
    update();
  }
}