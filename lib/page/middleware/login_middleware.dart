import 'package:flutter/material.dart';
import 'package:flutter_d0601/page/router/router_manager.dart';
import 'package:flutter_d0601/utils/custom_library/custom_library_export_util.dart';
import 'package:get/get.dart';

import '../../common/constants.dart';
import '../../controller/personal_basicInformation_controller.dart';
import '../../enum/cache_data_enum.dart';

class LoginMiddleware extends GetMiddleware{

  @override
  RouteSettings? redirect(String? route){
    Constants.loginData=CacheUserDataUtil.getCacheLoginData(CacheDataEnum.loginData);
    RouteSettings? routeSettings;
    if(Constants.loginData!=null&&Constants.loginData!.userInfo!=null){
      if(Get.find<PersonalBasicInformationController>().personalInfoDataItemListTmp.isNotEmpty){
        routeSettings=  const RouteSettings(name: RouterManager.personalBasicInformation);
      }else{
        routeSettings= const RouteSettings(name: RouterManager.home);
      }
      return routeSettings;
    }
    return null;
  }

}
