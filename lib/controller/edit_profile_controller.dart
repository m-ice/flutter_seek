import 'dart:convert';

import 'package:flutter_d0601/controller/personal_basicInformation_controller.dart';
import 'package:flutter_d0601/page/home/sed/model/query_seek_angle_info_entity.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../common/constants.dart';
import '../enum/personal_Info_class.dart';
import '../http/dio_service.dart';
import '../page/router/router_manager.dart';
import 'my_controller.dart';

class EditProfileController extends GetxController{
  final personalBasicInformationController=Get.find<PersonalBasicInformationController>();
  FocusNode aboutMeFocusNode=FocusNode();
  TextEditingController aboutMeTextEditingController=TextEditingController();
  List imageList=List.filled(6, null);

  @override
  void onInit(){
    super.onInit();
    personalBasicInformationController.initData();
    querySeekAngleInfo();
    aboutMeTextEditingController.text=Constants.loginData!.userInfo!.extendInfo!=null&&Constants.loginData!.userInfo!.extendInfo!=""?
    jsonDecode(Constants.loginData!.userInfo!.extendInfo.toString())['profile']??'':'';
  }

  jumpNewPage(PersonalInfoClass personalInfoClass,{bool refresh=true}){
    int indexWhere=personalBasicInformationController.personalInfoDataItemList.indexWhere((element) => element.personalInfoClass==personalInfoClass);
    if(indexWhere!=-1){
      Get.toNamed(RouterManager.setPersonalInfoItemPage,arguments: {'currentIndex':indexWhere})!.then((value){
        if(value??false){
          if(refresh){
            Future.delayed(const Duration(milliseconds: 300),(){
              querySeekAngleInfo();
              Get.find<MyController>().queryUser();
            });
          }else{
            Get.find<MyController>().update();
          }
        }
      });
    }
  }

  QuerySeekAngleInfoData? querySeekAngleInfoData;

  String lookingFor='';



  /// 查询主播个人主页信息
  querySeekAngleInfo()async{
    Map<String,dynamic> business={
      // 'countryCode':'US',//国家码，ISO 3166-1对应的两位大写
      // 'device':AppPackageInfoUtil.deviceId,// 设备号
      // 'sign':MD5Util.generateMd5("28cb238c-1f8f-44e8-b41d-3e3dcf27c0de7TvmahX0289h523RueRa5G2fv0NSIshw8Cq21B6dwD78I698wECoKp0vEFPgB2gn"),//签名，appId+appSecret  md5 to upperCase，其中appSecret由server提供
      // 'appKey':AppPackageInfoUtil.appKey,//客户端版本号
      // 'productId':301,//产品id，301
      // 'appId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',//用户appId
      'userId':Constants.loginData!.userInfo!.userId,//用户userId
      'targetAppId':Constants.loginData!.userInfo!.appId,//用户userId
      'targetUserId':Constants.loginData!.userInfo!.userId,//用户userId
    };
    dynamic data=Constants.getRequestParameter(business: business);
    QuerySeekAngleInfoEntity querySeekAngleInfoEntity=await DioService<QuerySeekAngleInfoEntity>().querySeekAngleInfo(data);
    if(querySeekAngleInfoEntity.success??false){
      querySeekAngleInfoData=querySeekAngleInfoEntity.data;
      String lookingForTmp='';
      for(QuerySeekAngleInfoDataPurpose item in querySeekAngleInfoEntity.data!.purpose??[]){
        if(lookingForTmp.isNotEmpty){
          lookingForTmp+=',${item.desc}';
        }else{
          lookingForTmp=item.desc.toString();
        }
      }
      lookingFor=lookingForTmp;

      for(int i=0;i<6;i++){
        if(querySeekAngleInfoData!.covers!.length>i){
          imageList[i]=querySeekAngleInfoData!.covers![i];
        }else{
          imageList[i]=null;
        }
      }
      update();
    }
  }
}