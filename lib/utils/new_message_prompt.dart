import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_d0601/app_style/font_style.dart';
import 'package:flutter_d0601/page/home/discover/model/friend_entity.dart';
import 'package:flutter_d0601/page/widgets/image_widget.dart';
import 'package:flutter_d0601/utils/loader_overlay_util.dart';
import 'package:flutter_d0601/utils/screen_util.dart';
import 'package:get/get.dart';

import '../page/home/discover/model/friend.dart';
import '../page/router/router_manager.dart';
import '../page/widgets/parent_ink_well_widget.dart';

/// 新消息提示
class NewMessagePrompt{
  static void newMessagePrompt({required FriendEntity friend}){
    BotToast.showCustomNotification(
      duration: const Duration(seconds: 3),
      toastBuilder: (void Function() cancelFunc) {
        return Material(
          color: Colors.transparent,
          child: ParentInkWellWidget(
            onTap: (){
              LoaderOverlayUtil loaderOverlayUtil=LoaderOverlayUtil();
              loaderOverlayUtil.hide();
              Get.toNamed("${RouterManager.personalInfoIndex}?appId=${friend.appId}&&userId=${friend.userId}",preventDuplicates: false);
            },
            borderRadius: BorderRadius.all(Radius.circular(12.setRadius())),
            child: Container(
              margin: EdgeInsets.only(top: 20.setHeight()),
              width: Get.width-32,
              height: 70.setHeight(),
              padding: EdgeInsets.only(bottom:12.setHeight(),top: 12.setHeight(),right:  20.setWidth(),left: 12.setWidth()),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12.setRadius()))
              ),
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(53.setRadius())),
                      child: ImageWidget(url: friend.portrait.toString(),width: 42.setWidth(),height: 42.setWidth(),),
                    ),
                  SizedBox(
                    width: 8.setWidth(),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${friend.nickname}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getFontStyle(
                          fontWeight: FontWeight.w700,
                          fontHeight: 1.4,
                          fontSize: 16,
                          letterSpacing: 0.2,
                        ),),
                        SizedBox(height: 2.setHeight(),),
                        Text('${friend.message}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getFontStyle(
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF424242),
                          fontHeight: 1.2,
                          fontSize: 14,
                          letterSpacing: 0.2,
                        ),)
                      ],
                    ),
                  ),
                  ParentInkWellWidget(
                    onTap: (){
                      LoaderOverlayUtil loaderOverlayUtil=LoaderOverlayUtil();
                      loaderOverlayUtil.hide();
                      Get.toNamed("${RouterManager.chatMessagePage}?appId=${friend.appId}&&targetId=${friend.targetId}&&userId=${friend.userId}",preventDuplicates: false);
                    },
                    borderRadius: BorderRadius.all(Radius.circular(34.setWidth())),
                    child: ShaderMask(
                      shaderCallback: (rect){
                        return const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF3A89FF),Color(0xFF7F30FF),Color(0xFFDB3EFF)],
                        ).createShader(rect);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 4.setHeight(),horizontal: 12.setWidth()),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(34.setWidth())),
                            border: Border.all(color: Colors.white,width: 1.setWidth())
                        ),
                        child: Text('View',style: getFontStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.2,
                        ),),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}