import 'package:flutter/material.dart';
import 'package:flutter_d0601/page/widgets/custom_scaffold_widget.dart';
import 'package:flutter_d0601/utils/screen_util.dart';
import 'package:get/get.dart';
import 'package:flutter_d0601/controller/circle_controller.dart';

import '../../../app_style/font_style.dart';
import '../../../common/constants.dart';
import '../../../utils/resource_util.dart';
import '../../router/router_manager.dart';
import '../../widgets/background_ink_widget.dart';
import '../../widgets/image_widget.dart';
import '../../widgets/parent_ink_well_widget.dart';
import '../../widgets/user_online_status_widget.dart';

class CircleItem extends StatefulWidget {
  final CircleController circleController;
  const CircleItem({Key? key, required this.circleController}) : super(key: key);

  @override
  State<CircleItem> createState() => _CircleItemState();
}

class _CircleItemState extends State<CircleItem> with AutomaticKeepAliveClientMixin{
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<CircleController>(
      init: widget.circleController,
      builder: (controller) {
        return CustomScaffoldWidget(
          // onLoad: ()async{
          //   controller.querySeekLikesVisitors(load: true);
          // },
          onRefresh: ()async{
            controller.querySeekLikesVisitors();
          },
          child: GridView.count(crossAxisCount: 2,
            padding: EdgeInsets.symmetric(vertical: 10.setHeight(),horizontal: 14.setWidth()),
            childAspectRatio: 0.76,
            crossAxisSpacing: 8.setWidth(),
            mainAxisSpacing: 7.setHeight(),
            children:  List.generate(
                controller.currentIndex==0?controller.querySeekLikesList.length:controller.querySeekVisitorsList.length, (index){
              return buildRoomItem(controller,index);}),
          ),
        );
      }
    );
  }


  Widget buildRoomItem(CircleController controller,int index) {
    return Material(
      color: Colors.transparent,
      shadowColor: const Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(8.setRadius()),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.zero,
        height: 213.setHeight(),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8.setRadius())),
                child: ImageWidget(url: (controller.currentIndex==0?
                controller.querySeekLikesList[index]:controller.querySeekVisitorsList[index]).covers!=null&&
      (controller.currentIndex==0?
      controller.querySeekLikesList[index]:controller.querySeekVisitorsList[index]).covers!.isNotEmpty?
                (controller.currentIndex==0?
                controller.querySeekLikesList[index]:controller.querySeekVisitorsList[index]).covers![0]:
      (controller.currentIndex==0?controller.querySeekLikesList[index]:controller.querySeekVisitorsList[index]).headImg,  height: 213.setHeight(),),
              ),
            ),
            Positioned.fill(child: ParentInkWellWidget(
              borderRadius: BorderRadius.all(Radius.circular(8.setRadius())),
              onTap: (){
                Get.toNamed("${RouterManager.personalInfoIndex}?"
                    "appId=${(controller.currentIndex==0?controller.querySeekLikesList[index]:controller.querySeekVisitorsList[index]).appId}&&userId=${(controller.currentIndex==0?controller.querySeekLikesList[index]:controller.querySeekVisitorsList[index]).userId}",preventDuplicates: false,
                )!.then((value){
                  controller.update();
                });
              },
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.setRadius())),
                ),),),),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black.withOpacity(0),Colors.black.withOpacity(0.01),Colors.black.withOpacity(0.4)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.1,0.3,1]
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8.setRadius()),
                        bottomRight: Radius.circular(8.setRadius()),
                      ),
                    ),
                    padding: EdgeInsets.only(right: 8.setWidth(),top: 32.setHeight(),left: 8.setWidth(),bottom: 10.setHeight()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(!controller.haveYouChecked(index))Container(
                              padding: EdgeInsets.symmetric(vertical: 2.setHeight(),horizontal: 5.setWidth()),
                              decoration:  BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.all(Radius.circular(24.setRadius())),
                                gradient:  const LinearGradient(
                                  colors:  [Color(0xFF3A89FF),Color(0xFF7F30FF),Color(0xFFDB3EFF)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Text('New',style: getFontStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.2,
                              ),),
                            ),
                            UserOnlineStatusWidget(
                              fontSize: 12,
                              title: ['Online Now','Busy Now','Offline Now'][(controller.currentIndex==0?controller.querySeekLikesList[index]:controller.querySeekVisitorsList[index]).onlineStatus??0],
                            ),
                          ],
                        ),
                        //没聊蓝色，聊过粉色
                        BackGroundInkWidget(
                          gradient: Constants.alreadyChatDataList.contains((controller.currentIndex==0?controller.querySeekLikesList[index]:controller.querySeekVisitorsList[index]).uid.toString())? const LinearGradient(
                              colors: [Color(0xFFFD82E2), Color(0xFFFF4E98)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight
                          ):const LinearGradient(
                              colors: [Color(0xFF44C0F4),Color(0xFF3F80FF)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight
                          ),
                          padding: EdgeInsets.all(9.47.setWidth()),
                          child: ImageWidget(url: ResourceUtil.getAppPageIcon('sed_to_chat'),width: 20.8.setWidth(),),
                          onTap: (){
                            Get.toNamed(RouterManager.chatMessagePage,
                                preventDuplicates: false,arguments: (controller.currentIndex==0?controller.querySeekLikesList[index]:controller.querySeekVisitorsList[index]))!.then((value){
                              controller.update();
                            });
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }

}
