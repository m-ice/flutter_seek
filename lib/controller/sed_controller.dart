import 'dart:async';

import 'package:flutter_d0601/controller/home_controller.dart';
import 'package:flutter_d0601/http/dio_service.dart';
import 'package:flutter_d0601/page/home/sed/model/sliding_record_entity.dart';
import 'package:flutter_d0601/page/model/update_app_entity.dart';
import 'package:flutter_d0601/utils/get_default_dialog.dart';
import 'package:flutter_d0601/utils/log_util.dart';
import 'package:flutter_d0601/utils/screen_util.dart';
import 'package:flutter_d0601/utils/custom_library/custom_library_export_util.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

import '../app_base_config/permission_manage.dart';
import '../app_style/font_style.dart';
import '../common/constants.dart';
import '../enum/slide_direction.dart';
import '../page/home/sed/model/query_seek_likes_visitors_entity.dart';
import '../page/home/sed/model/query_seek_recommend_list_entity.dart';
import '../page/router/router_manager.dart';
import '../page/widgets/button_ink_well_widget.dart';
import '../page/widgets/image_widget.dart';
import '../page/widgets/parent_ink_well_widget.dart';
import '../page/widgets/transform_widget/drag_like_page.dart';
import '../utils/app_package_info_util.dart';
import '../utils/resource_util.dart';
import 'my_controller.dart';
class Girl {
  final String description;
  final String asset;

  Girl(this.description, this.asset);
}
class SedController extends GetxController{
  OverlayEntry? overlayEntry;
  bool locationPermission=false;
  String reportStatus='';

  // List<Girl> girls = [];
  int aboveIndex = 0;
  int belowIndex = 1;
  /// 是否为重新加载的卡片数据
  bool reload=true;
  AnimationController? animationController;

  ScrollController scrollController=ScrollController();

  ///加载提示
  bool loading=false;

  /// 匹配概率
  double matchRate=0;
  int normalCount=0;
  @override
  onInit(){
    super.onInit();
    initCardData();
    isCompulsionVip();
  }
  isCompulsionVip(){
    bool result = CacheUserDataUtil.getBoolData(
        '${Constants.loginData!.userInfo!.id}_compulsionVip') ?? false;
    if (result&&(!Constants.isAuditOrNot)) {
      Future.delayed(const Duration(milliseconds: 300),(){
        Get.toNamed(RouterManager.vipOfOpenOrDetails);
      });
    }
  }
  initCardData(){
    getLocationPermissionStatus();
    config();
  }

  HomeController homeController=Get.find<HomeController>();
  double position = 0.0;
  SlideDirection? slideDirection;
  DragController dragController = DragController();
  List<QuerySeekRecommendListDataAngleList> sedAngleList=[];
  querySeekRecommendList()async{
    // List<OtherDataEntity> list= await DBUtil.selectRecordOtherData(type: 5);
    // print('我的数据0--${list.length}--$list');
    loading=true;
    update();
    Map<String,dynamic> business={
      // 'countryCode':'US',//国家码，ISO 3166-1对应的两位大写
      // 'device':AppPackageInfoUtil.deviceId,// 设备号
      // 'sign':MD5Util.generateMd5("28cb238c-1f8f-44e8-b41d-3e3dcf27c0de7TvmahX0289h523RueRa5G2fv0NSIshw8Cq21B6dwD78I698wECoKp0vEFPgB2gn"),//签名，appId+appSecret  md5 to upperCase，其中appSecret由server提供
      // 'appId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',//用户appId
      // 'productId':301,//产品id，301
      'userId':Constants.loginData!.userInfo!.userId,//用户userId
    };
    dynamic data=Constants.getRequestParameter(business: business);
    QuerySeekRecommendListEntity querySeekRecommendListEntity=QuerySeekRecommendListEntity();
    try{
      querySeekRecommendListEntity=await DioService<QuerySeekRecommendListEntity>().querySeekRecommendList(data);
    }catch(e){
      debugPrint("获取卡片列表异常${e.toString()}");
    }finally{
      loading=false;
      update();
    }


    if(querySeekRecommendListEntity.success??false){
      sedAngleList=querySeekRecommendListEntity.data!.angleList??[];
      matchRate=querySeekRecommendListEntity.data!.matchRate??0;
      normalCount=querySeekRecommendListEntity.data!.normalCount??20;
      homeController.showGuideAnimation?.call();
      countNumberOfSlips(request: true).then((value){
        int indexWhere=sedAngleList.indexWhere((element) => element.userId==slidingRecordEntity.userId.toString());
        if(indexWhere!=-1){
          aboveIndex=indexWhere;
          if(indexWhere+1<sedAngleList.length-1){
            belowIndex=indexWhere+1;
          }else{
            belowIndex = -1;
            sedAngleList.addAll(List.from(sedAngleList.sublist(0,aboveIndex))
              ..sort((a, b) => b.userId!.compareTo(a.userId??'')));
            sedAngleList.removeRange(0,aboveIndex);
            aboveIndex=0;
            belowIndex=1;
            update();
          }

          // List<QuerySeekRecommendListDataAngleList> sedAngleListTmp=  sedAngleList.sublist(0,indexWhere);
          // sedAngleList.removeRange(0, indexWhere);
          // sedAngleList.addAll(sedAngleListTmp);
        }
      });
      screenLikeData();
      update();
    }
  }
  // ///  0:Likes you 1:Visitors 2:已匹配 3:已拉黑 4:已聊天 5：记录滑动位置
  // insertData({required QuerySeekRecommendListDataAngleList querySeekRecommendListDataAngleList,int type=5}){
  //   DBUtil.countRecords(tabName: Tables.otherDataTab,type: type,userId: querySeekRecommendListDataAngleList.userId.toString()).then((value){
  //     if(value!=null&&value==0){
  //       Map<String,dynamic> otherData={
  //         "landerUID":Constants.loginData!.userInfo!.id.toString(),
  //         "uid":querySeekRecommendListDataAngleList.uid.toString(),
  //         "userId":querySeekRecommendListDataAngleList.userId.toString(),
  //         "saveTime":DateTime.now().millisecondsSinceEpoch,
  //         "type":type,
  //       };
  //       DBUtil.insertRecord(json: otherData,tableName: Tables.otherDataTab);
  //     }else{
  //       DBUtil.insertRecord(json: otherData,tableName: Tables.otherDataTab);
  //     }
  //   });
  // }
  final myController=Get.find<MyController>();
  /// 是否在限制次数内
  bool slideLimit =true;
  /// 滑动次数
  // int numberOfSlips=0;
  SlidingRecordEntity slidingRecordEntity=SlidingRecordEntity.fromJson({
    "numberOfSlips":0,
    "userId":null,
    "saveTime":null,
  });
 /// 记录滑动次数
  Future countNumberOfSlips({bool request=false,String? userId})async{
    DateTime currentTime=DateTime.now();
    int count=slidingRecordEntity.numberOfSlips??0;
    if(request){
      SlidingRecordEntity? recordEntity=CacheUserDataUtil.getSlidingRecordData("countNumberOfSlips_${Constants.loginData!.userInfo!.id}");
      if(recordEntity!=null){
        if(recordEntity.saveTime==currentTime.toString().substring(0,10)){
          slidingRecordEntity=recordEntity;
          count=recordEntity.numberOfSlips??0;
        }else{
          slidingRecordEntity=SlidingRecordEntity.fromJson({
            "numberOfSlips":0,
            "userId":null,
            "saveTime":currentTime.toString().substring(0,10),
          });
        }
      }
    }else{
      if(myController.isOpenMembership){
        count=0;
      }else{
        count++;
      }
        CustomCacheUtil.putObject("countNumberOfSlips_${Constants.loginData!.userInfo!.id}",SlidingRecordEntity.fromJson({
          "numberOfSlips":count,
          "userId":userId,
          "saveTime":currentTime.toString().substring(0,10),
        }));
    }
    slidingRecordEntity.numberOfSlips=count;
    slideLimit=((slidingRecordEntity.numberOfSlips??0)<normalCount);
    update();
  }
  /// 筛选出被拉黑的人
  screenLikeData(){
    for(String userId in Constants.blockDataList){
      int indexWhere=sedAngleList.indexWhere((element) => element.userId==userId);
      if(indexWhere!=-1){
        sedAngleList.removeAt(indexWhere);
      }
    }
    update();
  }

  // /// 当前匹配索引
  // int currentMatchIndex=-1;

  // /// 时间事件集合
  // Map<String,Timer> eventMap={};

  /// 匹配用户
  matchUser({required QuerySeekLikesVisitorsItems querySeekLikesVisitorsItems,Function? success}){
    double random=getMatchRate();
    if(random<matchRate){
      LogUtil.logUtil('匹配成功！uid=${querySeekLikesVisitorsItems.uid} random=$random  matchRate=$matchRate');
      Timer(Duration(seconds: math.Random().nextInt(7)+4), (){
        successfulMatchPopup(querySeekLikesVisitorsItems: querySeekLikesVisitorsItems);
        List<String> list = CacheUserDataUtil.getStringListData('alreadyMatchData_${Constants.loginData!.userInfo!.id}');
        int indexWhere=list.indexWhere((element) => element==querySeekLikesVisitorsItems.userId);
        if(indexWhere==-1){
          list=[...list,querySeekLikesVisitorsItems.userId.toString()];
          CustomCacheUtil.putStringList("alreadyMatchData_${Constants.loginData!.userInfo!.id}", list)!.then((value){
            debugPrint('存储匹配数据 $value');
          });
          Constants.alreadyMatchDataList=list;
        }
        success?.call();
        LogUtil.logUtil('匹配成功！length=${Constants.alreadyMatchDataList.length}');
      });
      update();
    }
  }

  /// 获取匹配
  double getMatchRate(){
    double random= (math.Random().nextDouble()+math.Random().nextDouble())/2;
    return random;
  }

  Future<void> initData()async{
    if(locationPermission){
      querySeekRecommendList();
      aboveIndex=0;
      belowIndex=1;
      update();
    }
  }

  getLocationPermissionStatus({bool state=false})async{
    if(state){
      locationPermission=state;
    }else{
      locationPermission=await Permission.location.isGranted;
    }
    update();
    if(!locationPermission){
      PermissionManage.requestLocationPermission().then((value){
        debugPrint("位置权限状态$value");
        if(value??false){
          getLocationPermissionStatus(state: true);
        }
      });
    }else if(locationPermission){
      LogUtil.logInfo("获取位置信息");
      /// 位置信息
      reload=true;
      Future.wait([
        getLocation(),
        initData(),
      ]);
    }
    update();
  }
  Future<void> getLocation()async{
    final locationData=await LocationUtil.getCurrentLocation();
    if(locationData!=null){
      Constants.latitude=locationData.latitude;
      Constants.longitude=locationData.longitude;
    }
    update();
  }

  /// 指示条长度
  double indicatorStripLength=(Get.width-78.setWidth())/5;

  int currentImageIndex=0;
  SlideDirection coverMoveDirection=SlideDirection.center;
  /// 选择指示条
  changeLocation({SlideDirection direction=SlideDirection.center,int length=0,int index=0}){
    coverMoveDirection=direction;
    if(direction==SlideDirection.center){
      if(currentImageIndex+1<length){
        currentImageIndex+=1;
      }else{
        currentImageIndex=0;
      }
    }
    // else if(direction==SlideDirection.left&&length>0){
    //   if(currentImageIndex-1>=0){
    //     currentImageIndex-=1;
    //   }else{
    //     currentImageIndex=length-1;
    //   }
    // }else if(direction==SlideDirection.right&&length>0){
    //   if(currentImageIndex+1<length){
    //     currentImageIndex+=1;
    //   }else{
    //     currentImageIndex=0;
    //   }
    // }
    //左右滑动
    if(length>5){
      scrollController.animateTo(indicatorStripLength*currentImageIndex,
          duration: const Duration(milliseconds: 400),
          curve: Curves.linear);
    }

    update();
  }

  /// 配置查询
  config()async{
    Map<String,dynamic> business={
      // 'parentId': ,//上级配置id
      'biz':0,//业务类型，0
      // 'key':AppPackageInfoUtil.appKey,//配置key
      'appId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',//用户appId
      'packageAppId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',//用户appId
      // 'device':AppPackageInfoUtil.deviceId,// 设备号
      // 'sign':MD5Util.generateMd5("28cb238c-1f8f-44e8-b41d-3e3dcf27c0de7TvmahX0289h523RueRa5G2fv0NSIshw8Cq21B6dwD78I698wECoKp0vEFPgB2gn"),//签名，appId+appSecret  md5 to upperCase，其中appSecret由server提供
      // 'productId':301,//产品id，301
      // 'userId':Constants.loginData!.userInfo!.userId,//用户userId
    };
    dynamic data=Constants.getRequestParameter(
        business: business
    );
    UpdateAppEntity updateAppEntity=await DioService<UpdateAppEntity>().config(data);
    if(updateAppEntity.success??false){
      for(UpdateAppData updateAppData in updateAppEntity.data??[]){
        updateCheckApp(updateAppData.value!=null&&updateAppData.value.toString().contains('_')?
        updateAppData.value.toString().split('_'):['0','0']);
      }
      updateApp();
      update();
    }
  }

  /// 0 不更新 1 推荐更新 2 强制更新
  int isUpdateApp=0;
  String updateAppVersion='';

  /// 校验是否更新App
  updateCheckApp(List list){
    String version=list[0].toString().replaceAll('.', '0');
    int newVersion=int.parse(version);
    int currentVersion=int.parse((AppPackageInfoUtil.currentVersion).toString().replaceAll('.', ''));
    if(version.length>currentVersion.toString().length){
      currentVersion =(currentVersion*math.pow(10, (version.length-currentVersion.toString().length))) as int;
    }else{
      newVersion =(newVersion*math.pow(10, currentVersion.toString().length-version.length))as int;
    }
    LogUtil.logUtil('是否更新版本：newVersion=$newVersion currentVersion=$currentVersion ${newVersion>currentVersion}');
    if(newVersion>currentVersion){
      isUpdateApp=1;
      if(list[1].toString()=='1'){
        isUpdateApp=2;
      }
      if(list[0].toString().length>=5){
        updateAppVersion='${list[0].toString().substring(0,1)}.${list[0].toString().substring(1,3)}.${list[0].toString().substring(3,5)}';
      }else{
        list[0]=(int.parse(list[0].toString())*math.pow(10, (5-list[0].toString().length))).toString();
        updateAppVersion='${list[0].toString().substring(0,1)}.${list[0].toString().substring(1,3)}.${list[0].toString().substring(3,5)}';
      }
    }
    update();
  }
  /// 更新App
  updateApp(){
    if(isUpdateApp==0) return ;
    getDefaultDialog(
      barrierDismissible: false,
      onWillPop: isUpdateApp!=2,
      context: Get.context!,
      contentPadding: EdgeInsets.zero,
      content: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 24.setWidth(),right: 24.setWidth(),top: 40.setHeight()),
            child: Column(
              children:  [
                ImageWidget(url: ResourceUtil.getAppPageIcon('update_app'), width: 120.setWidth(), height: 120.setWidth()),
                Padding(
                  padding: EdgeInsets.only(bottom: 12.setHeight()),
                  child: Text.rich(
                    TextSpan(
                        text: 'New Version',
                        style: getFontStyle(
                          fontSize: 18,
                          fontHeight: 1.2,
                          fontWeight: FontWeight.w700,
                        ),
                        children: [
                          WidgetSpan(child: Padding(
                            padding: EdgeInsets.only(left: 12.setWidth()),
                            child: Text(updateAppVersion,style: getFontStyle(
                              fontSize: 14,
                              letterSpacing: 0.2,
                              fontHeight: 1.2,
                              fontWeight: FontWeight.w700,
                            ),),
                          ))
                        ]
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 264.setWidth(),
                  padding: EdgeInsets.symmetric(horizontal: 16.setWidth(),vertical: 10.setHeight()),
                  decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.all(Radius.circular(10.setRadius()))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("1.Improve the user experience",style: getFontStyle(
                        fontSize: 14,fontHeight: 1.4,
                      ),),
                      Text("2.Bug fixed",style: getFontStyle(
                        fontSize: 14,fontHeight: 1.4,
                      ),)
                    ],
                  ),
                )
              ],
            ),
          ),
          if(isUpdateApp!=2)Positioned(
              top: 4.setHeight(),
              right: 4.setWidth(),
              child: IconButton(
                iconSize: 24.setWidth(),
                tooltip: 'Cancel',
                icon:ImageWidget(url: ResourceUtil.getAppPageIcon('close'),width: 24.setWidth(),),
                onPressed: () { Get.back(); },
              )
          ),
        ],
      ),
      inkWellWidget: Padding(
        padding: EdgeInsets.only(left: 24.setWidth(),right: 24.setWidth(),bottom: 40.setHeight()),
        child: ButtonInkWellWidget(onTap: (){
          launchUrl(Uri(scheme: "https",host: "www.pgyer.com",path: "d0601"),mode: LaunchMode.externalApplication);
        },
            textStyle: getFontStyle(
                fontWeight: FontWeight.w700,
                fontHeight: 1.2,
                fontSize: 18,
                color: const Color(0xFFFFFFFF)
            ),
            title: 'Updated', changeColor: true),
      ),
    );
  }


  /// 删除插入页面的小组件
  disposeOverLayEntry(){
    if(overlayEntry!=null){
      overlayEntry!.remove();
      overlayEntry=null;
      update();
    }
  }

  /// 匹配成功弹出
  successfulMatchPopup({required QuerySeekLikesVisitorsItems querySeekLikesVisitorsItems}){
    Get.bottomSheet(
        Material(
          color: Colors.transparent,
          child: SizedBox(
            width: Get.size.width,
            height: 402.setHeight(),
            child: Stack(
              children: [
                Positioned(
                  top: 42.setHeight(),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.setRadius()),
                          topRight: Radius.circular(20.setRadius()),
                        )
                    ),
                    width: Get.size.width,
                    height: 360.setHeight(),
                    padding: EdgeInsets.only(right: 24.setWidth(),left: 24.setWidth(),
                        bottom: 36.setHeight()+MediaQuery.of(Get.context!).padding.bottom,
                        top: 24.setHeight()
                    ),
                    child: Column(
                      children: [
                        ParentInkWellWidget(
                          onTap: (){
                            Get.toNamed(RouterManager.viewImagesPage,
                                preventDuplicates: false,
                                arguments: {"imageList":[
                                  querySeekLikesVisitorsItems.headImg
                                ]});
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(11.setRadius())),
                            child:   ImageWidget(
                              url: querySeekLikesVisitorsItems.headImg,
                              width: 110.setWidth(),
                              height: 136.setHeight(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 24.setHeight()),
                          child: ShaderMask(shaderCallback: (rect)=>const LinearGradient(
                              colors: [Color(0xFF3A89FF), Color(0xFF7F30FF), Color(0xFFDB3EFF),],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight
                          ).createShader(rect),
                            child:  Text('Successful Match ! ',
                              textAlign: TextAlign.center,
                              style: getFontStyle(
                                fontWeight:FontWeight.w900,
                                fontSize: 32,
                                fontHeight: 1.1,
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                              ),),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 24.setHeight()),
                          child: ShaderMask(shaderCallback: (rect)=>const LinearGradient(
                              colors: [Color(0xFF3A89FF), Color(0xFF7F30FF), Color(0xFFDB3EFF),],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight
                          ).createShader(rect),
                            child: Text('Go say hello to her',
                              textAlign: TextAlign.center,
                              style: getFontStyle(
                                fontWeight:FontWeight.w500,
                                fontSize: 18,
                                fontHeight: 1.4,
                                color: Colors.white,
                              ),),
                          ),
                        ),
                        ButtonInkWellWidget(onTap: (){
                          Get.toNamed(RouterManager.chatMessagePage,
                              preventDuplicates: false,
                              arguments: querySeekLikesVisitorsItems)!.then((value){
                            if(value=='Block'||value=='Report'){
                              Get.back();
                            }
                            update();
                          });
                        }, title: 'Go', changeColor: true)
                      ],
                    ),
                  ),
                ),
                Positioned(
                    left: 16.setWidth(),
                    child: ImageWidget(
                      url: ResourceUtil.getAppPageIcon('sed',type: '.webp'),
                      width: 90.setWidth(),
                    ),
                ),
              ],
            ),
          ),
        ),
        isDismissible: true,
        settings: RouteSettings(name: '${querySeekLikesVisitorsItems.uid}'),
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.setRadius()),
              topRight: Radius.circular(20.setRadius()),
            )
        )
    );
  }
}
