import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_oss_aliyun/flutter_oss_aliyun.dart';

import '../../../common/constants.dart';
import '../../../http/dio_service.dart';
import '../../../page/model/upload_resource_configuration_entity.dart';
import '../../app_package_info_util.dart';

class UploadOssUtil{
  static UploadResourceConfigurationData? uploadResourceConfigurationData;
  static Future<Map<String,dynamic>?> uploadOss({required File file,required int sort,Function? onSendProgress,Function? onReceiveProgress}) async {
    String fileName='headImg_${Constants.loginData!.userInfo!.userId}_${DateTime.now().microsecondsSinceEpoch}_$sort.jpg';
    Map<String,dynamic> business={
      'productId':1,//QA环境jpg传1，MP4传4，其他格式限制
      'packageAppId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',//马甲包appId
      'appId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',//用户appId
      'appKey':AppPackageInfoUtil.appKey,//客户端版本号
      'device':AppPackageInfoUtil.deviceId,// 设备号
      'userId':Constants.loginData!.userInfo!.userId,//用户userId
      'fileName':fileName,////文件名 eg: xxx.jpg
    };
    dynamic data=Constants.getRequestParameter(business: business,productId: 1);
    UploadResourceConfigurationEntity uploadResourceConfigurationEntity=await DioService<UploadResourceConfigurationEntity>().upload(data);
    if(uploadResourceConfigurationEntity.success??false){
      uploadResourceConfigurationData=uploadResourceConfigurationEntity.data;
      String  address= await aLiyOssUpload(
        file: file,
          fileName: fileName,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress
      );
      return {"title":fileName,"address":address,'sort':sort};
    }else{
      return null;
    }
  }

  static FutureOr<Auth> _authGetter(){
    return Auth(
      accessKey: "${uploadResourceConfigurationData!.accessKey}",
      accessSecret: "${uploadResourceConfigurationData!.accessSecret}",
      expire: '${DateTime.now().add(Duration(seconds: uploadResourceConfigurationData!.expirySeconds??0))}',
      secureToken: "${uploadResourceConfigurationData!.securityToken}",
    );
  }
  static Future<String> aLiyOssUpload({required File file,required String fileName,Function? onSendProgress,Function? onReceiveProgress})async{
    // Dio dio=Dio(BaseOptions(connectTimeout: const Duration(milliseconds: 9000),receiveTimeout: const Duration(milliseconds: 3000)));
    // for (var element in [ LogInterceptors()]) {
    //   dio.interceptors.add(element);
    // }
    Client.init(
      // stsUrl: "${uploadResourceConfigurationData!.uploadHost}",
      ossEndpoint: uploadResourceConfigurationData!.uploadHost.toString().replaceFirst('https://', ''),
      bucketName: "${uploadResourceConfigurationData!.bucket}",
      authGetter: _authGetter,
      dio: Dio(BaseOptions(connectTimeout: const Duration(milliseconds: 9000),receiveTimeout: const Duration(milliseconds: 3000))),
    );
    // final bytes = "file bytes".codeUnits;
    final bytes = file.readAsBytesSync();

    // await Client().putObjects([
    //   AssetEntity(
    //     filename: uploadResourceConfigurationData!.filePath!,
    //     bytes: bytes,
    //     option: PutRequestOption(
    //       onSendProgress: (count, total) {
    //         onSendProgress?.call(count,total);
    //       },
    //       onReceiveProgress: (count, total) {
    //         onReceiveProgress?.call(count,total);
    //       },
    //       aclModel: AclMode.private,
    //     ),
    //   ),
    // ]);
    await Client().putObject(
      bytes,
      uploadResourceConfigurationData!.filePath!,
      option: PutRequestOption(
        onSendProgress: (count, total) {
          debugPrint("send: count = $count, and total = $total");
          onSendProgress?.call(count,total);
        },
        onReceiveProgress: (count, total) {
          debugPrint("receive: count = $count, and total = $total");
          onReceiveProgress?.call(count,total);
        },
        override: false,
        aclModel: AclMode.publicRead,
        storageType: StorageType.ia,
        headers: {"cache-control": "no-cache"},
      ),
    );

    return 'https://${uploadResourceConfigurationData!.domain}/${uploadResourceConfigurationData!.filePath}';
  }
}