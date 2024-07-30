import 'package:flutter/cupertino.dart';
import 'package:flutter_d0601/common/constants.dart';
import 'package:flutter_d0601/controller/personal_basicInformation_controller.dart';
import 'package:flutter_d0601/http/dio_service.dart';
import 'package:flutter_d0601/page/login/model/login_entity.dart';
import 'package:flutter_d0601/utils/loader_overlay_util.dart';
import 'package:get/get.dart';
import 'package:flutter_d0601/utils/custom_library/custom_library_export_util.dart';

import '../enum/cache_data_enum.dart';
import '../page/model/base_entity.dart';
import '../page/router/router_manager.dart';
import '../utils/app_package_info_util.dart';

class PhoneLoginController extends GetxController{
  /// 输入的手机号
  String phoneNumber='';
  /// 输入的验证码
  String? verificationCode;
  /// 国家资源名称
  List<Country> countryList=[];
  /// 验证码输入框控制器
  TextEditingController verificationCodeController=TextEditingController();
  /// 验证码输入框
  FocusNode verificationCodeFocusNode=FocusNode();
  int changeCurrentIndex=0;
  final personalBasicInformationController =Get.find<PersonalBasicInformationController>();

  @override
  void onInit(){
    super.onInit();
    countryList=Constants.countryList;
  }

  /// 请求验证码
  requestVerificationCode()async{
    Map<String,dynamic> business={
      // 'packageAppId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',
      // 'productId':301,
      // 'appId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',
      // 'device':AppPackageInfoUtil.deviceId,
      // 'appKey':AppPackageInfoUtil.appKey,
      'phone':phoneNumber,
      'zone':'+${countryList[changeCurrentIndex].headPhoneNumber}',
      'ip':AppPackageInfoUtil.networkAddress,
    };
    dynamic data=Constants.getRequestParameter(business: business);
    BaseEntity baseEntity=await DioService<BaseEntity>().sendMessage(data);
    if(baseEntity.success??false){
      Get.offNamed(RouterManager.phoneVerificationCode);
    }
  }

  /// 提交验证码登录
  verificationCodeLoginSubmit()async{

    LoaderOverlayUtil loaderOverlayUtil=LoaderOverlayUtil();
    // dynamic data=Constants.getRequestParameter(
    //   business: {
    //     'accessToken':verificationCode,//三方账号token，手机号登录时传验证码
    //     'accountType':5,//账号类型，1-facebook 4-google 5-phone 6-apple 7-device 10-password
    //     'countryCode':'US',//国家码，ISO 3166-1对应的两位大写
    //     'device':AppPackageInfoUtil.deviceId,
    //     'phone':phoneNumber,//手机号，短信登陆时必传
    //     'sign':MD5Util.generateMd5("28cb238c-1f8f-44e8-b41d-3e3dcf27c0de7TvmahX0289h523RueRa5G2fv0NSIshw8Cq21B6dwD78I698wECoKp0vEFPgB2gn"),//签名，appId+appSecret  md5 to upperCase，其中appSecret由server提供
    //     'zone':'+${countryList[changeCurrentIndex].headPhoneNumber}',//区号，短信登陆时必传
    //     'appId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',//用户appId
    //     'appKey':AppPackageInfoUtil.appKey,//客户端版本号
    //     'productId':301,//产品id，301
    //   }
    // );
    loaderOverlayUtil.show();
    Map<String,dynamic> business={
    // 'countryCode':'US',//国家码，ISO 3166-1对应的两位大写
    // 'device':AppPackageInfoUtil.deviceId,
    // 'sign':MD5Util.generateMd5("28cb238c-1f8f-44e8-b41d-3e3dcf27c0de7TvmahX0289h523RueRa5G2fv0NSIshw8Cq21B6dwD78I698wECoKp0vEFPgB2gn"),//签名，appId+appSecret  md5 to upperCase，其中appSecret由server提供
    // 'appId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',//用户appId
    // 'appKey':AppPackageInfoUtil.appKey,//客户端版本号
    // 'productId':301,//产品id，301
      'accessToken':verificationCode,//三方账号token，手机号登录时传验证码
      'accountType':5,//账号类型，1-facebook 4-google 5-phone 6-apple 7-device 10-password
      'phone':phoneNumber,//手机号，短信登陆时必传
      'zone':'+${countryList[changeCurrentIndex].headPhoneNumber}',//区号，短信登陆时必传
    };
    dynamic data=Constants.getRequestParameter(business: business);
    // {
    //   // "baseParams":{
    //   //   'appId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',//用户appId
    //   //   'appKey':AppPackageInfoUtil.appKey,//客户端版本号
    //   //   'device':AppPackageInfoUtil.deviceId,
    //   //   'lang':'en',//语言缩写
    //   // },
    //
    //   // 'userAuth':{
    //   //   'appId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',//用户appId
    //   //   'device':AppPackageInfoUtil.deviceId,
    //   //   'lang':'en',//语言缩写
    //   //   'lat':'',
    //   //   'lon':'',
    //   //   'region':''
    //   // },
    //   // 'packageAppId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',//马甲包appId
    //   // 'accountId':'',//三方账号 id（部分场景必传）
    //   // 'idToken':'',//apple id token
    //   // 'nickname':'',//昵称
    //   // 'email':'',//邮箱
    //   // 'headImg':'',//头像
    //   // 'birthday':0,//生日
    //   // 'sex':'',//性别 0男;1女 2未知
    //   // 'ip':AppPackageInfoUtil.networkAddress,
    //   // 'userH5Source':'',//h5来源，2-网红订阅引流 3-币商线下充值登录
    // };
    LoginEntity loginEntity=await DioService<LoginEntity>().thirdAuth(data);
    loaderOverlayUtil.hide();
    if(loginEntity.success??false){
      await CustomCacheUtil.putObject(CacheDataEnum.loginData.toString(), loginEntity.data??'');
      Constants.loginData=loginEntity.data;
      Constants.country=countryList[changeCurrentIndex];
      personalBasicInformationController..isRegister=loginEntity.data!.userInfo!.isRegister..update();
      personalBasicInformationController.queryUserAiTag(
          success: (){
            if(personalBasicInformationController.personalInfoDataItemListTmp.isNotEmpty){
              Get.offNamed("${RouterManager.personalBasicInformation}?isRegister=${loginEntity.data!.userInfo!.isRegister??0}");
            }else{
              Get.offAllNamed(RouterManager.home);
              // Get.until((route){
              //   if(route.settings.name==RouterManager.login){
              //     // Get.offAllNamed(RouterManager.home);
              //     Get.offNamed(RouterManager.home);
              //     return true;
              //   }else{
              //     return false;
              //   }
              // });
            }
          }
      );
    }
  }
}
class Country{
  /// 国家图标
  String iconName;
  /// 国家名称
  String countryName;
  /// 国家号码头
  String headPhoneNumber;
  /// 国家码 //国家码，ISO 3166-1对应的两位大写
  String countryCode;
  Country({
    required this.countryName,
    required this.headPhoneNumber,
    required this.iconName,
    required this.countryCode,
  });
}