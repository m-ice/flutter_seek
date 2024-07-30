import 'dart:convert';

import 'package:flutter_d0601/controller/sed_controller.dart';
import 'package:flutter_d0601/http/dio_service.dart';
import 'package:flutter_d0601/page/home/my/model/query_app_pay_channel_entity.dart';
import 'package:flutter_d0601/page/home/my/model/query_pay_config_ext_entity.dart';
import 'package:flutter_d0601/page/home/my/model/recharge_entity.dart';
import 'package:flutter_d0601/page/router/router_manager.dart';
import 'package:flutter_d0601/utils/custom_library/custom_library_export_util.dart';
import 'package:flutter_d0601/utils/loader_overlay_util.dart';
import 'package:get/get.dart';


import '../common/constants.dart';
import '../page/home/my/model/money_config_entity.dart';
import '../utils/app_package_info_util.dart';
import 'my_controller.dart';

class VipOfOpenOrDetailsController extends GetxController{

  List<String> statsList=['Unlimited Chat','Unlimited Swipe','Unlimited Likes'];
  List<String> payList=['pay_paytm','pay_google','pay_visa'];
  int payCurrentIndex=0;

  List<QueryAppPayChannelData> queryAppPayChannelDataList=[];
  // MyController myController=Get.find<MyController>();

  /// 强制性开通vip;
  bool  compulsionVip=false;
  bool  loading=true;

  Map map= Get.parameters;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isCompulsionVip();
    moneyConfig();
    if(Constants.isAuditOrNot){
      queryAppPayChannel();
    }else{
      queryPayConfigExt();
    }
  }


  List<MoneyConfigData> moneyConfigDataList=[];
  /// 查询货币配置
  moneyConfig()async {
    Map<String, dynamic> business = {
      'type': 2, //配置类型 0-充值 1-活动 2-订阅 3-h5支付  0内购 2订阅
      'channel': 0, //渠道 0-gp 1-appStore
      'itemType': 3, //类型 1-钻石 2内购 3订阅 4-贵族
      // 'configId':,//商品配置id
      'appId': '28cb238c-1f8f-44e8-b41d-3e3dcf27c0de', //用户appId
      'packageAppId': '28cb238c-1f8f-44e8-b41d-3e3dcf27c0de', //马甲包appId
      'bizVersion': 1, //业务版本 1-支持特惠套餐
      'showType': 0, //展示类型 0-正常展示套餐，1-特惠套餐展示 2- 首充套餐展示 4-低价套餐展示；默认0
    };
    dynamic data = Constants.getRequestParameter(
        business: business
    );
    MoneyConfigEntity moneyConfigEntity = await DioService<MoneyConfigEntity>()
        .moneyConfig(data);
    if (moneyConfigEntity.success ?? false) {
      moneyConfigDataList = moneyConfigEntity.data ?? [];
      update();
    }
  }
  /// 是否强制性开通
  isCompulsionVip(){
    bool result=CacheUserDataUtil.getBoolData('${Constants.loginData!.userInfo!.id}_compulsionVip')??false;
    if(result){
      compulsionVip=result;
    }else if(map['requireVip']!=null){
      compulsionVip=(map['requireVip']=='true');
      CustomCacheUtil.putBool('${Constants.loginData!.userInfo!.id}_compulsionVip', compulsionVip);
    }
    update();
  }

  paySuccessResult(){
    if(compulsionVip){
      CustomCacheUtil.putBool('${Constants.loginData!.userInfo!.id}_compulsionVip', false);
      compulsionVip=false;
      update();
    }
    Get.until((route) => route.settings.name=='${RouterManager.vipOfOpenOrDetails}?requireVip=true'
        ||route.settings.name==RouterManager.vipOfOpenOrDetails);
    Get.back(result: true);
  }

  /// 获取支付方式配置
  queryAppPayChannel({int? channelType})async{
  Map<String,dynamic> business={
      "userId":Constants.loginData!.userInfo!.userId,
      "appId":"28cb238c-1f8f-44e8-b41d-3e3dcf27c0de",
      "flag":0,
    };
    dynamic data=Constants.getRequestParameter(
        business: business
    );
    QueryAppPayChannelEntity queryAppPayChannelEntity=await DioService<QueryAppPayChannelEntity>().queryAppPayChannel(data);
  loading=false;
  update();
    if(queryAppPayChannelEntity.success??false){
      for(QueryAppPayChannelData queryAppPayChannelData in queryAppPayChannelEntity.data??[]){
        if(Constants.isAuditOrNot){
          if(queryAppPayChannelData.payChannel=='googleplay'){
            if(queryAppPayChannelData.payType==1){
              queryAppPayChannelDataList.add(queryAppPayChannelData);
              int indexWhere=queryAppPayChannelDataList.indexWhere((element) => element.payChannel=="googleplay");
              if(indexWhere!=-1){
                payCurrentIndex=indexWhere;
              }
            }
          }
        }else{
          if(queryAppPayChannelData.payType==channelType){
            queryAppPayChannelDataList.add(queryAppPayChannelData);
            int indexWhere=queryAppPayChannelDataList.indexWhere((element) => element.payChannel=="googleplay");
            if(indexWhere!=-1){
              payCurrentIndex=indexWhere;
            }
          }
        }
      }
      update();
    }
  }


  /// 查询用户前后置充值标识
 queryPayConfigExt()async{
    Map<String,dynamic> business={
      "userId":Constants.loginData!.userInfo!.userId,
      "appId":"28cb238c-1f8f-44e8-b41d-3e3dcf27c0de",
    };
    dynamic data=Constants.getRequestParameter(
        business: business
    );
    QueryPayConfigExtEntity queryPayConfigExtEntity=await DioService<QueryPayConfigExtEntity>().queryPayConfigExt(data);
    if(queryPayConfigExtEntity.success??false){
      queryAppPayChannel(channelType: queryPayConfigExtEntity.data!.channelType);
    }
  }

  /// 充值
  recharge({Function? success})async{
    LoaderOverlayUtil loaderOverlayUtil=LoaderOverlayUtil();
    loaderOverlayUtil.show();
    dynamic extra={
      'msQuery':{
      'channel':moneyConfigDataList[0].channel,
      'itemType':moneyConfigDataList[0].itemType,
      'type':moneyConfigDataList[0].type,
      },
      // 'branch':{
      //   'aaid':'fd0ff8da-2367-41da-996d-13c44b468a4f',
      //   'ip':'192.168.1.170',
      //   'os':'Android',
      // }
    };
  Map<String,dynamic> business={
      'packageAppId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de', // 应用appId
      "appId":"28cb238c-1f8f-44e8-b41d-3e3dcf27c0de", // 用户appId
      "userId":Constants.loginData!.userInfo!.userId, //用户userId
      'appKey':AppPackageInfoUtil.appKey, //版本号
      'deviceId':AppPackageInfoUtil.deviceId, //设备id
      'ip':AppPackageInfoUtil.networkAddress,
      'goodsUniqueCode':moneyConfigDataList[0].configId,// 商品code
      'payPrice':moneyConfigDataList[0].price, //商品支付价格
      'buyGoodsType':1, //商品类型, 0-钻石 1-vip
      // 'payWay':0, //支付渠道
      'currency':'INR',// 币种 1-USD(美元) 2-GBP(英镑) 3-EUR(欧元) 4-INR(印度卢比) 5-TWD(台币) 6-HKD(港币) 7-SAR(沙特里亚尔)
      // 'country':'',//国家
      'channel':'googleplay',
    // "{\"msQuery\":{\"channel\":0,\"itemType\":1,\"type\":0},\"branch\":{\"aaid\":\"fd0ff8da-2367-41da-996d-13c44b468a4f\",\"ip\":\"192.168.1.170\",\"os\":\"Android\"}}
      'extra': jsonEncode(extra),//扩展字段，json格式
      'payChannel':queryAppPayChannelDataList[payCurrentIndex].payChannel,// 支付渠道 googleplay
      // 'pmId':'',// 若该值是paytm.invoke，则说明有paytm客户端
      // 'activityType':0,// 活动类型
      'bizVersion':2,// 业务版本
      'channelType':queryAppPayChannelDataList[payCurrentIndex].payType,//渠道类型 payType
      // 'pageName':'', //invoke pageName
      // 'launchTimes':0, //启动次数
      // 'channelReuseAble':false,// 支付渠道是否启用复用订单
    };
    dynamic data=Constants.getRequestParameter(
        business: business
    );
    RechargeEntity rechargeEntity=await DioService<RechargeEntity>().recharge(data);
    loaderOverlayUtil.hide();
    if(rechargeEntity.success??false){
      Constants.eventBus.on('app:PayMsg',(args) {
        Constants.isOpenMembership=true;
        Get.find<MyController>()..isOpenMembership=true..update();
        Get.find<SedController>()..reload=true..update();
        success?.call();
        update();
      });
      if(jsonDecode(rechargeEntity.data!.extra.toString())['thirdPayUrl']!=null){
        Get.toNamed("${RouterManager.userAgreementOrPrivacyPolicyPage}?title=Payment"
            "&&url=${jsonDecode(rechargeEntity.data!.extra.toString())['thirdPayUrl']}");
      }
    }
  }
}