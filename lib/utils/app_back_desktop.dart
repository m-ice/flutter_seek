import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AppBackDesktop{

  
  static const String channel="android/back/desktop";
  static backDesktop()async{
    const methodChannel= MethodChannel(channel);
    try{
      bool res=await methodChannel.invokeMethod("backDesktop");
      if (res) debugPrint('返回到桌面');
    }catch(e){
      debugPrint("返回桌面失败：$e");
    }
    // channel.setMethodCallHandler((call) => null)
  }

}