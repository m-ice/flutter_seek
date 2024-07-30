
import 'dart:async';
import 'package:flutter_d0601/controller/discover_controller.dart';
import 'package:flutter_d0601/controller/my_controller.dart';
import 'package:flutter_d0601/controller/sed_controller.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_d0601/utils/toast_util.dart';

import '../common/constants.dart';
import '../controller/circle_controller.dart';
import '../page/router/router_manager.dart';
import 'app_package_info_util.dart';

class NetWorkUtil{

  NetWorkUtil._privateConstructor();
  static NetWorkUtil? _networkDetection;

  static NetWorkUtil getInstance() {
    _networkDetection ??= NetWorkUtil._privateConstructor();
    return _networkDetection!;
  }

  /// 是否进入app
  static bool whetherToEnterTheApp=false;
  /// 网络状态
  static bool netWorkState=true;

  /// todo：网络监听器
  static StreamSubscription? subscription;

  /// todo：检测网络连通性
  static checkNetStatus() async {
    subscription?.cancel();
    subscription=null;
    //_subscription首次无法检测，后续由_subscription监听
    //------------------------------------------------
    var connectivityResult = await (Connectivity().checkConnectivity());
    setNetStatus(connectivityResult);
    //-------------------------------------------------
    // 网络状态监听器
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setNetStatus(result);
    });
  }

  static getAllData(bool state){
    if(!state){
      try{
        Get.find<SedController>().initCardData();
        Get.find<SedController>().isCompulsionVip();
        Get.find<CircleController>().querySeekLikesVisitors();
        Get.find<DiscoverController>().initSdk();
        Get.find<DiscoverController>()..feedback=0..update();
        Constants.eventBus.off('insertOrUpdateConversation');
        Constants.eventBus.on('insertOrUpdateConversation', (args) {
          Get.find<DiscoverController>().insertConversation(args);
        });
        Get.find<DiscoverController>()..feedback=0..update();
        Get.find<DiscoverController>().quickReplyMessages();
        Get.find<DiscoverController>().getConversationsRecord();
        Get.find<MyController>().queryUser();
        Get.find<MyController>().getUserAccountDetail();
        Get.find<MyController>().moneyConfig();
      }catch(e){
        debugPrint("网络异常 组件异常");
      }
    }

  }

  /// todo：设置网络状态
  static setNetStatus(result) {
    if (result == ConnectivityResult.mobile) {
      getAllData(netWorkState);
      netWorkState=true;
      AppPackageInfoUtil.getNetWorkAddress();
      debugPrint("连入移动网络:$result");
    } else if (result == ConnectivityResult.wifi) {
      getAllData(netWorkState);
      netWorkState=true;
      AppPackageInfoUtil.getNetWorkAddress();
      debugPrint("连入WIFI网络:$result");
    } else {
      // if(result == ConnectivityResult.none){
      //   toast("network error");
      // }
      netWorkState=false;
      if(!whetherToEnterTheApp){
        toast("network error");
        if(Constants.loginData!=null&&Constants.loginData!.userInfo!=null){
          Get.offAllNamed(RouterManager.home);
        }else{
          Get.offAllNamed(RouterManager.login);
        }
      }

    }
  }
}