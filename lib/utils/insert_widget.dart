import 'package:flutter/material.dart';
import 'package:flutter_d0601/app_style/font_style.dart';
import 'package:flutter_d0601/controller/discover_controller.dart';
import 'package:flutter_d0601/page/widgets/icon_text_ink_well_widget.dart';
import 'package:flutter_d0601/utils/resource_util.dart';
import 'package:flutter_d0601/utils/screen_util.dart';
import 'package:flutter_d0601/utils/custom_library/custom_library_export_util.dart';

import '../common/constants.dart';
import '../controller/circle_controller.dart';
import '../controller/sed_controller.dart';
import '../http/dio_service.dart';
import '../page/model/base_entity.dart';
import '../page/widgets/report_choice_item_widget.dart';
import 'db_util.dart';
import 'get_default_dialog.dart';
import 'package:get/get.dart';

/// 举报用户
reportUser({required dynamic businessTmp,Function? resultSuccess})async{
  // Map<String,dynamic> business={
  //   'countryCode':'US',//国家码，ISO 3166-1对应的两位大写
  //   'device':AppPackageInfoUtil.deviceId,// 设备号
  //   'sign':MD5Util.generateMd5("28cb238c-1f8f-44e8-b41d-3e3dcf27c0de7TvmahX0289h523RueRa5G2fv0NSIshw8Cq21B6dwD78I698wECoKp0vEFPgB2gn"),//签名，appId+appSecret  md5 to upperCase，其中appSecret由server提供
  //   'appId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',//用户appId
  //   'appKey':AppPackageInfoUtil.appKey,//客户端版本号
  //   'productId':301,//产品id，301
  //   'userId':Constants.loginData!.userInfo!.userId,//用户userId
  //   'headImg':headImg,//用户userId
  // };
  Map<String,dynamic> business={
    'appId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',//用户appId
    'userId':Constants.loginData!.userInfo!.userId,//用户userId
  };
  business['reportAppId']=businessTmp['otherAppId'];//被举报的应用 id
  business['reportUserId']=businessTmp['otherUserId'];//被举报的用户 id
  business['type']=businessTmp['otherType'];//举报类型  1 暴力， 2 色情 ， 3 违法， 4  骚扰
  // business['description']=businessTmp['otherDescription'];//描述
  dynamic data=Constants.getRequestParameter(
      business: business
  );
  BaseEntity baseEntity=await DioService<BaseEntity>().reportUser(data);
  if(baseEntity.success??false){
    updateCacheBlockData(userId: businessTmp['otherUserId'].toString(),);
    resultSuccess?.call();
  }
}
/// 拉黑/取消拉黑
blockUser({required dynamic businessTmp,Function? resultSuccess})async{
  dynamic business={
    'appId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',//用户appId
    'userId': Constants.loginData!.userInfo!.userId,//用户userId
    'type':1,//1 拉黑 2 解除拉黑
  };
  business['blockAppId']=businessTmp['otherAppId'];//被拉黑的应用 id
  business['blockUserId']=businessTmp['otherUserId'];//被拉黑的用户 id
  dynamic data=Constants.getRequestParameter(
      business: business
  );
  BaseEntity baseEntity=await DioService<BaseEntity>().blockUser(data);
  if(baseEntity.success??false){
    updateCacheBlockData(userId: businessTmp['otherUserId'].toString(),);
    resultSuccess?.call();
  }
}


/// 更新缓存的拉黑数据
updateCacheBlockData({required String userId}){
  List<String> list=[userId];
  int indexWhere=Constants.blockDataList.indexWhere((element) => element==userId);
  if(indexWhere==-1){
    list.addAll(Constants.blockDataList);
    CustomCacheUtil.putStringList("blockData_${Constants.loginData!.userInfo!.id}", list)!.then((value){
      if(value){
        Constants.blockDataList=list;
        updateOnePageData(userId: userId);
      }
    });
  }
}

updateOnePageData({required String userId}){
  final  sedController=Get.find<SedController>();
  final  circleController=Get.find<CircleController>();
  final  discoverController=Get.find<DiscoverController>();
  int sedIndexWhere=sedController.sedAngleList.indexWhere((element) => element.userId==userId);
  if(sedIndexWhere!=-1){
    sedController..sedAngleList.removeAt(sedIndexWhere)..update();
  }

  int circleIndexWhere= (circleController.currentIndex==0?circleController.querySeekLikesList:circleController.querySeekVisitorsList).indexWhere((element) => element.userId==userId);
  if(circleIndexWhere!=-1){
    circleController..screenLikeData()..update();
  }
  int discoverIndexWhere=discoverController.friendList.indexWhere((element) => element.userId==userId);
  if(discoverIndexWhere!=-1){
    DBUtil.deleteRecord(targetId: discoverController.friendList[discoverIndexWhere].targetId.toString()).then((value){
      if(value==1){
        discoverController..friendList.removeAt(discoverIndexWhere)..update();
        discoverController.getConversationsRecord();
      }
    });
  }
}

/// 投诉与拉黑
OverlayEntry createOverlayEntryReportOrBlock({double? right,double? top,required Map<String,dynamic> businessTmp,Function? report,Function? block,required Function close}){
  String? reportStatus;
  return OverlayEntry(builder: (context){
    return Positioned(
        right: right,
        top: top,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 160.setWidth(),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.setRadius()),
                  bottomRight: Radius.circular(8.setRadius()),
                  topLeft: Radius.circular(8.setRadius())
                ),
              boxShadow: [BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: Offset(0,2.setWidth()),
                blurRadius: 10.setRadius(),
                spreadRadius: 0.setRadius(),
              )]
            ),
            child: Column(children: [
              IconTextInkWellWidget(title: "Report",
                textStyle: getFontStyle(
                  fontSize: 14,
                  fontHeight: 1.4,
                  fontWeight: FontWeight.w700,),
                iconPath: ResourceUtil.getAppPageIcon('report'),
                iconSize: 18,
                iconColor: const Color(0xFF212121),
                iconPadding: EdgeInsets.only(right: 6.setWidth()),
                textPadding: EdgeInsets.symmetric(vertical: 14.setHeight()),
                borderRadius: BorderRadius.vertical(top: Radius.circular(8.setRadius())),
                onTap: (){
                  getDefaultDialog(context: context,
                      content: StatefulBuilder(builder: (cx,set){
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReportChoiceItemWidget(reportName: 'Porn',choiceStatus: reportStatus??'',onTap: (reportName){
                                  set((){
                                    reportStatus=reportName.toString();
                                  });
                                },),
                                ReportChoiceItemWidget(reportName: 'Illegal',choiceStatus: reportStatus??'',onTap: (reportName){
                                  set((){
                                    reportStatus=reportName.toString();
                                  });
                                },),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReportChoiceItemWidget(reportName: 'Viilence',choiceStatus: reportStatus??'',onTap: (reportName){
                                  set((){
                                    reportStatus=reportName.toString();
                                  });
                                },),
                                ReportChoiceItemWidget(reportName: 'Harassment',choiceStatus: reportStatus??'',onTap: (reportName){
                                  set((){
                                    reportStatus=reportName.toString();
                                  });
                                },),
                              ],
                            ),

                          ],
                        );
                      }),
                      cancelTitle: 'Report', confirmTitle: 'Cancel',
                      cancelOnTap: (){
                    if(reportStatus!=null){
                      ///举报类型  1 viilence-暴力， 2 Porn-色情 ， 3 Illegal-违法， 4 Harassment-骚扰
                      businessTmp['otherType']={'Viilence':1,'Porn':2,'Illegal':3,'Harassment':4}[reportStatus];
                      Get.back();
                      reportUser(
                          businessTmp: businessTmp,
                          resultSuccess: (){
                            report?.call(reportStatus);
                          });
                    }
                  });
                  close.call();
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.setWidth()),
                child: Divider(
                  height: 1.setHeight(),
                  color: const Color(0xFFF5F5F5),
                  thickness: 1,
                ),
              ),
              IconTextInkWellWidget(
                title: "Block",
                textStyle: getFontStyle(
                  fontSize: 14,
                  fontHeight: 1.4,
                  fontWeight: FontWeight.w700,),
                iconPath: ResourceUtil.getAppPageIcon('block'),
                iconSize: 18,
                iconColor: const Color(0xFF212121),
                iconPadding: EdgeInsets.only(right: 6.setWidth()),
                textPadding: EdgeInsets.symmetric(vertical: 14.setHeight()),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(8.setRadius())),
                onTap: (){
                  getDefaultDialog(context: context, middleText: 'Are you sure you want to Block her?',
                      cancelTitle: 'Block', confirmTitle: 'Cancel',
                      cancelOnTap: (){
                        blockUser(businessTmp: businessTmp,
                            resultSuccess: (){
                              block?.call();
                            });
                        Get.back();
                      });
                  close.call();
                },
              ),
            ],),
          ),
        ));
  });
}