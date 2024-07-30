import 'package:flutter_d0601/controller/vip_of_open_or_details_controller.dart';
import 'package:flutter_d0601/http/dio_service.dart';
import 'package:flutter_d0601/page/home/my/model/money_config_entity.dart';
import 'package:flutter_d0601/page/home/my/model/query_user_entity.dart';
import 'package:flutter_d0601/page/model/base_entity.dart';
import 'package:get/get.dart';

import '../common/constants.dart';
import '../page/home/my/model/user_account_detail_entity.dart';

class MyController extends GetxController{
  /// 是否是为vip
  bool isOpenMembership=false;
  /// 用户头像
  dynamic headImg;
  /// 用户信息
  QueryUserData? queryUserData2;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    queryUser();
    getUserAccountDetail();
    moneyConfig();
  }
  /// 查询个人用户详情
  queryUser()async{
    if(!(Constants.loginData!=null&&Constants.loginData!.userInfo!=null)) return ;
    Map<String,dynamic> business={
      'appId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',//用户appId
      'userId':Constants.loginData!.userInfo!.userId,//用户userId
    };
    dynamic data=Constants.getRequestParameter(business: business);
    QueryUserEntity queryUserEntity=await DioService<QueryUserEntity>().queryUser(data);
    if(queryUserEntity.success??false){
      // queryUserData=queryUserEntity.data;
      headImg=queryUserEntity.data!.headImg;
      update();
    }
  }

  /// 修改用户信息
  updateUser({Function? success})async{
    // "baseParams":{
    // 'appId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de', //用户appId
    // 'appKey':AppPackageInfoUtil.appKey, //客户端版本号
    // 'device':AppPackageInfoUtil.deviceId,
    // 'lang':'en', //语言缩写
    // },
    //
    // 'userAuth':{
    // 'appId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de', //用户appId
    // 'device':AppPackageInfoUtil.deviceId,
    // 'lang':'en', //语言缩写
    // 'lat':'',
    // 'lon':'',
    // 'region':''
    // }
    // 'business':{
    //   'nickname':restrictionName,//昵称
    //   'headImg':businessMap['headImg'],//头像
    //   'birthday':businessMap['birthday'],//生日,yyyy-MM-dd HH:mm:ss
    //   'profile':businessMap['profile'],//个人简介
    //   'multiLang':businessMap['multiLang'],//多个英文逗号分隔，部分app使用了全拼
    //   'sex':businessMap['sex'],//0女1男
    //   'countryAndSexChange':false,//国家和性别发生了修改
    // }

    Map<String,dynamic> business={
      // 'countryCode':'US',//国家码，ISO 3166-1对应的两位大写
      // 'device':AppPackageInfoUtil.deviceId,// 设备号
      // 'sign':MD5Util.generateMd5("28cb238c-1f8f-44e8-b41d-3e3dcf27c0de7TvmahX0289h523RueRa5G2fv0NSIshw8Cq21B6dwD78I698wECoKp0vEFPgB2gn"),//签名，appId+appSecret  md5 to upperCase，其中appSecret由server提供
      // 'appId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',//用户appId
      // 'appKey':AppPackageInfoUtil.appKey,//客户端版本号
      // 'productId':301,//产品id，301
      'userId':Constants.loginData!.userInfo!.userId,//用户userId
      'headImg':headImg,//用户userId
    };
    dynamic data=Constants.getRequestParameter(
        business: business
    );
    BaseEntity baseEntity=await DioService<BaseEntity>().updateUser(data);
    if(baseEntity.success??false){
      queryUser();
      success?.call();
    }
  }

  /// 账户详情
  UserAccountDetailData? userAccountDetailData;
  /// 查询账户详情
  getUserAccountDetail()async{
    Map<String,dynamic> business={
      // 'countryCode':'US',//国家码，ISO 3166-1对应的两位大写
      // 'device':AppPackageInfoUtil.deviceId,// 设备号
      // 'sign':MD5Util.generateMd5("28cb238c-1f8f-44e8-b41d-3e3dcf27c0de7TvmahX0289h523RueRa5G2fv0NSIshw8Cq21B6dwD78I698wECoKp0vEFPgB2gn"),//签名，appId+appSecret  md5 to upperCase，其中appSecret由server提供
      // 'appId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',//用户appId
      // 'appKey':AppPackageInfoUtil.appKey,//客户端版本号
      // 'productId':301,//产品id，301
      'userId':Constants.loginData!.userInfo!.userId,//用户userId
    };
    dynamic data=Constants.getRequestParameter(business: business);
    UserAccountDetailEntity userAccountDetailEntity=await DioService<UserAccountDetailEntity>().getUserAccountDetail(data);
    if(userAccountDetailEntity.success??false){
      userAccountDetailData=userAccountDetailEntity.data;
      /// 会员状态，0未开通，1开通，2过期
      String vipExpireTmp=userAccountDetailData!.vipExpire??DateTime.now().toString();
      DateTime vipExpire= DateTime(int.parse(vipExpireTmp.substring(0,4)),int.parse(vipExpireTmp.substring(5,7)),int.parse(vipExpireTmp.substring(8,10)),
              int.parse(vipExpireTmp.substring(11,13)),int.parse(vipExpireTmp.substring(14,16)));
      isOpenMembership=vipExpire.isAfter(DateTime.now())&&userAccountDetailData!.vipStatus==1;
      Constants.isOpenMembership=isOpenMembership;
      update();
    }
  }
  List<MoneyConfigData> moneyConfigDataList=[];
  /// 查询货币配置
  moneyConfig()async{
    Map<String,dynamic> business={
      'type':2,//配置类型 0-充值 1-活动 2-订阅 3-h5支付  0内购 2订阅
      'channel':0,//渠道 0-gp 1-appStore
      'itemType':3,//类型 1-钻石 2内购 3订阅 4-贵族
      // 'configId':,//商品配置id
      'appId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',//用户appId
      'packageAppId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',//马甲包appId
      'bizVersion':1,//业务版本 1-支持特惠套餐
      'showType': 0,//展示类型 0-正常展示套餐，1-特惠套餐展示 2- 首充套餐展示 4-低价套餐展示；默认0
    };
    dynamic data=Constants.getRequestParameter(
        business: business
    );
    MoneyConfigEntity moneyConfigEntity=await DioService<MoneyConfigEntity>().moneyConfig(data);
    if(moneyConfigEntity.success??false){
      moneyConfigDataList=moneyConfigEntity.data??[];
      update();
    }
  }
}