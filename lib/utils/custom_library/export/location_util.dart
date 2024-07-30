import 'dart:async';

import 'package:flutter_d0601/utils/log_util.dart';
import 'package:flutter_z_location/flutter_z_location.dart';
import 'package:location/location.dart';

class LocationUtil{
  /// 获取当前位置
  static Future<GeocodeEntity?> getCurrentLocation()async{
    // Location location = Location();
    // LocationData? locationData=await Future<LocationData?>.delayed(const Duration(milliseconds: 300),()async{
    //   try{
    //     LocationData locationDataTmp=await location.getLocation();
    //     LogUtil.logInfo(locationDataTmp);
    //     return locationDataTmp;
    //   }catch(e){
    //     return null;
    //   }
    // });
    // return locationData;
    // bool res= await getLocationService();
    // if(res){
    //   LocationData locationData=await Future<LocationData>.delayed(const Duration(milliseconds: 300),()async{
    //     LocationData locationDataTmp=await location.getLocation();
    //     LogUtil.logInfo(locationDataTmp);
    //     return locationDataTmp;
    //   });
    //   // // 获取GPS定位经纬度
    //   // final coordinate = await FlutterZLocation.getCoordinate();
    //   // // 经纬度反向地理编码获取地址信息(省、市、区)
    //   // final res1 = await FlutterZLocation.geocodeCoordinate(coordinate.latitude, coordinate.longitude, pathHead: 'assets/');
    //   // // 获取ip地址
    //   // final ipStr = await FlutterZLocation.getIp();
    //   // // 经纬度反向地理编码获取地址信息(省、市、区)
    //   // final res2 = await FlutterZLocation.geocodeIp(ipStr, pathHead: 'assets/');
    //   // LogUtil.logInfo(res1);
    //   // LogUtil.logInfo(ipStr);
    //   // LogUtil.logUtil("定位信息8888--$res");
    //   // LogUtil.logInfo(res2);
    //   return locationData;
    // }else{
    //   // return const GeocodeEntity(province: '', provinceId: '', city: '', cityId: '', district: '', districtId: '', latitude: 0, longitude: 0);
    //   return null;
    // }

    try{
      // 获取GPS定位经纬度
      final coordinate = await FlutterZLocation.getCoordinate();
      // 经纬度反向地理编码获取地址信息(省、市、区)
      // final res1 = await FlutterZLocation.geocodeCoordinate(coordinate.latitude, coordinate.longitude, pathHead: 'assets/');
      // 获取ip地址
      final ipStr = await FlutterZLocation.getIp();
      // 经纬度反向地理编码获取地址信息(省、市、区)
      final res2 = await FlutterZLocation.geocodeIp(ipStr, pathHead: 'assets/');
      // LogUtil.logInfo(res1);
      LogUtil.logInfo(ipStr);
      LogUtil.logUtil("定位信息8888--${coordinate.longitude}---${coordinate.latitude}");
      LogUtil.logInfo(res2);
      return res2;
    }catch(e){
      return null;
    }

  }
  static Future<bool> getLocationService()async{
    Location location = Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      // // 定位服务没有开启，请求用户打开系统设置打开定位服务
      // serviceEnabled = await location.requestService();
      // if (!serviceEnabled) {
      //   // 用户拒绝打开定位服务
      //   return false;
      // } else {
      //   // 用户已经打开定位服务
      //   return true;
      // }
      return false;
    }
    else {
      // 定位服务已经开启
      return true;
    }
  }
}

