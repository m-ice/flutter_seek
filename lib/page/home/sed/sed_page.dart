
import 'package:flutter/material.dart';
import 'package:flutter_d0601/app_style/font_style.dart';
import 'package:flutter_d0601/common/constants.dart';
import 'package:flutter_d0601/controller/sed_controller.dart';
import 'package:flutter_d0601/enum/slide_direction.dart';
import 'package:flutter_d0601/page/router/router_manager.dart';
import 'package:flutter_d0601/page/widgets/background_ink_widget.dart';
import 'package:flutter_d0601/page/widgets/button_ink_well_widget.dart';
import 'package:flutter_d0601/page/widgets/image_widget.dart';
import 'package:flutter_d0601/page/widgets/no_news_widget.dart';
import 'package:flutter_d0601/page/widgets/parent_ink_well_widget.dart';
import 'package:flutter_d0601/page/widgets/transform_widget/drag_like_page.dart';
import 'package:flutter_d0601/page/widgets/user_online_status_widget.dart';
import 'package:flutter_d0601/utils/insert_widget.dart';
import 'package:flutter_d0601/utils/resource_util.dart';
import 'package:flutter_d0601/utils/screen_util.dart';
import 'package:flutter_d0601/utils/toast_util.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../widgets/custom_loader_overlay_widget.dart';
import 'model/query_seek_likes_visitors_entity.dart';

class SedPage extends StatefulWidget {
  const SedPage({Key? key}) : super(key: key);

  @override
  State<SedPage> createState() => _SedPageState();
}

class _SedPageState extends State<SedPage> with TickerProviderStateMixin{

  final double bottomHeight = 100.0;
  final double defaultIconSize = 30.0;
  final Color? defaultIconColor =

  Color.lerp(const Color(0xFFFF80AB), const Color(0xFFC51162), 0.0);

  double get leftIconSize => sedController.slideDirection == SlideDirection.left
      ? defaultIconSize * (1 + sedController.position * 0.8)
      : defaultIconSize;

  double get rightIconSize => sedController.slideDirection == SlideDirection.right
      ? defaultIconSize * (1 + sedController.position * 0.8)
      : defaultIconSize;

  Color? get leftIconColor => sedController.slideDirection == SlideDirection.left
      ? Color.lerp(const Color(0xFFFF80AB), const Color(0xFFC51162), sedController.position)
      : defaultIconColor;

  Color? get rightIconColor => sedController.slideDirection == SlideDirection.right
      ? Color.lerp(const Color(0xFFFF80AB), const Color(0xFFC51162), sedController.position)
      : defaultIconColor;

  void setAboveIndex() {
    // print("执行了setAboveIndex");
    if(sedController.aboveIndex==sedController.sedAngleList.length-1){
      sedController.reload=false;
    }
    if(sedController.aboveIndex < sedController.sedAngleList.length - 1){
      sedController.aboveIndex++;
    }else{
      sedController.aboveIndex = -1;
    }
    sedController..currentImageIndex=0..coverMoveDirection=SlideDirection.center..update();
    if(sedController.aboveIndex!=-1){
      sedController.countNumberOfSlips(userId: sedController.sedAngleList[sedController.aboveIndex].userId);
    }
    setBelowIndex();
    // sedController.changeLocation();
    // if (aboveIndex < girls.length - 1) {
    //   aboveIndex++;
    // } else {

    //   aboveIndex = 0;
    // }
  }

  void setBelowIndex() {
    if(sedController.reload&&sedController.belowIndex!=-1){
      if (sedController.belowIndex < sedController.sedAngleList.length - 1) {
        sedController.belowIndex++;
      } else {
        sedController.belowIndex = -1;
        // print("排序---${sedController.sedAngleList.length}");
        sedController..sedAngleList.addAll(List.from(sedController.sedAngleList.sublist(0,sedController.aboveIndex))
          ..sort((a, b) => b.userId!.compareTo(a.userId??'')))..sedAngleList.removeRange(0,sedController.aboveIndex)..aboveIndex=0..belowIndex=1..update();
        // print("排序---${sedController.sedAngleList.length}");
      }
    }
    sedController.update();
    // if (belowIndex < girls.length - 1) {
    //   belowIndex++;
    // } else {
    //   belowIndex = 0;
    // }
  }

  /// 0<= position <=1
  void onSlide(double position, SlideDirection? direction) {
    sedController..position = position..slideDirection = direction..update();
  }

  void onSlideCompleted() {
    sedController.animationController?.forward();
    // String isLike =
    // (slideDirection == SlideDirection.left) ? 'dislike' : 'like';
    // toast('You $isLike this !',duration: const Duration(milliseconds: 1500));
    if( sedController.slideDirection==SlideDirection.right){
      sedController.matchUser(querySeekLikesVisitorsItems: QuerySeekLikesVisitorsItems.fromJson(sedController.sedAngleList[sedController.aboveIndex].toJson()));
    }
    setAboveIndex();
  }

  SedController sedController=Get.find<SedController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sedController.animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )
      ..addListener(() {
        setState(() {
          if ( sedController.position != 0) {
            sedController.position = 1 - sedController.animationController!.value;
          }
          sedController.update();
          // debugPrint("动画${animationController!.value}");
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          sedController.animationController?.reset();
        }
      });
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
    //   sedController.inItData();
    // });
  }
  @override
  void deactivate() {
    // TODO: implement deactivate
    if(mounted){
      if(context.loaderOverlay.visible){
        context.loaderOverlay.hide();
      }
    }
    super.deactivate();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    sedController.animationController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SedController>(
        init: sedController,
        builder: (controller) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onPanDown: (v){
              controller.disposeOverLayEntry();
            },
            child: CustomLoaderOverlayWidget(
              loading: controller.loading,
              child: Scaffold(
                backgroundColor: Colors.white,
                body: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: kToolbarHeight),
                      child: SafeArea(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            controller.locationPermission?
                            Material(
                              color: Colors.transparent,
                              child: controller.myController.isOpenMembership||controller.slideLimit||Constants.isAuditOrNot?
                              SizedBox(width: MediaQuery.of(context).size.width,height: 0,)
                              // NoNewsWidget(
                              // tips: 'No visitors yet',
                              //   onTap: (){
                              //     controller.querySeekRecommendList();
                              //   },
                              // )
                                  :buildOpenMembership(controller),
                            )
                                : Material(
                              color: Colors.transparent,
                              child: buildStartupEncounter(controller),
                            ),
                            if(controller.sedAngleList.isNotEmpty&&(controller.myController.isOpenMembership||
                                (controller.slideLimit||Constants.isAuditOrNot)))
                              Positioned(child: Visibility(
                              visible: (controller.aboveIndex!=-1||controller.belowIndex!=-1)&&controller.reload,
                              child: buildNearbyFriendCard(controller, context),
                            ),),
                          ],
                        ),
                      ),
                    ),

                   Positioned(
                        left: 0,
                        right: 0,
                        top: MediaQuery.of(context).padding.top,
                        child: buildToolbar(context)),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  /// 启动遇到
  Widget buildStartupEncounter(SedController controller) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ShaderMask(
              shaderCallback: (rect){
                return const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF3A89FF), Color(0xFF7F30FF), Color(0xFFDB3EFF)]).createShader(rect);
              },
              child: ImageWidget(url: ResourceUtil.getAppPageIcon("location"),width: 42.5.setWidth(),color: Colors.white,)),
          SizedBox(
            width: 200.setWidth(),
            child: Text('Please enable your location to start encountering',
              textAlign: TextAlign.center,
              style: getFontStyle(
                  fontSize: 14,
                  fontHeight: 1.4,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF757575),
                  letterSpacing: 0.2
              ),),
          ),
          SizedBox(height: 24.setHeight(),),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 80.setWidth()),
            child: ButtonInkWellWidget(
              title: 'Allow',
              onTap: (){
                controller.getLocationPermissionStatus();
                // Get.to(const TestPage());
                // PermissionManage.requestLocationPermission().then((value){
                //   debugPrint("位置权限状态$value");
                //   if(value??false){
                //     controller.getLocationPermissionStatus();
                //   }
                // });
              }, changeColor: true,
            ),
          ),
        ],
      ),
    );
  }

  /// 附近好友
  Widget buildNearbyFriendCard(SedController controller, BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if(controller.sedAngleList.length>controller.aboveIndex+2) Positioned(
            top: 16.setHeight(),
            bottom: 16.setHeight(),
            child: Material(
                elevation: 6.setHeight(),
                borderRadius: BorderRadius.circular(16.setRadius()),
                color: Colors.transparent,
                child: _buildChooseView(controller.aboveIndex+2,isTop: false,controller: controller))),
        if(controller.sedAngleList.length>controller.aboveIndex+1) Positioned(
            top: 8.setHeight(),
            bottom: 24.setHeight(),
            child: controller.sedAngleList.length>controller.aboveIndex+2?
            _buildChooseView(controller.aboveIndex+1,isTop: false,controller: controller):
            Material(
              elevation: 6.setHeight(),
              borderRadius: BorderRadius.circular(16.setRadius()),
              color: Colors.transparent,
              child: _buildChooseView(controller.aboveIndex+1,isTop: false,controller: controller),
            ),
        ),
        Positioned(
          top: 0.setHeight(),
          bottom: 32.setHeight(),
          child: controller.sedAngleList.length>controller.aboveIndex+1?showCard(controller):
          Material(
            elevation: 6.setHeight(),
            borderRadius: BorderRadius.circular(16.setRadius()),
            color: Colors.transparent,
            child: showCard(controller),
          ),
          // Transform.rotate(
          //   angle: controller.position/0.5,
          //   child: Transform.scale(
          //     scale: 1+controller.position/0.5,
          //     child:
          //   ),
          // )
        ),
      ],
    );
  }

  Widget showCard(SedController controller){
    return DragLike(
      dragController: controller.dragController,
      // duration: const Duration(milliseconds: 300),
      allowDrag: true,
      secondChild: controller.sedAngleList.length>1?_buildChooseView(controller.aboveIndex+1,isTop: false,controller: controller):null,
      screenWidth: MediaQuery.of(context).size.width-16.setWidth(),
      outValue: 0.25,
      dragSpeed: 600,
      onChangeDragDistance: (distance) {
        /// {distance: 0.17511112467447917, distanceProgress: 0.2918518744574653}
        // print(distance.toString());
          if((double.tryParse(distance['distance'].toString())??0)>0){
            controller.slideDirection=SlideDirection.right;
          }else{
            controller.slideDirection=SlideDirection.left;
          }
          controller.position=(double.tryParse(distance['distance'].toString())??0).abs();
          controller.update();
      },
      onOutComplete: (type) {
        /// left or right
        if(type=='right'){
          controller.matchUser(querySeekLikesVisitorsItems: QuerySeekLikesVisitorsItems.fromJson(sedController.sedAngleList[sedController.aboveIndex].toJson()));
        }
        controller.position=0;
        controller.slideDirection=SlideDirection.center;
        controller.update();
      },
      onScaleComplete: () {
        setAboveIndex();
      },
      onPointerUp: () {
        debugPrint("抬起了");
      },
      onCancel: (){
        controller..position=0..slideDirection=SlideDirection.center..update();
      },
      child: _buildChooseView(controller.aboveIndex,isTop: true,controller: controller),
    );
  }
  /// 开通会员
  Widget buildOpenMembership(SedController controller) {
    return NoNewsWidget(
      tips: 'Become VIP to get unlimited swiping privilege',
      bottomMsg: 'Get VIP',
      gradient: const LinearGradient(
          colors: [Color(0xFFDAB367),Color(0xFFDAB367)]
      ),
      onTap:(){
        Get.toNamed('${RouterManager.vipOfOpenOrDetails}?requireVip=true')?.then((value){
          if(value!=null&&value){
            controller.initData();
          }
        });
      },
    );
  }

  /// 附近好友主体页面
  Widget _buildChooseView(int currentIndex,{required SedController controller,required bool isTop}) {
    return currentIndex!=-1?SizedBox(
      width: MediaQuery.of(context).size.width-16.setWidth(),
      height: double.infinity,
      child: ParentInkWellWidget(
        onTap: (){
          controller.changeLocation(direction: SlideDirection.center,length: controller.sedAngleList[currentIndex].covers!=null?
                      controller.sedAngleList[currentIndex].covers!.length:0);
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
                child: ClipRRect(
                    borderRadius:  BorderRadius.all(Radius.circular(16.setRadius())),
                    child: ImageWidget(url:
                    controller.sedAngleList[currentIndex].covers!=null&&controller.sedAngleList[currentIndex].covers!.isNotEmpty?
                    isTop? controller.sedAngleList[currentIndex].covers![controller.currentImageIndex].toString():
                    controller.sedAngleList[currentIndex].covers![0].toString()
                        :controller.sedAngleList[currentIndex].headImg,
                      width: MediaQuery.of(context).size.width-16.setWidth(),))),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.setWidth()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 if(isTop&&controller.sedAngleList[currentIndex].covers!=null&&controller.sedAngleList[currentIndex].covers!.length>1) Container(
                    margin: EdgeInsets.only(right: 8.setWidth(),left: 8.setWidth(),top: 10.setHeight(),),
                    alignment: Alignment.center,
                    height: 4.setHeight(),
                    child: ListView.separated(
                        shrinkWrap: true,
                        controller: controller.scrollController,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (cx,index){
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 1200),
                            transitionBuilder: (Widget child, Animation<double> animation){
                              Offset? start;
                              Offset? end;
                              if(controller.coverMoveDirection==SlideDirection.center){
                                start=const Offset(0, 0);
                                end=const Offset(0, 0);
                              }else if(controller.coverMoveDirection==SlideDirection.left){
                                start=const Offset(0.2, 0);
                                end=const Offset(0, 0);
                              }else if(controller.coverMoveDirection==SlideDirection.right){
                                start=const Offset(-0.2, 0);
                                end=const Offset(0, 0);
                              }
                              return SlideTransition(position: Tween(
                                  begin: start,end: end
                              ).animate(CurvedAnimation(parent: animation,
                                  curve: Curves.linear)),
                                child: FadeTransition(
                                  opacity: Tween(begin: 0.0,end: 1.0).animate(
                                    CurvedAnimation(
                                        parent: animation,
                                        curve: Curves.linear
                                    ),
                                  ),
                                  child: child,
                                ),
                              );
                            },
                            layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
                              return Stack(
                                children: [
                                  currentChild!
                                ],
                              );
                            },
                            child: ParentInkWellWidget(
                              key: ValueKey(controller.currentImageIndex),
                              onTap: (){
                                controller.changeLocation(index: index);
                              },
                              child: Ink(
                                width: controller.indicatorStripLength,
                                padding: EdgeInsets.symmetric(vertical: 10.setHeight()),
                                height: 3.setHeight(),
                                decoration:  BoxDecoration(
                                  color: index==controller.currentImageIndex?const Color(0xFFFAFAFA):Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.all(Radius.circular(2.setRadius())),
                                ),
                              ),
                              // AnimatedOpacity(
                              //   // opacity: controller.currentImageIndex==currentIndex?controller.animationController!.value:1,
                              //   duration: const Duration(milliseconds: 120),
                              //   child: Container(
                              //     width: controller.indicatorStripLength,
                              //     height: 3.setHeight(),
                              //     decoration:  BoxDecoration(
                              //       color: index==controller.currentImageIndex?const Color(0xFFFAFAFA):Colors.black.withOpacity(0.5),
                              //       borderRadius: BorderRadius.all(Radius.circular(2.setRadius())),
                              //     ),
                              //   ),
                              // ),
                            ),
                          );
                        }, separatorBuilder: (cx,index){
                      return SizedBox(width: 5.setWidth(),);
                    }, itemCount: (controller.sedAngleList[currentIndex].covers??[]).length),
                  ),
                  Expanded(
                    child: visibilityOrAnimate(
                      isTop: isTop,
                      child: buildLoveOrReport(controller),
                    ),
                  ),
                  const Spacer(),
                  visibilityOrAnimate(
                    isTop: isTop,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 28.setHeight(),left: 20.setWidth(),right: 26.setWidth()),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: (){
                                Get.toNamed("${RouterManager.personalInfoIndex}?"
                                    "appId=${controller.sedAngleList[currentIndex].appId}&&userId=${controller.sedAngleList[currentIndex].userId}",
                                  preventDuplicates: false,
                                )!.then((value){
                                  controller.update();
                                });
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${controller.sedAngleList[currentIndex].nickname!=null?'${controller.sedAngleList[currentIndex].nickname},':''}'
                                      '${controller.sedAngleList[currentIndex].age??18}',
                                    style: getFontStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 28,fontHeight: 1.1),),
                                  UserOnlineStatusWidget(title: ['Online','Busy','Offline'][controller.sedAngleList[currentIndex].onlineStatus??0]),
                                  if(controller.sedAngleList[currentIndex].distance!=null) Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      ImageWidget(url: ResourceUtil.getAppPageIcon("location"),color: const Color(0xFFBDBDBD),width: 14.setWidth(),),
                                      SizedBox(width: 7.setWidth(),),
                                      Text('${controller.sedAngleList[currentIndex].distance!.toStringAsFixed(1)} miles away',style: getFontStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16,
                                          fontHeight: 1.4,letterSpacing: 0.2),),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                         if(controller.aboveIndex!=-1) BackGroundInkWidget(
                            onTap: (){
                              Get.toNamed(RouterManager.chatMessagePage,arguments:
                              QuerySeekLikesVisitorsItems.fromJson(controller.sedAngleList[controller.aboveIndex].toJson()),preventDuplicates: false)!
                                  .then((value){
                                    // if(value=='Block'){
                                    //   controller..sedAngleList.removeAt(controller.aboveIndex)..update();
                                    // }
                                    controller.update();
                              });
                            },
                              gradient: Constants.alreadyChatDataList.contains(controller.sedAngleList[controller.aboveIndex].uid.toString())? const LinearGradient(
                              colors: [Color(0xFFFD82E2), Color(0xFFFF4E98)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight
                          ):const LinearGradient(
                              colors: [Color(0xFF44C0F4),Color(0xFF3F80FF)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight
                          ), child: ImageWidget(url: ResourceUtil.getAppPageIcon('sed_to_chat'),width: 44.setWidth(),))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // if(isTop&&controller.sedAngleList[currentIndex].covers!=null&&controller.sedAngleList[currentIndex].covers!.length>1)  Positioned(
            //   left: 0,
            //     child: ParentInkWellWidget(
            //       exitOnLongPress: true,
            //       onTap: (){
            //         controller.changeLocation(direction: SlideDirection.left,length: controller.sedAngleList[currentIndex].covers!=null?
            //         controller.sedAngleList[currentIndex].covers!.length:0);
            //       },
            //       borderRadius: BorderRadius.only(bottomRight: Radius.circular(50.setRadius()),
            //           topRight: Radius.circular(50.setRadius())),
            //       child: Ink(
            //   width: 50.setWidth(),
            //   height: MediaQuery.of(context).size.height/2,
            //   decoration: BoxDecoration(
            //     color: Colors.transparent,
            //     borderRadius: BorderRadius.only(bottomRight: Radius.circular(50.setRadius()),
            //         topRight: Radius.circular(50.setRadius())),
            //   ),
            //
            // ),),),
            // if(isTop&&controller.sedAngleList[currentIndex].covers!=null&&controller.sedAngleList[currentIndex].covers!.length>1) Positioned(
            //     right: 0,
            //     child: ParentInkWellWidget(
            //       exitOnLongPress: true,
            //       onTap: (){
            //         controller.changeLocation(direction: SlideDirection.right,length: controller.sedAngleList[currentIndex].covers!=null?
            //         controller.sedAngleList[currentIndex].covers!.length:0);
            //       },
            //       borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50.setRadius()),
            //           topLeft: Radius.circular(50.setRadius())),
            //       child: Ink(
            //         width: 50.setWidth(),
            //         height: MediaQuery.of(context).size.height/2,
            //         decoration: BoxDecoration(
            //           color: Colors.transparent,
            //           borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50.setRadius()),
            //               topLeft: Radius.circular(50.setRadius())),
            //         ),
            //       ),),),
          ],
        ),
      ),
    ):Container();
  }


  /// 卡片内容隐藏-显示动画效果
  Widget visibilityOrAnimate({bool isTop=false,required Widget child}){
    return Visibility(
      visible: isTop,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 1000),
        transitionBuilder: (Widget child, Animation<double> animation){
          return FadeTransition(
            opacity: Tween(begin: 0.0,end: 1.0).animate(
              CurvedAnimation(
                  parent: animation,
                  curve: Curves.linear
              ),
            ),
            child: ScaleTransition(
              scale: Tween(
                begin: 0.6,
                end: 1.0,
              ).animate(CurvedAnimation(parent: animation,
                  curve: Curves.linear)),
              child: child,
            ),
          );
        },
        child: child,
      ),
    );
  }

  /// 喜欢或投诉
  Widget buildLoveOrReport(SedController controller) {
    return Stack(
      children: [
        if(controller.slideDirection==SlideDirection.right&&controller.position>0)Positioned(
          top: 17.setHeight(),
          left: 14.setWidth(),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: (0.5+controller.position)>1?1:0.5+controller.position,
            child: ImageWidget(
              url: ResourceUtil.getAppPageIcon('sed_love_1'),height: 44.setWidth()*(controller.position+1),),
          ),
        ),
        controller.slideDirection==SlideDirection.left&&controller.position>0?Positioned(
          top: 17.setHeight(),
          right: 14.setWidth(),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: (0.5+controller.position)>1?1:0.5+controller.position,
            child: ImageWidget(
              url: ResourceUtil.getAppPageIcon('sed_cancel_1'),height: 44.setWidth()*(controller.position+1),),
          ),
        ):Positioned(
          right: 0,
          child: Builder(builder: (cx){
            return IconButton(
              icon: ImageWidget(url: ResourceUtil.getAppPageIcon('report'),
                width: 20.setWidth(),

                color: Colors.white,
              ),
              onPressed: (){
                if(controller.overlayEntry==null){
                  var offset = (cx.findRenderObject() as RenderBox).localToGlobal(Offset.zero);
                  controller
                    ..overlayEntry=createOverlayEntryReportOrBlock(
                        right: 24.setWidth(),//(MediaQuery.of(context).padding.right+16).setWidth(),
                        top: offset.dy+40.setHeight(),//(kToolbarHeight+16).setHeight(),
                        businessTmp:{
                          'otherAppId':controller.sedAngleList[controller.aboveIndex].appId,
                          'otherUserId':controller.sedAngleList[controller.aboveIndex].userId
                        },
                        /// 投诉
                        report: (reportStatus){
                          toastCenter("Report   successfully");
                          controller..sedAngleList.removeAt(controller.aboveIndex)..update();
                        },
                        /// 拉黑
                        block: (){
                          toastCenter("Block successfully");
                          controller..sedAngleList.removeAt(controller.aboveIndex)..update();
                        },
                        close:(){
                          controller.disposeOverLayEntry();
                        }
                    )
                    ..update();
                  if(controller.overlayEntry!=null){
                    Overlay.of(cx).insert(controller.overlayEntry!);
                  }
                }else{
                  controller.disposeOverLayEntry();
                }
              },
            );
          }),
        ),
      ],
    );
  }

  /// 首页头部
  Widget buildToolbar(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: kToolbarHeight,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8.setRadius())),
                child: ImageWidget(url: ResourceUtil.getAppPageIcon('sed_top_0'),width: 36.setHeight()),),
            SizedBox(width: 8.setWidth(),),
            ImageWidget(url: ResourceUtil.getAppPageIcon('sed_top_1'),width: 59.setWidth(),),
          ],
        ));
  }
}
