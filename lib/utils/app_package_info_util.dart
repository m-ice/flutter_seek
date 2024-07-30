import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_d0601/utils/log_util.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppPackageInfoUtil{
  static PackageInfo? packageInfo;
  static String? deviceId;
  ///规则是 1xxxxx01 中间五位代表版本号，首位1代表安卓，2代表IOS 后边01固定，注意跟header中的appKey区分
  static String? appKey;
  /// 当前安装包的版本号
  static String currentVersion='1.0.0';

  static String? networkAddress;
  /// 获取包信息 设备id
  static Future getPackageInfo()async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // customPackageInfo=CustomPackageInfo(
    //   appName: packageInfo.appName,
    //   packageName: packageInfo.packageName,
    //   version: packageInfo.version,
    //   buildNumber: packageInfo.buildNumber,
    // );
    currentVersion=packageInfo.version.toString();
    LogUtil.logUtil('安装包信息：');
    LogUtil.logInfo(packageInfo);
    LogUtil.logUtil('设备信息：');
    final deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      deviceId=androidInfo.id;
      appKey='1${packageInfo.version.toString().replaceAll('.', '')}01';
      LogUtil.logInfo(androidInfo);
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo =  await deviceInfoPlugin.iosInfo;
      // 在 iOS 中，我们使用 identifierForVendor 作为设备 ID
      deviceId=iosInfo.identifierForVendor;
      appKey='2${packageInfo.version.toString().replaceAll('.', '0')}01';
      LogUtil.logInfo(iosInfo);
    }
    getNetWorkAddress();
  }

  /// 获取网络ip
 static getNetWorkAddress()async{
    for (var interface in await NetworkInterface.list()) {
      for (var address in interface.addresses) {
        LogUtil.logUtil('${interface.name}:${address.address}');
        if(interface.name=='wlan0'){
          networkAddress=address.address;
        }
        if(networkAddress==null&&interface.name=='rmnet_data4'&&address.address.length<16){
          networkAddress=address.address;
        }
      }
    }
  }
}

