
import 'package:get/get.dart';
import 'package:flutter_d0601/http/dio_service.dart';
import 'package:flutter_d0601/page/model/base_entity.dart';
import 'package:flutter_d0601/utils/custom_library/custom_library_export_util.dart';

import '../common/constants.dart';
import '../enum/cache_data_enum.dart';
import '../page/router/router_manager.dart';
import '../utils/get_default_dialog.dart';

class SettingController extends GetxController{


  /// 退出登录
  logOut(){
    getDefaultDialog(context: Get.context!, middleText: 'Are you sure to log out？',
        cancelTitle: 'Log Out', confirmTitle: 'Cancel',
        cancelOnTap: (){
          Constants.commonLogOut();
          // CustomCacheUtil.remove(CacheDataEnum.loginData.toString())!.then((value){
          //   if(value){
          //     Get.offAllNamed(RouterManager.login);
          //   }
          // });
        }
    );
  }

  /// 删除账号
  deleteAccount()async{
    Constants.commonLogOut();
    // Map<String,dynamic> business={
    //   'appId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',//用户appId
    //   'userId':Constants.loginData!.userInfo!.userId,//用户userId
    // };
    // dynamic data=Constants.getRequestParameter(
    //     business: business
    // );
    // BaseEntity baseEntity=await DioService<BaseEntity>().deleteAccount(data);
    // if(baseEntity.success??false){
    //   // toast(baseEntity.message);
    //   CustomCacheUtil.remove(CacheDataEnum.loginData.toString())!.then((value){
    //     if(value){
    //       Constants.loginData=null;
    //       Get.offAllNamed(RouterManager.login);
    //     }
    //   });
    // }
  }
}