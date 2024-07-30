
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_d0601/controller/edit_profile_controller.dart';
import 'package:flutter_d0601/enum/personal_Info_class.dart';
import 'package:flutter_d0601/http/dio_service.dart';
import 'package:flutter_d0601/page/home/my/model/regular_photo_album_entity.dart';
import 'package:flutter_d0601/page/home/sed/model/user_ai_tag_enums_entity.dart';
import 'package:flutter_d0601/page/model/base_entity.dart';
import 'package:flutter_d0601/utils/toast_util.dart';
import 'package:get/get.dart';
import 'package:flutter_d0601/utils/custom_library/custom_library_export_util.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../common/constants.dart';
import '../enum/cache_data_enum.dart';
import '../page/router/router_manager.dart';
import '../utils/app_package_info_util.dart';
import '../utils/log_util.dart';



class PersonalBasicInformationController extends GetxController{
  PageController pageController=PageController();
  int currentIndex=0;
  FocusNode nameFocusNode=FocusNode();
  TextEditingController textEditingControllerName=TextEditingController();
  bool loading=false;
  /// 选择的出生日期
  DateTime selectedDate=DateTime(2000,1,1);
  /// 名称内容
  String? restrictionName;
  /// 相册列表
  List imageList=List.filled(6, null);
  List haveFaceList=List.filled(6, null);

  /// 个性列表
  List<UserAiTagEnumsDataPersonality> personalityList=[];
  /// 目的列表
  List<UserAiTagEnumsDataPurpose> purposeList=[];
  /// 兴趣列表
  List<UserAiTagEnumsDataInterest> interestList=[];
  List<PersonalInfoDataItem> personalInfoDataItemList=[
    PersonalInfoDataItem(title: "What's your gender?",personalInfoClass: PersonalInfoClass.setSexKey, chooseList: ['Women','MEN']),
    PersonalInfoDataItem(title: "What's your name?",personalInfoClass: PersonalInfoClass.setNameKey, chooseList: []),
    PersonalInfoDataItem(title: "What's your date of birth?",personalInfoClass: PersonalInfoClass.setBirthKey, chooseList: []),
    PersonalInfoDataItem(title: "What are you here for?",personalInfoClass: PersonalInfoClass.setHereForKey, chooseList: []),
    PersonalInfoDataItem(title: "Personal Style",personalInfoClass: PersonalInfoClass.setPersonalStyleKey, chooseList: []),
    PersonalInfoDataItem(title: "Your interests",personalInfoClass: PersonalInfoClass.setInterestsKey, chooseList: []),
    PersonalInfoDataItem(title: "Upload your photos",personalInfoClass: PersonalInfoClass.setPhotoKey, chooseList: []),
  ];

  List<PersonalInfoDataItem> personalInfoDataItemListTmp=[];
  Map<String,dynamic> businessMap={};
  Map<String,dynamic> businessMapTmp={};
  bool isMonomial=false;
  int? isRegister;

  @override
  void onInit(){
    super.onInit();
    LogUtil.logUtil('更改个人基础信息PersonalBasicInformationController初始化$isMonomial');
    isRegister=int.tryParse(Get.parameters['isRegister']??'0');
    update();
    // Constants.loginData=CacheUserDataUtil.getCacheLoginData(CacheDataEnum.loginData);
  }

  /// 初始化数据
  initData(){
    listUserAiTagEnums();
    queryUserAiTag();
  }

  /// 参数格式化
  dataFormatting({required String key,required List list})async{
    businessMap[key]=null;
    for(var item in list){
      if(businessMap[key]!=null){
        businessMap[key]+=',$item';
      }else{
        businessMap[key]=item.toString();
      }
    }
    update();
  }
  /// 提交信息
  submitUserInfo({bool isSetTag=false,required PersonalInfoClass personalInfoClass}){
    if(personalInfoClass!=PersonalInfoClass.setPhotoKey){
      if(isSetTag){
        updateUserAiTag(success: (){
          switchPage();
          businessMap={};
          update();
        });
      }else{
        updateUser(success: (){
          switchPage();
          businessMap={};
          update();
        });
      }
    }else{
      albumUpdate(
          upload: true,
          success: (){
        switchPage();
        update();
      });
    }
  }

  switchPage(){
    if(!isMonomial){
      if(personalInfoDataItemListTmp[currentIndex].personalInfoClass ==
          personalInfoDataItemListTmp[personalInfoDataItemListTmp.length-1].personalInfoClass) {
        Get.offNamed(RouterManager.home);
      } else {
        pageController.nextPage(duration: const Duration(microseconds: 300), curve: Curves.ease);
      }
    }else{
      Get.back(result: true);
    }
  }

  /// 修改用户信息
  updateUser({Function? success})async{
    if(loading)return ;
    loading=true;
    update();
    Map<String,dynamic> business={
      // 'countryCode':'US',//国家码，ISO 3166-1对应的两位大写
      // 'device':AppPackageInfoUtil.deviceId,// 设备号
      // 'sign':MD5Util.generateMd5("28cb238c-1f8f-44e8-b41d-3e3dcf27c0de7TvmahX0289h523RueRa5G2fv0NSIshw8Cq21B6dwD78I698wECoKp0vEFPgB2gn"),//签名，appId+appSecret  md5 to upperCase，其中appSecret由server提供
      // 'appId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',//用户appId
      // 'appKey':AppPackageInfoUtil.appKey,//客户端版本号
      // 'productId':301,//产品id，301
      'userId':Constants.loginData!.userInfo!.userId,//用户userId
    };
    business.addAll(businessMap);
    dynamic data=Constants.getRequestParameter(
        business: business
    );
    BaseEntity baseEntity=await DioService<BaseEntity>().updateUser(data);
    loading=false;
    update();
    if(baseEntity.success??false){
      updateCacheLoginUserInfo(businessMap);
      success?.call();
    }
  }

  /// 缓存的当前登录用户信息
  updateCacheLoginUserInfo(dynamic data)async{
    LogUtil.logUtil('缓存的用户信息发生了变更:$data');
    if(data['sex']!=null){
      Constants.loginData?.userInfo?.sex=data['sex'];
    }
    if(data['nickname']!=null){
      Constants.loginData?.userInfo?.nickname=data['nickname'];
    }
    if(data['birthday']!=null){
      Constants.loginData?.userInfo?.birthday=data['birthday'];
    }
    if(data['profile']!=null||data['profile']==''){
      Map map=jsonDecode(Constants.loginData!.userInfo!.extendInfo.toString());
      map['profile']= data['profile'];
      Constants.loginData!.userInfo!.extendInfo=jsonEncode(map);
    }
    await CustomCacheUtil.putObject(CacheDataEnum.loginData.toString(), Constants.loginData??'');
    if(isMonomial){
      Get.find<EditProfileController>().update();
    }
  }

  /// 上传进度
  Map<int,double?> uploadProgressMap={};
  /// 新上传的图片
  Set<int> newUploadImageList={};

  ///相册添加修改  upload是否需要上传资源
  albumUpdate({Function? success,RegularPhotoAlbumItems? del,bool upload=false})async{
    if(!(Constants.loginData!=null&&Constants.loginData!.userInfo!=null)||loading) return ;
    loading=true;
    update();
    List list=[];
    if(upload){
      for(int i=0;i<imageList.length;i++){
        int indexWhere=imageList.indexWhere((element) => element is AssetEntity);
        if(indexWhere!=-1){
          File? file=await imageList[indexWhere].file;
          Map? map=await UploadOssUtil.uploadOss(file: file!,sort: indexWhere,onSendProgress: (count,data){
            uploadProgressMap[indexWhere]=count*100/data;
            update();
          },onReceiveProgress: (count,data){
            uploadProgressMap[indexWhere]=null;
            update();
          });
          if(map!=null){
            uploadProgressMap[map['sort']??0]=null;
            update();
            imageList[map['sort']??0]=map;
            newUploadImageList.add(map['sort']??0);
            update();
          }
        }
      }
    }
    for(var item in imageList){
      if(item is Map){
        if(newUploadImageList.contains(item['sort'])){
          list.add(item);
        }
      }
      if(item is AssetEntity){
        return toast('The picture is uploading...');
      }
    }
    Map<String,dynamic> business={
      // 'countryCode':'US',//国家码，ISO 3166-1对应的两位大写
      // 'device':AppPackageInfoUtil.deviceId,// 设备号
      // 'sign':MD5Util.generateMd5("28cb238c-1f8f-44e8-b41d-3e3dcf27c0de7TvmahX0289h523RueRa5G2fv0NSIshw8Cq21B6dwD78I698wECoKp0vEFPgB2gn"),//签名，appId+appSecret  md5 to upperCase，其中appSecret由server提供
      'productId':301,//产品id，301
      'appId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',//用户appId
      'appKey':AppPackageInfoUtil.appKey,//客户端版本号
      'userId':Constants.loginData!.userInfo!.userId,//用户userId
    };
    if(del==null){
      business['newAddress']=jsonEncode(list);
    }else{
      business['deleteId']='${del.id}';
    }
    dynamic data=Constants.getRequestParameter(business: business);
    BaseEntity baseEntity=await DioService<BaseEntity>().albumUpdate(data);
    loading=false;
    update();
    if(baseEntity.success??false){
      // toast('${baseEntity.message}');
      if(upload){
        if(imageList.isNotEmpty&&imageList[0]!=null){
          Constants.loginData!.userInfo!.headImg=imageList[0]['address'];
          await CustomCacheUtil.putObject(CacheDataEnum.loginData.toString(), Constants.loginData??'');
        }
      }
      newUploadImageList={};
      update();
      success?.call();

    }
  }

  /// 普通相册
  List<RegularPhotoAlbumItems>? photoAlbumList=[];
  ///查询普通相册列表
  albumList({Function? success})async{
    Map<String,dynamic> business={
      'packageAppId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',//马甲包appId
      'appId':Constants.loginData!.userInfo!.appId,//用户appId
      'lang':'en',//语言
      'appKey':AppPackageInfoUtil.appKey,//客户端版本号
      'deviceId':AppPackageInfoUtil.deviceId,// 设备号
      'userId':Constants.loginData!.userInfo!.userId,//用户userId
      'pageNo':1,//页码
      'pageSize':16,//页宽
    };
    dynamic data=Constants.getRequestParameter(business: business);
    RegularPhotoAlbumEntity albumEntity=await DioService<RegularPhotoAlbumEntity>().albumList(data);
    if(albumEntity.success??false){
      updatePersonalInfoClassList(personalInfoClass: PersonalInfoClass.setPhotoKey,data: albumEntity.items);
      for(RegularPhotoAlbumItems items in albumEntity.items??[]){
        int sort=items.sort??0;
        if(imageList.length>sort){
          imageList[sort]=items;
          haveFaceList[sort]=items.haveFace;
        }
      }
      update();
      success?.call();
    }
  }
  /// 查询供选择的AI标签
  listUserAiTagEnums({Function? success})async{
    if(!(Constants.loginData!=null&&Constants.loginData!.userInfo!=null)) return ;
    Map<String,dynamic> business={
      // 'countryCode':'US',//国家码，ISO 3166-1对应的两位大写
      // 'device':AppPackageInfoUtil.deviceId,// 设备号
      // 'sign':MD5Util.generateMd5("28cb238c-1f8f-44e8-b41d-3e3dcf27c0de7TvmahX0289h523RueRa5G2fv0NSIshw8Cq21B6dwD78I698wECoKp0vEFPgB2gn"),//签名，appId+appSecret  md5 to upperCase，其中appSecret由server提供
      // 'appKey':AppPackageInfoUtil.appKey,//客户端版本号
      // 'productId':301,//产品id，301
      'appId':Constants.loginData!.userInfo!.appId,//用户appId
      'userId':Constants.loginData!.userInfo!.userId,//用户userId
    };
    dynamic data=Constants.getRequestParameter(business: business);
    UserAiTagEnumsEntity userAiTagEnumsEntity=await DioService<UserAiTagEnumsEntity>().listUserAiTagEnums(data);
    if(userAiTagEnumsEntity.success??false){
      personalityList=userAiTagEnumsEntity.data!.personality??[];
      purposeList=userAiTagEnumsEntity.data!.purpose??[];
      interestList=userAiTagEnumsEntity.data!.interest??[];
      update();
    }
  }
  /// 查询个人AI标签
  queryUserAiTag({Function? success})async{
    if(!(Constants.loginData!=null&&Constants.loginData!.userInfo!=null)) return ;
    update();
    // AppPackageInfoUtil.getPackageInfo();
    Map<String,dynamic> business={
      // 'countryCode':'US',//国家码，ISO 3166-1对应的两位大写
      // 'device':AppPackageInfoUtil.deviceId,// 设备号
      // 'sign':MD5Util.generateMd5("28cb238c-1f8f-44e8-b41d-3e3dcf27c0de7TvmahX0289h523RueRa5G2fv0NSIshw8Cq21B6dwD78I698wECoKp0vEFPgB2gn"),//签名，appId+appSecret  md5 to upperCase，其中appSecret由server提供
      // 'appId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',//用户appId
      // 'appKey':AppPackageInfoUtil.appKey,//客户端版本号
      // 'productId':301,//产品id，301
      'userId':Constants.loginData!.userInfo!.userId,//用户userId
    };
    dynamic data=Constants.getRequestParameter(business: business);
    UserAiTagEnumsEntity? userAiTagEnumsEntity;
    try{
      userAiTagEnumsEntity=await DioService<UserAiTagEnumsEntity>().queryUserAiTag(data);
    }catch(err){
      toast('network error');
      err.printError();
    }

    if(userAiTagEnumsEntity!=null&&(userAiTagEnumsEntity.success??false)){
      if(userAiTagEnumsEntity.data!=null){
        if(userAiTagEnumsEntity.data!.interest!=null){
          businessMapTmp['interestTag']=userAiTagEnumsEntity.data!.interest!.map((e) => e.id).toList();
        }
        if(userAiTagEnumsEntity.data!.purpose!=null){
          businessMapTmp['purposeTag']=userAiTagEnumsEntity.data!.purpose!.map((e) => e.id).toList();
        }
        if(userAiTagEnumsEntity.data!.personality!=null){
          businessMapTmp['personalityTag']=userAiTagEnumsEntity.data!.personality!.map((e) => e.id).toList();
        }
      }
      personalInfoDataItemListTmp=[];
      if(Constants.loginData!=null&&Constants.loginData!.userInfo!=null){
        if(isRegister == 0){
          personalInfoDataItemListTmp=personalInfoDataItemList;
        }else{
          updatePersonalInfoClassList(personalInfoClass: PersonalInfoClass.setSexKey,data: Constants.loginData!.userInfo!.sex!=null&&Constants.loginData!.userInfo!.sex==2?null:Constants.loginData!.userInfo!.sex);
          updatePersonalInfoClassList(personalInfoClass: PersonalInfoClass.setNameKey,data: Constants.loginData!.userInfo!.nickname);
          updatePersonalInfoClassList(personalInfoClass: PersonalInfoClass.setBirthKey,data: Constants.loginData!.userInfo!.birthday);
          updatePersonalInfoClassList(personalInfoClass: PersonalInfoClass.setHereForKey,data: userAiTagEnumsEntity.data!.purpose);
        }
        if(Constants.loginData!.userInfo!.nickname!=null){
          textEditingControllerName.text=Constants.loginData!.userInfo!.nickname.toString();
          restrictionName=Constants.loginData!.userInfo!.nickname;
          textEditingControllerName.selection =TextSelection.fromPosition(TextPosition(offset:(textEditingControllerName.text.toString().length)));
        }
        businessMapTmp['sex']=Constants.loginData!.userInfo!.sex;
        selectedDate=Constants.loginData!.userInfo!.birthday!=null?DateTime(int.parse(Constants.loginData!.userInfo!.birthday!.toString().substring(0,4)),
            int.parse(Constants.loginData!.userInfo!.birthday.toString().substring(5,7)),int.parse(Constants.loginData!.userInfo!.birthday!.toString().substring(8,10))):
        DateTime(DateTime.now().year-17,DateTime.now().month,1);
      }
      albumList(success: success);
      update();
    }
  }
  /// 更新信息分类列表
  updatePersonalInfoClassList({dynamic data,required PersonalInfoClass personalInfoClass}){
    if(data==null||data==[]||(data!=null&&(data is String||data is List)&&data.isEmpty)){
      if(personalInfoDataItemListTmp.indexWhere((element) => element.personalInfoClass==personalInfoClass)==-1){
        int indexWhere=personalInfoDataItemList.indexWhere((element) => element.personalInfoClass==personalInfoClass);
        personalInfoDataItemListTmp.add(personalInfoDataItemList[indexWhere]);
        LogUtil.logInfo("更新信息分类列表${personalInfoDataItemListTmp.length}");
      }
    }
    update();
  }
  /// 更新AI标签
  updateUserAiTag({Function? success})async{
    if(loading)return ;
    loading=true;
    update();
    Map<String,dynamic> business={
      // 'countryCode':'US',//国家码，ISO 3166-1对应的两位大写
      // 'device':AppPackageInfoUtil.deviceId,// 设备号
      // 'sign':MD5Util.generateMd5("28cb238c-1f8f-44e8-b41d-3e3dcf27c0de7TvmahX0289h523RueRa5G2fv0NSIshw8Cq21B6dwD78I698wECoKp0vEFPgB2gn"),//签名，appId+appSecret  md5 to upperCase，其中appSecret由server提供
      // 'appId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',//用户appId
      // 'appKey':AppPackageInfoUtil.appKey,//客户端版本号
      // 'productId':301,//产品id，301
      'userId':Constants.loginData!.userInfo!.userId,//用户userId
    };
    business.addAll(businessMap);
    dynamic data=Constants.getRequestParameter(business: business);
    BaseEntity baseEntity=await DioService<BaseEntity>().updateUserAiTag(data);
    loading=false;
    update();
    if(baseEntity.success??false){
      // toast(baseEntity.message);
      success?.call();
    }
  }

  // ///app端事件通知接口
  // appEventInform({dynamic business})async{
  //   if(!(Constants.loginData!=null&&Constants.loginData!.userInfo!=null)) return ;
  //   business={
  //     //事件 first_login_homepage 首次登录user_reply_robot用户回复机器人，user_like_robot用户喜欢机器人，
  //     // user_open_app_process用户开启进程，private_chat_page_call私聊页Call，details_page_call详情Call，
  //     // user_connect_anchor用户跟主播发消息或免费call，link_exactly_G非random连麦（G机器人），user_register用户注册时触发
  //     "event":Constants.loginData!.userInfo!.isRegister==0?"first_login_homepage":"user_open_app_process",
  //     "userId":Constants.loginData!.userInfo!.userId,
  //     "appId":"e1bcc04c-4410-4e25-8b7f-8800d8016429",
  //     "appKey":"11000901",
  //     "deviceId":AppPackageInfoUtil.deviceId,
  //     "productId":301
  //   };
  //   dynamic data=Constants.getRequestParameter(
  //       business: business
  //   );
  //   BaseEntity baseEntity=await DioService<BaseEntity>().appEventInform(data);
  //   if(baseEntity.success??false){
  //     LogUtil.logInfo('App成功启动线程');
  //   }
  // }
}
class PersonalInfoDataItem{
  String title;
  PersonalInfoClass personalInfoClass;
  List<String>? chooseList;
  PersonalInfoDataItem({required this.personalInfoClass, this.chooseList,required this.title});
}