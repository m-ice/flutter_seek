import 'package:flutter/material.dart';
import 'package:flutter_d0601/app_style/font_style.dart';
import 'package:flutter_d0601/controller/discover_controller.dart';
import 'package:flutter_d0601/page/router/router_manager.dart';
import 'package:flutter_d0601/page/widgets/image_widget.dart';
import 'package:flutter_d0601/page/widgets/no_news_widget.dart';
import 'package:flutter_d0601/utils/screen_util.dart';
import 'package:get/get.dart';
import '../../../common/constants.dart';
import '../../../controller/home_controller.dart';
import '../../../utils/nav_bar_util.dart';
import '../../widgets/custom_scaffold_widget.dart';
import '../../widgets/parent_ink_well_widget.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>{
  final DiscoverController _discoverController=Get.find<DiscoverController>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _discoverController.getConversationsRecord();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    Constants.eventBus.off('insertOrUpdateConversation');
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  GetBuilder<DiscoverController>(
        init: _discoverController,
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NavBarUtil(title: const ['Message'],currentIndex: controller.currentIndex,
                    onTap: (index){
                      controller..currentIndex=index..update();
                      controller.pageController.jumpToPage(index);
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height-kToolbarHeight-MediaQuery.of(context).padding.top-MediaQuery.of(context).padding.bottom-kBottomNavigationBarHeight,
                    child: PageView(
                      controller: controller.pageController,
                      onPageChanged: (index){
                        controller..currentIndex=index..update();
                      },
                      children: [
                        controller.friendList.isEmpty? NoNewsWidget(
                          tips: 'No Messages yet',
                          onTap: (){
                            Get.find<HomeController>()..selectedIndex=0..update();
                          },
                        ):buildChatSessionList(controller),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  /// 聊天对话列表
  Widget buildChatSessionList(DiscoverController controller) {
    return CustomScaffoldWidget(
      loadPress: false,
      onRefresh: ()async{
        controller.getConversationsRecord();
        // debugPrint(context.loaderOverlay.visible.toString());
        // context.loaderOverlay.show();
        // Future.delayed(const Duration(seconds: 3),(){
        //   context.loaderOverlay.hide();
        // });
      },
      // onLoad: ()async{
      //   // debugPrint(context.loaderOverlay.visible.toString());
      //   // context.loaderOverlay.show();
      //   // Future.delayed(const Duration(seconds: 5),(){
      //   //   debugPrint(context.loaderOverlay.visible.toString());
      //   //   context.loaderOverlay.hide();
      //   // });
      // },
      child:ListView.separated(
        // padding: EdgeInsets.symmetric(vertical: 10.setHeight()),
        itemCount: controller.friendList.length,
        itemBuilder: (cx,index){
          return ListTile(
            onTap: (){
              // JsonConvert.fromJsonAsT<QuerySeekLikesVisitorsItems>(loginDataUserInfoToJson(Constants.loginData!.userInfo!))
              Get.toNamed("${RouterManager.chatMessagePageMiddlewareFree}?appId=${controller.friendList[index].appId}&&targetId=${controller.friendList[index].targetId}&&userId=${controller.friendList[index].userId}",
                  preventDuplicates: false);
            },
            contentPadding: EdgeInsets.symmetric(vertical: 5.setWidth(),horizontal: 16.setWidth()),
            horizontalTitleGap: 0.setWidth(),
            leading: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 14.setWidth()),
                  child: ParentInkWellWidget(
                    borderRadius: BorderRadius.all(Radius.circular(30.setRadius())),
                    textPadding: EdgeInsets.zero,
                    onTap: (){
                      // Get.toNamed("${RouterManager.personalInfoIndex}?"
                      //     "appId=${controller.querySeekLikesVisitorsList[index].appId}&&userId=${controller.querySeekLikesVisitorsList[index].userId}")
                      // Get.toNamed(RouterManager.personalInfoIndex);
                      Get.toNamed("${RouterManager.personalInfoIndex}?appId=${controller.friendList[index].appId}&&userId=${
                          controller.friendList[index].userId}",preventDuplicates: false);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(30.setRadius())),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: ImageWidget(url: controller.friendList[index].portrait??'',width: 50.setWidth(),height: 50.setWidth(),),
                    ),
                  ),
                ),
               if(controller.friendList[index].unreadCount!>0) Positioned(
                    top: 0,
                    right: 7.setWidth(),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 7.setWidth(),vertical: 2.setHeight()),
                      decoration: BoxDecoration(
                          color: const Color(0xFFF75555),
                          borderRadius: BorderRadius.all(Radius.circular(43.setRadius())),
                          border: Border.all(width: 1.setWidth(),color: const Color(0xFFFAFAFA))
                      ),
                      child: Text(
                        controller.friendList[index].unreadCount!>99?'99+':'${controller.friendList[index].unreadCount!}',
                        style: getFontStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFFAFAFA),
                        ),
                      ),
                    ),),
              ],
            ),
            // Badge.count(count: 33,
            //   alignment: AlignmentDirectional(36.setWidth(),0),
            //   backgroundColor: const Color(0xFFF75555),
            //   textStyle: getFontStyle(
            //     fontSize: 12,
            //     fontWeight: FontWeight.w700,
            //     color: const Color(0xFFFAFAFA),
            //   ),
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.all(Radius.circular(30.setRadius())),
            //     clipBehavior: Clip.hardEdge,
            //     child: ImageWidget(url: controller.imageList[index],width: 50.setWidth(),height: 50.setWidth(),),
            //   ),
            // ),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${controller.friendList[index].nickname}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: getFontStyle(fontWeight: FontWeight.w700,fontSize: 16,
                            fontHeight: 1.4,letterSpacing: 0.2),),
                      controller.friendList[index].messageType==0?
                      Text('${controller.friendList[index].message}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: getFontStyle(
                            color: const Color(0xFF9E9E9E),
                            fontWeight: FontWeight.w400,fontSize: 14,
                            fontHeight: 1.4,letterSpacing: 0.2),):
                      ShaderMask(shaderCallback: (rect){
                        return  RadialGradient(
                            radius: 0.1.setRadius(),
                            colors: const [Color(0xFF3F80FF),Color(0xFF44C0F4)]).createShader(rect);
                      },
                        child: Text(
                          controller.friendList[index].messageType!=null&& controller.friendList[index].messageType!=-1?
                          (controller.friendList[index].messageType!=1?
                          '[image]':'[voice]'):'',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: getFontStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          fontHeight: 1.4,
                          letterSpacing: 0.2,
                          color: Colors.white,
                        ),),
                      )
                    ],
                  ),
                ),
                Text(Constants.sessionTime(millisecond: controller.friendList[index].sentTime??0),style: getFontStyle(
                    fontSize: 12,
                    color: const Color(0xFF9E9E9E),
                    letterSpacing: 0.2,
                    fontWeight: FontWeight.w500
                ),),
              ],
            ),
          );
        }, separatorBuilder: (cx,index){
        return Divider(
          thickness: 1.2.setHeight(),
          indent: 64.setWidth(),
          height: 0,
          color: const Color(0xFFEEEEEE),);
      }, ),
    );
  }
}