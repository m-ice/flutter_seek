// ignore_for_file: library_private_types_in_public_api
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_d0601/app_style/font_style.dart';
import 'package:flutter_d0601/common/constants.dart';
import 'package:flutter_d0601/controller/home_controller.dart';
import 'package:flutter_d0601/page/widgets/image_widget.dart';
import 'package:flutter_d0601/utils/app_back_desktop.dart';
import 'package:flutter_d0601/utils/db_util.dart';
import 'package:flutter_d0601/utils/resource_util.dart';
import 'package:get/get.dart';
import '../../enum/slide_direction.dart';
import '../../utils/custom_library/export/cache_user_data_util.dart';
import '../../utils/screen_util.dart';
import '../router/router_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  HomeController homeController=Get.find<HomeController>();
  DateTime? lastPopTime;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.showGuideAnimation=(){
      initAnimation();
    };
  }
  Animation<double>? _animation;
  bool showGuide=false;
  initAnimation(){
    if(homeController.showGuide){
      setState(() {
        showGuide=true;
      });
      homeController.animationController =
      AnimationController(vsync: this, duration: const Duration(seconds: 2))..addListener(() {
        onSlide(value: homeController.animationController!.value,slideDirection: slideDirection);
      });
      //使用弹性曲线
      _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent:  homeController.animationController!, curve: Curves.easeOut));
      homeController.animationController!.repeat();
      homeController.timer=Timer(const Duration(seconds: 2),(){
        setState(() => slideDirection=SlideDirection.left);
        _animation = Tween(begin: 0.0, end: -1.0).animate(_animation!);
        homeController.timer=Timer(const Duration(seconds: 2),(){
          _animation=null;
          homeController.showGuideClick();
        });
      });
    }
  }
  double iconSize=0;
  SlideDirection slideDirection=SlideDirection.right;
  onSlide({required double value,required SlideDirection slideDirection}){
    setState(()=>iconSize=(value*30).setWidth());
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: homeController,
        builder: (controller){
      return WillPopScope(
        onWillPop: Platform.isIOS?null:()async{
          // 点击返回键的操作
          // if (lastPopTime == null ||
          //     DateTime.now().difference(lastPopTime!) > const Duration(seconds: 2)) {
          //   toast('再按一次退出程序');
          //   lastPopTime = DateTime.now();
          // } else {
          //   lastPopTime = DateTime.now();
          //   // 退出app
          //   await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          //   return true;
          // }
          // return false;
          // await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          // DBUtil.closeDataBase();
          // return true;
          AppBackDesktop.backDesktop();
          return false;
        },
        child: Stack(
          children: [
            Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
                iconSize: 36.setWidth(),
                elevation: 2,
                selectedFontSize: 0,
                unselectedFontSize: 0,
                items: buildItems(),
                currentIndex: controller.selectedIndex,
                backgroundColor: const Color(0xFFFFFFFF),
                // selectedItemColor: const Color(0xFF219895),
                onTap: controller.onItemTapped,
              ),
              body: IndexedStack(
                index: controller.selectedIndex,
                children: controller.tabViewList,//login!=null?controller.currentIndex.value:1,
              ),
            ),
         if(controller.showGuide&&showGuide)Positioned(
                child: GestureDetector(
                  onTap: (){
                    controller.showGuideClick();
                  },
                  child: Container(
                    width: Get.width,
                    height: Get.height,
                    color: Colors.black.withOpacity(0.5),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 53.setWidth()),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AnimatedSize(
                              duration: const Duration(seconds: 3),
                              child: ImageWidget(
                                url: ResourceUtil.getAppPageIcon('pass_0'),
                                width: slideDirection==SlideDirection.left?60.setWidth()+iconSize:60.setWidth(),
                                height: slideDirection==SlideDirection.left?60.setWidth()+iconSize:60.setWidth(),
                              ),
                            ),
                            AnimatedSize(
                              duration: const Duration(seconds: 3),
                              child: ImageWidget(
                                url: ResourceUtil.getAppPageIcon('like_0'),
                                width: slideDirection==SlideDirection.right?60.setWidth()+iconSize:60.setWidth(),
                                height:slideDirection==SlideDirection.right?60.setWidth()+iconSize:60.setWidth(),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            getGuideText(
                              direction: SlideDirection.left,
                              title: "Swipe Left to",
                              title2: "PASS",
                              fontColor: const Color(0xFF1A96F0)
                            ),
                            getGuideText(
                                direction: SlideDirection.right,
                                title: "Swipe Right to",
                                title2: "LIKE",
                                fontColor: const Color(0xFFFF307F),
                            ),
                          ],
                        ),
                        Transform(
                          transform: buildMatrix4(),
                          child: ImageWidget(
                            url: ResourceUtil.getAppPageIcon('hand'),
                            width: 55.setWidth(),
                            height: 68.setWidth(),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            ),
          ],
        ),
      );
    });
  }

  Matrix4 buildMatrix4() {
    double dx = 0;
    double dy = 0;

    ///x轴方向平移
    if(_animation!=null){
      dx = _animation!.value * 60;
    }


    return Matrix4.translationValues(dx, dy, 0);
  }

  getGuideText({required SlideDirection direction,required String title,required String title2,required Color fontColor}){
    return Material(
      color: Colors.transparent,
      child: Column(
          crossAxisAlignment: direction==SlideDirection.left?CrossAxisAlignment.start:CrossAxisAlignment.end,
          children: [
            Text(title,
              style: getFontStyle(
                color: fontColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
              ),),
            Text(title2,
              textAlign: TextAlign.center,
              style: getFontStyle(
                color: fontColor,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontHeight: 1.4,
                letterSpacing: 0.2,
              ),),
          ],
        ),
    );

  }

  //生成items
  List<BottomNavigationBarItem> buildItems(){
    return List.generate(homeController.barItemList.length, (index) =>
        item(homeController.barItemList[index].icon,homeController.barItemList[index].activeIcon,index)
    );
  }

  //生成底部导航栏
  BottomNavigationBarItem item(String iconAsset,String activeIcon,index,){
    return BottomNavigationBarItem(
      label: '',
      icon: imageItem(ResourceUtil.getBottomPanel(iconAsset),24.setWidth(),index,),
      activeIcon:imageItem(ResourceUtil.getBottomPanel(activeIcon),24.setWidth(),index),
    );
  }

  Widget imageItem(String path,double size,int index){
    return SizedBox(
      width: 36.setWidth(),
      height: 36.setWidth(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ImageWidget(url: path,width: size,height: size,fit: BoxFit.cover),
          if(Constants.messageCount-Constants.blockDataMessageCount>0)Positioned(
              right: 0.setWidth(),
              top: 2.setHeight(),
              child: AnimatedOpacity(
                opacity: index==2?1:0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.setWidth(),vertical: 1.setHeight()),
            decoration: BoxDecoration(
                color: const Color(0xFFF75555),
                borderRadius: BorderRadius.all(Radius.circular(43.setRadius())),
                border: Border.all(width: 1.setWidth(),color: Colors.white)
            ),
            child: Text(
              Constants.messageCount-Constants.blockDataMessageCount>99?'99+':'${Constants.messageCount-Constants.blockDataMessageCount}',style: getFontStyle(
                color: const Color(0xFFFAFAFA),
                fontSize: 12,
                fontWeight: FontWeight.w700
            ),
            ),
          ),
              ))
        ],
      ),
    );
  }
}
