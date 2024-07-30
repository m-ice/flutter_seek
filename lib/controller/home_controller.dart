import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_d0601/controller/sed_controller.dart';
import 'package:flutter_d0601/http/dio_service.dart';
import 'package:flutter_d0601/page/home/discover/discover_page.dart';
import 'package:flutter_d0601/page/home/my/my_page.dart';
import 'package:flutter_d0601/page/home/sed/sed_page.dart';
import 'package:flutter_d0601/page/home/circle/circle_page.dart';
import 'package:flutter_d0601/page/model/audit_switch_entity.dart';
import 'package:flutter_d0601/page/model/base_entity.dart';
import 'package:flutter_d0601/utils/app_package_info_util.dart';
import 'package:flutter_d0601/utils/custom_library/custom_library_export_util.dart';
import 'package:get/get.dart';

import '../common/constants.dart';
import '../utils/log_util.dart';

class HomeController extends GetxController{

  int selectedIndex=0;
  List<ButtonIcon> barItemList=[
  ButtonIcon("un_choose_sed","choose_sed"),
  ButtonIcon("un_choose_swipe","choose_swipe"),
  ButtonIcon("un_choose_discover","choose_discover"),
  ButtonIcon("un_choose_my","choose_my"),
  ];
  // bool showGuideList=false;
  List<Widget> tabViewList=const [
    SedPage(),
    CirclePage(),
    DiscoverPage(),
    MyPage(),
  ];

  void onItemTapped(int index) {
    selectedIndex = index;
    Get.find<SedController>().disposeOverLayEntry();
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // DBUtil.initDB();
    auditSwitch();
    requestCacheData();
    // checkNetStatus();
    appEventInform();
  }

  /// 是否展示引导图
  bool showGuide=false;
  AnimationController? animationController;
  /// 获取缓存的用户数据
  requestCacheData(){
    showGuide= CacheUserDataUtil.getBoolData('showGuide_${Constants.loginData!.userInfo!.id}')??true;
    Constants.blockDataList= CacheUserDataUtil.getStringListData('blockData_${Constants.loginData!.userInfo!.id}');
    Constants.alreadyChatDataList= CacheUserDataUtil.getStringListData('alreadyChatData_${Constants.loginData!.userInfo!.id}');
    Constants.alreadyMatchDataList= CacheUserDataUtil.getStringListData('alreadyMatchData_${Constants.loginData!.userInfo!.id}');
    update();
    LogUtil.logUtil("拉黑的用户数据：${Constants.blockDataList}");
    LogUtil.logUtil("已聊过天数据：${Constants.alreadyChatDataList}");
    LogUtil.logUtil("已经匹配过数据：${Constants.alreadyMatchDataList}");
    LogUtil.logUtil("引导图显示状态：$showGuide");
  }
  Timer? timer;
  Function? showGuideAnimation;

  /// 版本审核开关
  auditSwitch()async{
    if(Constants.loginData!.userInfo==null) return;
    Map<String,dynamic> business={
      'appId': Constants.loginData!.userInfo!.appId,//用户appId
      'userId': Constants.loginData!.userInfo!.userId,//用户id
    };
    dynamic data=Constants.getRequestParameter(
        business: business
    );
    AuditSwitchEntity auditSwitchEntity=await DioService<AuditSwitchEntity>().auditSwitch(data);
    if(auditSwitchEntity.success??false){
      ///结果中paySwitch = 0，代表为审核中版本
      Constants.isAuditOrNot=(Constants.loginData!.outRole==1||auditSwitchEntity.data!.paySwitch==0);
      print('代表为审核中版本${Constants.isAuditOrNot}--${Constants.loginData!.outRole==1}---${auditSwitchEntity.data!.paySwitch==0}');
      // moneyConfigDataList=moneyConfigEntity.data??[];
      update();
    }
  }
  /// 存储引导图显示状态
  showGuideClick()async{
    if(showGuide){
      showGuide=false;
      await CustomCacheUtil.putBool('showGuide_${Constants.loginData!.userInfo!.id}',false);
      animationController!.stop();
      animationController!.dispose();
      timer?.cancel();
      update();
    }
  }
  appEventInform({dynamic business})async{
     business??={
      //事件 first_login_homepage 首次登录user_reply_robot用户回复机器人，user_like_robot用户喜欢机器人，
      // user_open_app_process用户开启进程，private_chat_page_call私聊页Call，details_page_call详情Call，
      // user_connect_anchor用户跟主播发消息或免费call，link_exactly_G非random连麦（G机器人），user_register用户注册时触发
      "event":"user_open_app_process",
      "userId":Constants.loginData!.userInfo!.userId,
      "appId":"28cb238c-1f8f-44e8-b41d-3e3dcf27c0de",
      "appKey":AppPackageInfoUtil.appKey,
      "deviceId":AppPackageInfoUtil.deviceId,
      "productId":301
    };
    dynamic data=Constants.getRequestParameter(
        business: business
    );
    BaseEntity baseEntity=await DioService<BaseEntity>().appEventInform(data);
      if(baseEntity.success??false){
        LogUtil.logInfo('App成功启动线程');
      }
  }
}
//底部图标
class ButtonIcon{
  String icon;
  String activeIcon;
  Widget? page;
  ButtonIcon(this.icon, this.activeIcon,{this.page});
}
