import 'dart:async';

import 'package:flutter_d0601/http/http_config.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';


class LoaderOverlayUtil{
  Timer? timer;
   void show(){
     hide();
    if(!Get.context!.loaderOverlay.visible){
      Get.context!.loaderOverlay.show();
      timer=Timer(Duration(seconds: 2,milliseconds: HttpConfig.receiveTimeout), (){
        hide();
      });
    }
  }

   void hide(){
    if(Get.context!.loaderOverlay.visible){
      Get.context!.loaderOverlay.hide();
      timer?.cancel();
    }
  }
}
