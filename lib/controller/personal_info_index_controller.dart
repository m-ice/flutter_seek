import 'package:flutter/material.dart';
import 'package:flutter_d0601/controller/sed_controller.dart';
import 'package:flutter_d0601/http/dio_service.dart';
import 'package:flutter_d0601/utils/loader_overlay_util.dart';
import 'package:flutter_d0601/utils/screen_util.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../common/constants.dart';
import '../enum/slide_direction.dart';
import '../page/home/sed/model/query_seek_angle_info_entity.dart';
import '../page/home/sed/model/query_seek_likes_visitors_entity.dart';
import '../page/widgets/image_widget.dart';
import '../utils/log_util.dart';
import '../utils/resource_util.dart';
import '../utils/toast_util.dart';


class PersonalInfoIndexController extends GetxController{
  OverlayEntry? overlayEntry;
  /// 移动位置
  Offset delta=const Offset(0, 0);
  /// 当前显示的大图
  int currentIndex=0;
  /// 0 不喜欢 1 待确定 2 喜欢
  int isLoveType=0;
  ///滑动控制器
  final ScrollController scrollController=ScrollController();
  /// 大图控制器
  PageController pageController=PageController();

  /// 滑动方向
  SlideDirection slideDirection=SlideDirection.right;

  List<String> imageList=[];

  /// 查询对象的appId
  String? targetAppId;
  /// 查询对象的userId
  String? targetUserId;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    targetAppId=Get.parameters['appId'];
    targetUserId=Get.parameters['userId'];
    querySeekAngleInfo();
    pageController.addListener(() {
      if(pageController.page!<currentIndex){
        slideDirection=SlideDirection.right;
        update();
      }else if(pageController.page!>currentIndex){
        slideDirection=SlideDirection.left;
        update();
      }
    });
  }

  @override
  void dispose(){
    disposeOverLayEntry();
    pageController.dispose();
    super.dispose();
  }
  QuerySeekAngleInfoData? querySeekAngleInfoData;

  bool isSelf=false;
  bool loading=false;

  /// 查询主播个人主页信息
  querySeekAngleInfo()async{
    loading=true;
    update();
    Map<String,dynamic> business={
      // 'countryCode':'US',//国家码，ISO 3166-1对应的两位大写
      // 'device':AppPackageInfoUtil.deviceId,// 设备号
      // 'sign':MD5Util.generateMd5("28cb238c-1f8f-44e8-b41d-3e3dcf27c0de7TvmahX0289h523RueRa5G2fv0NSIshw8Cq21B6dwD78I698wECoKp0vEFPgB2gn"),//签名，appId+appSecret  md5 to upperCase，其中appSecret由server提供
      // 'appKey':AppPackageInfoUtil.appKey,//客户端版本号
      // 'productId':301,//产品id，301
      // 'appId':'28cb238c-1f8f-44e8-b41d-3e3dcf27c0de',//本人应用id
      'userId':Constants.loginData!.userInfo!.userId,//本人用户长id
      'targetAppId':targetAppId,//所要查询对象的appId
      'targetUserId':targetUserId,//所要查询对象的userId
    };
    dynamic data=Constants.getRequestParameter(business: business);
    QuerySeekAngleInfoEntity querySeekAngleInfoEntity=QuerySeekAngleInfoEntity();
    try{
      querySeekAngleInfoEntity=await DioService<QuerySeekAngleInfoEntity>().querySeekAngleInfo(data);
    }catch(e){
      debugPrint("请求个人信息异常$e");
    }finally{
      loading=false;
      update();
    }

    if(querySeekAngleInfoEntity.success??false){
      querySeekAngleInfoData=querySeekAngleInfoEntity.data;
      isSelf=(querySeekAngleInfoData!=null&&querySeekAngleInfoData!.userId!=null)||
          (querySeekAngleInfoData!=null&&Constants.loginData!=null&&Constants.loginData!.userInfo!.userId==querySeekAngleInfoData!.userId);
      if(querySeekAngleInfoEntity.data!=null&&querySeekAngleInfoEntity.data!.covers!=null&&querySeekAngleInfoEntity.data!.covers!.isNotEmpty){
        imageList=querySeekAngleInfoEntity.data!.covers!.map((e) => e.toString()).toList();
      }else{
        imageList=[querySeekAngleInfoEntity.data!.headImg.toString()];
      }
      if(Constants.alreadyMatchDataList.indexWhere((element) => element==querySeekAngleInfoEntity.data!.userId.toString())!=-1){
        isLoveType=2;
      }
      update();
    }
  }
  disposeOverLayEntry(){
    if(overlayEntry!=null){
        overlayEntry!.remove();
        overlayEntry=null;
        update();
    }
  }
  /// 滑动大图
  moveBigImage(){
    if(!(imageList.length>1))return;
    if(delta.dx<-2.2){
      if(currentIndex<imageList.length-1){
        changeLocation(currentIndex+1);
      }else{
        scrollController.jumpTo(scrollController.position.minScrollExtent);
        changeLocation(0);
      }

    }else if(delta.dx>2.2){
      if(currentIndex>0){
        changeLocation(currentIndex-1);
      }else{
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
        changeLocation(imageList.length-1);
      }
    }
  }

  /// 切换选中图片
  changeLocation(int index){
    int preIndex=currentIndex;
      if(index>preIndex){
        //向左滑动
        scrollController.animateTo(50.0*index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.linear);
      }else if(index<preIndex){
        //向右滑动
        scrollController.animateTo(50.0*(index-1),
            duration: const Duration(milliseconds: 400),
            curve: Curves.linear);
      }
      currentIndex=index;
      update();
  }

  /// 点击 like
  onClickLike(){
    likeToast();
    Get.find<SedController>().matchUser(querySeekLikesVisitorsItems:
    QuerySeekLikesVisitorsItems.fromJson(querySeekAngleInfoData!.toJson()),
        // JsonConvert.fromJsonAsT<QuerySeekLikesVisitorsItems>(
        //     querySeekAngleInfoDataToJson(controller.querySeekAngleInfoData!)),
        success: (){
          try{
            isLoveType=2;
            update();
          }catch(e){
            LogUtil.logUtil('组件已经被销毁$e');
          }
        }
    );
    isLoveType=1;
    update();
  }

  /// 点击Like提示消息
 likeToast(){
   toast('Like has been sent！',iconWidget: Container(
     margin: EdgeInsets.only(right: 8..setWidth()),
     padding:  EdgeInsets.all(5.setWidth()),
     decoration:  BoxDecoration(
         borderRadius: BorderRadius.all(Radius.circular(50.setRadius())),
         gradient: const LinearGradient(
             begin: Alignment.centerLeft,
             end: Alignment.centerRight,
             colors: [Color(0xFFFD82E2),Color(0xFFFF4E98)]
         )
     ),
     child: ImageWidget(
       url: ResourceUtil.getAppPageIcon('love_1'),
       color: Colors.white,
       width: 12.setWidth(),
       height: 12.setWidth(),
     ),
   ));
 }
}

