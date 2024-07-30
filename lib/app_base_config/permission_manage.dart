import 'package:flutter_d0601/app_base_config/custom_permission_bottom_sheet.dart';
import 'package:flutter_d0601/utils/screen_util.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionManage{

  /// 获取位置权限
  static Future<bool?> requestLocationPermission()async{
    bool location=await Permission.location.isGranted;
    if(!(location)){
      return await CustomPermissionBottomSheet.customPermissionManageBottomSheet(title: 'Allow Permissions',
          tips: 'Allow access to the following permissions \nfor better services', itemMap: {
            'location':'Location',
          },
          onTap: ()async{
            await Permission.location.request();
            location =await Permission.location.isGranted;
            Get.back(result: location);
          }
      );
    }
    return true;
  }
  /// 获取通知权限
  static Future<bool?> requestNotificationPermission()async{
    bool notification=await Permission.notification.isGranted;
    if(!(notification)){
      return await CustomPermissionBottomSheet.customPermissionManageBottomSheet(title: 'Allow Permissions',
          tips: 'Allow access to the following permissions \nfor better services', itemMap: {
            'notification':'notification',
          },
          onTap: ()async{
            await Permission.notification.request();
            notification =await Permission.notification.isGranted;
            Get.back(result: notification);
          }
      );
    }
    return true;
  }
  /// 获取文件权限
  static Future<bool?> requestStoragePermission()async{
    bool storage=await Permission.storage.isGranted;
    if(!(storage)){
      return await CustomPermissionBottomSheet.customPermissionManageBottomSheet(title: 'Allow Permissions',
          tips: 'Allow access to the following permissions \nfor better services', itemMap: {
            'storage':'Storage',
          },
          onTap: ()async{
            await Permission.storage.request();
            storage =await Permission.storage.isGranted;
            Get.back(result: storage);
          }
      );
    }
    return true;
  }

  /// 获取相机权限
  static Future<bool?> requestCameraPermission()async{
    bool camera= await Permission.camera.isGranted;
    if(!(camera)){
      return await CustomPermissionBottomSheet.customPermissionManageBottomSheet(title: 'Allow Permissions',
          tips: 'Allow access to the following permissions \nfor better services', itemMap: {
            'camera':'Camera',
          },
          onTap: ()async{
            Map<Permission, PermissionStatus> statuses = await [
              Permission.camera,
              Permission.storage,
            ].request();
            // await Permission.camera.request();
            // camera =await Permission.camera.isGranted;
            camera =statuses[Permission.camera]!.isGranted;
            Get.back(result: camera);
          }
      );
    }
    return true;
  }

  /// 获取相册权限
  static Future<bool?> requestPhotosPermission()async{
    bool photos=await Permission.photos.status.isGranted||await Permission.storage.status.isGranted;
    if(!(photos)){
      return await CustomPermissionBottomSheet.customPermissionManageBottomSheet(title: 'Allow Permissions',
          tips: 'Allow access to the following permissions \nfor better services',
          iconSize: 22.setWidth(),
          itemMap: {
            'photos':'Photos',
          },
          onTap: ()async{
            await Permission.photos.request();
             photos=await Permission.photos.status.isGranted;
            if(!photos){
              await Permission.storage.request();
            }
            photos=await Permission.photos.status.isGranted||await Permission.storage.status.isGranted;
            Get.back(result: photos);
          }
      );
    }
    return true;
  }

  /// 获取麦克风权限
  static Future<bool?> requestMicrophonePermission()async{

    bool microphone=await Permission.microphone.isGranted;
    if(!(microphone)){
      return await CustomPermissionBottomSheet.customPermissionManageBottomSheet(title: 'Allow Permissions',
          tips: 'Allow access to the following permissions \nfor better services', itemMap: {
            'microphone':'Microphone',
          },
          onTap: ()async{
            await Permission.microphone.request();
            microphone =await Permission.microphone.isGranted;
            Get.back(result: microphone);
          }
      );
    }
    return true;
  }


  /// 获取相机及文件权限
  static Future<bool?> requestCameraAndStoragePermission()async{

    bool storage=await Permission.storage.status.isGranted;
    bool camera=await Permission.camera.status.isGranted;

    if(!(storage&&camera)){
       return await CustomPermissionBottomSheet.customPermissionManageBottomSheet(title: 'Allow Permissions',
          tips: 'Allow access to the following permissions \nfor better services', itemMap: {
            'camera':'Camera',
            'storage':'Storage',
          },
          onTap: ()async{
            // await Permission.storage.request();
            // storage=await Permission.storage.isGranted;
            // await Permission.camera.request();
            // camera=await Permission.camera.isGranted;
            Map<Permission, PermissionStatus> statuses = await [
              Permission.camera,
              Permission.storage,
            ].request();
            camera =statuses[Permission.camera]!.isGranted||statuses[Permission.storage]!.isGranted;
            Get.back(result: camera);
          }
      );
    }
    return true;
  }
}

class PermissionManageStatus{
  /// 获取文件权限状态
   static Future<bool> requestStorageStatus(){
    return  Permission.storage.status.isGranted;
  }
  /// 获取位置权限状态
   static Future<bool> requestLocationStatus(){
    return  Permission.location.status.isGranted;
  }
  /// 获取相机权限状态
   static Future<bool> requestCameraStatus(){
    return  Permission.camera.status.isGranted;
  }

  /// 获取麦克风权限状态
   static Future<bool> requestMicrophoneStatus(){
    return  Permission.microphone.status.isGranted;
  }
  /// 获取相册权限状态
   static Future<bool> requestPhotosStatus()async{
    return  await Permission.photos.status.isGranted||await Permission.storage.status.isGranted;
  }
}