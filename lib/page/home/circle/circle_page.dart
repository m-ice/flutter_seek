import 'package:flutter/material.dart';
import 'package:flutter_d0601/app_base_config/cus_behavior.dart';
import 'package:flutter_d0601/controller/home_controller.dart';
import 'package:get/get.dart';

import '../../../controller/circle_controller.dart';
import '../../../utils/nav_bar_util.dart';
import '../../widgets/no_news_widget.dart';
import 'circle_item.dart';

class CirclePage extends StatefulWidget {
  const CirclePage({Key? key}) : super(key: key);

  @override
  State<CirclePage> createState() => _CirclePageState();
}

class _CirclePageState extends State<CirclePage> {

  final _circleController=Get.find<CircleController>();

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<CircleController>(
        init: _circleController,
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.white,
            body:Column(
              children: [
                // NavBarUtil(title: ['Likes You${controller.currentIndex!=0&&controller.queryNewSeekLikesCount>0? ' (${controller.queryNewSeekLikesCount})':''}',
                //   'Visitors${controller.currentIndex!=1&&controller.querySeekVisitorsCount>0?' (${controller.querySeekVisitorsCount})':''}'],
                //   currentIndex: controller.currentIndex,
                //   interval: controller.interval,
                //   onTap: (index){
                //     controller.querySeekLikesVisitors(type: index);
                //     controller..currentIndex=index..update();
                //     controller.pageController.jumpToPage(index);
                //   },
                // ),
                NavBarUtil(title: const ['Likes You', 'Visitors'],
                  currentIndex: controller.currentIndex,
                  interval: controller.interval,
                  onTap: (index){
                    controller.querySeekLikesVisitors(type: index);
                    controller..currentIndex=index..update();
                    controller.pageController.jumpToPage(index);
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height-kToolbarHeight-MediaQuery.of(context).padding.top-MediaQuery.of(context).padding.bottom-kBottomNavigationBarHeight,
                  child: ScrollConfiguration(
                    behavior: CusBehavior(),
                    child: PageView(
                      controller: controller.pageController,
                      onPageChanged: (index){
                        if(index==0){
                          controller..currentIndex=index..update();
                        }else{
                          controller..currentIndex=index..update();
                        }
                        controller.querySeekLikesVisitors(type: index);
                        // controller.querySeekLikesVisitors(type: controller.currentIndex);
                      },
                      children:   [
                        // controller.imageList.isEmpty?buildOpenMembership():buildChatSessionList(controller),
                        controller.querySeekLikesList.isNotEmpty?
                        CircleItem(circleController: controller)
                            :NoNewsWidget(
                          onTap: (){
                            Get.find<HomeController>()..selectedIndex=0..update();
                          },
                        ),
                        controller.querySeekVisitorsList.isNotEmpty?CircleItem(circleController: controller):NoNewsWidget(
                          tips: 'No visitors yet',
                          onTap: (){
                            Get.find<HomeController>()..selectedIndex=0..update();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}

