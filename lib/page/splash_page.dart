import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_d0601/page/router/router_manager.dart';
import 'package:flutter_d0601/page/widgets/back_ground_widget.dart';
import 'package:flutter_d0601/page/widgets/image_widget.dart';
import 'package:flutter_d0601/utils/network_util.dart';
import 'package:flutter_d0601/utils/resource_util.dart';
import 'package:flutter_d0601/utils/screen_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_d0601/utils/custom_library/custom_library_export_util.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../common/constants.dart';
import '../controller/splash_controller.dart';
import '../enum/cache_data_enum.dart';
import '../utils/log_util.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final splashController=Get.find<SplashController>();
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countDown();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    NetWorkUtil.whetherToEnterTheApp=true;
  }
  /// 倒计时 进入下一个页面
  void countDown() async{
    timer=Timer(const Duration(seconds: 3), newHomePage);
     if(Constants.loginData!=null){
       // DBUtil.initDB();
       if(Constants.loginData!.userInfo!.isRegister == 0){
         Constants.loginData!.userInfo!.isRegister = 1;
         splashController.update();
         await CustomCacheUtil.putObject(CacheDataEnum.loginData.toString(), Constants.loginData??'');
       }
       Future.wait([
         getLocation(),
         splashController.queryUserAiTag(
             success: (){
               timer?.cancel();
               if(splashController.settingItemCount>0){
                 Get.offNamed("${RouterManager.personalBasicInformation}?isRegister=1");
               }else{
                 Get.offNamed(RouterManager.home);
               }
             }
         ),
       ]);
     }
  }

  Future<void> getLocation()async{
    bool locationPermission=await Permission.location.isGranted;
    if(locationPermission){
      LogUtil.logInfo("获取位置信息");
      final locationData=await LocationUtil.getCurrentLocation();
      if(locationData!=null){
        Constants.latitude=locationData.latitude;
        Constants.longitude=locationData.longitude;
      }
    }
  }
  void newHomePage() async{
    if(Constants.loginData==null){
      Get.offNamed(RouterManager.login);
    }
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        context,
        designSize: const Size(360, 800), // 设计图尺寸
        minTextAdapt: true);
    return  GetBuilder<SplashController>(
      init: splashController,
      builder: (context) {
        return Scaffold(
          body: BackGroundWidget(backGroundName: "bg_1", child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.setRadius())),
                    child: ImageWidget(url: ResourceUtil.getAppPageIcon("start1"), width: 72.setWidth(), height: 72.setWidth())),
                Padding(
                    padding: EdgeInsets.only(top: 11.11.setHeight()),
                    child: ImageWidget(url: ResourceUtil.getAppPageIcon("start2"), width: 68.setWidth(), height: 24.setWidth())),
              ],
            ),
          )),
        );
      }
    );
  }
}

