import 'package:flutter_d0601/page/model/base_entity.dart';
import 'package:flutter_d0601/page/router/router_manager.dart';
import 'package:get/get.dart';
import 'package:flutter_d0601/utils/custom_library/custom_library_export_util.dart';

import '../common/constants.dart';
import '../enum/cache_data_enum.dart';
import '../enum/personal_Info_class.dart';
import '../http/dio_service.dart';
import '../page/home/my/model/regular_photo_album_entity.dart';
import '../page/home/sed/model/user_ai_tag_enums_entity.dart';
import '../page/login/model/login_entity.dart';
import '../utils/app_package_info_util.dart';
import '../utils/network_util.dart';
import '../utils/toast_util.dart';

class SplashController extends GetxController{
  @override
  void onInit(){
    super.onInit();
    Constants.loginData=CacheUserDataUtil.getCacheLoginData(CacheDataEnum.loginData);
    NetWorkUtil.whetherToEnterTheApp=false;
    NetWorkUtil.checkNetStatus();
    refreshToken();
  }
  /// 刷新token
  refreshToken()async{
    if(!(Constants.loginData!=null&&Constants.loginData!.userInfo!=null)) return ;
    AppPackageInfoUtil.getPackageInfo();
    Map<String,dynamic> business={
      'appId':Constants.loginData!.userInfo!.appId,//用户appId
      'userId':Constants.loginData!.userInfo!.userId,//用户userId
    };
    dynamic data=Constants.getRequestParameter(business: business);
    LoginEntity? loginEntity;
    try{
      loginEntity=await DioService<LoginEntity>().refreshToken(data);
    }catch(e){
      e.printError();
     // return  Constants.commonLogOut(showTips: true);
      Get.offAllNamed(RouterManager.home);
      if(!NetWorkUtil.netWorkState){
        toast('network error');
      }
    }
    if(loginEntity!=null&&(loginEntity.success??false)){
      await CustomCacheUtil.putObject(CacheDataEnum.loginData.toString(), loginEntity.data??'');

      Constants.loginData=loginEntity.data;
      /// outRole: 1代表审核账号
      Constants.isAuditOrNot=(loginEntity.data!.outRole==1);
    }
  }

  /// 查询个人AI标签
  Future<void> queryUserAiTag({Function? success})async{
    if(!(Constants.loginData!=null&&Constants.loginData!.userInfo!=null)) return ;
    Map<String,dynamic> business={
      'appId':Constants.loginData!.userInfo!.appId,//用户appId
      'userId':Constants.loginData!.userInfo!.userId,//用户userId
    };
    dynamic data=Constants.getRequestParameter(business: business);
    UserAiTagEnumsEntity userAiTagEnumsEntity=await DioService<UserAiTagEnumsEntity>().queryUserAiTag(data);
    if(userAiTagEnumsEntity.success??false){
      settingItemCount=0;
      if(Constants.loginData!=null&&Constants.loginData!.userInfo!=null){
        updatePersonalInfoClassList(personalInfoClass: PersonalInfoClass.setSexKey,data: Constants.loginData!.userInfo!.sex);
        updatePersonalInfoClassList(personalInfoClass: PersonalInfoClass.setNameKey,data: Constants.loginData!.userInfo!.nickname);
        updatePersonalInfoClassList(personalInfoClass: PersonalInfoClass.setBirthKey,data: Constants.loginData!.userInfo!.birthday);
        updatePersonalInfoClassList(personalInfoClass: PersonalInfoClass.setHereForKey,data: userAiTagEnumsEntity.data!.purpose);
        update();
      }
      if(settingItemCount>0){
        success?.call();
      }else{
        albumList(success: success);
      }
      update();
    }
  }

  ///查询普通相册列表
  albumList({Function? success})async{
    Map<String,dynamic> business={
      'packageAppId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',//马甲包appId
      'appId':Constants.loginData!.userInfo!.appId,//用户appId
      'lang':'en',//语言
      'appKey':AppPackageInfoUtil.appKey,//客户端版本号
      'deviceId':AppPackageInfoUtil.deviceId,// 设备号
      'userId':Constants.loginData!.userInfo!.userId,//用户userId
      'pageNo':1,//页码
      'pageSize':16,//页宽
    };
    dynamic data=Constants.getRequestParameter(business: business);
    RegularPhotoAlbumEntity albumEntity=await DioService<RegularPhotoAlbumEntity>().albumList(data);
    if(albumEntity.success??false){
      updatePersonalInfoClassList(personalInfoClass: PersonalInfoClass.setPhotoKey,data: albumEntity.items);
      success?.call();
    }
  }
  /// 未设置项数
  int settingItemCount=0;
  /// 更新信息分类列表
  updatePersonalInfoClassList({dynamic data,required PersonalInfoClass personalInfoClass}){
    if(data==null||data==[]||(data!=null&&(data is String||data is List)&&data.isEmpty)){
      settingItemCount+=1;
      update();
    }
  }
}