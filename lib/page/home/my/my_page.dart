import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_d0601/app_style/font_style.dart';
import 'package:flutter_d0601/common/constants.dart';
import 'package:flutter_d0601/controller/my_controller.dart';
import 'package:flutter_d0601/page/widgets/circular_avatar_widget.dart';
import 'package:flutter_d0601/page/router/router_manager.dart';
import 'package:flutter_d0601/page/widgets/back_ground_widget.dart';
import 'package:flutter_d0601/page/widgets/image_widget.dart';
import 'package:flutter_d0601/page/widgets/list_tile_widget.dart';
import 'package:flutter_d0601/page/widgets/parent_ink_well_widget.dart';
import 'package:flutter_d0601/utils/resource_util.dart';
import 'package:flutter_d0601/utils/screen_util.dart';
import 'package:flutter_d0601/utils/custom_library/custom_library_export_util.dart';
import 'package:get/get.dart';

import '../../../app_base_config/permission_manage.dart';
import '../../../utils/choose_images_util.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  MyController myController=Get.find<MyController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyController>(
      init: myController,
      builder: (controller) {
        return Scaffold(
          body: BackGroundWidget(
            backGroundName: "bg_1",
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 48.setHeight(),),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 16.setHeight()),
                        child: ParentInkWellWidget(
                          onTap: (){
                            PermissionManage.requestPhotosPermission().then((value)async{
                              if(value??false){
                                ChooseImagesUtil.resultImages().then((value)async{
                                  if(value.isNotEmpty){
                                    controller..headImg=value[0]..update();
                                    File? file=await value[0].file;
                                    UploadOssUtil.uploadOss(file: file!,sort: 0,onSendProgress: (count,data){
                                      // controller..uploadProgressMap[index]=count*100/data..update();
                                    },onReceiveProgress: (count,data){
                                      // controller..uploadProgressMap[index]=null..update();
                                    }
                                    ).then((value){
                                      if(value!=null){
                                        controller..headImg=value['address']..update();
                                        controller.updateUser();
                                      }
                                    });
                                  }
                                });
                              }
                            });
                          },
                          borderRadius: BorderRadius.all(Radius.circular(80.setRadius())),
                          child: CircularAvatarWidget(size: 80.setWidth(),
                            url: controller.headImg??'',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.setWidth()),
                        child: Text(Constants.loginData!=null?Constants.loginData!.userInfo!.nickname??'':'',textAlign: TextAlign.center,style: getFontStyle(
                            fontSize: 20,
                            fontHeight: 1.2,
                            fontWeight: FontWeight.w700
                        ),),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.setWidth()),
                  child: ParentInkWellWidget(
                    onTap: (){
                      Get.toNamed(RouterManager.vipOfOpenOrDetails);
                    },
                    borderRadius: BorderRadius.all(Radius.circular(10.setRadius())),
                    child: Ink(
                        height: 72.setHeight(),
                        padding: EdgeInsets.only(left: 20.setWidth()),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(ResourceUtil.getBackground("my_bg2")),
                                fit: BoxFit.cover
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10.setRadius()))
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("VIP Center",style: getFontStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontHeight: 1.2,
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic,
                            ),),
                            const Spacer(),
                            controller.isOpenMembership?Padding(
                              padding: EdgeInsets.only(right: 24.setWidth()),
                              child: ImageWidget(
                                url: ResourceUtil.getAppPageIcon('vip'),
                                width: 24.setWidth(),
                                height: 24.setWidth(),),
                            ) :Container(
                              margin: EdgeInsets.only(right: 20.setWidth()),
                              padding: EdgeInsets.symmetric(vertical: 4.setHeight(),horizontal: 10.setWidth()),
                              decoration:  BoxDecoration(
                                  color: const Color(0xFFFFF3DB),
                                  borderRadius: BorderRadius.all(Radius.circular(60.setRadius()))
                              ),
                              child: Text("\$ ${controller.moneyConfigDataList.isNotEmpty?controller.moneyConfigDataList[0].price:'0.0'}",style: getFontStyle(
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFDAB367),
                                  fontHeight: 1.4,
                                  fontSize: 16,
                                  letterSpacing: 0.2
                              ),),
                            ),
                          ],
                        )
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 16.setWidth(),vertical: 5.setHeight()),
                child: ListTileWidget(
                  title: 'Edit Profile',
                  leftIconHeight: 19.2,
                  leftIconPath: ResourceUtil.getAppPageIcon("my_edit"),
                  onTap: (){
                    debugPrint("Edit Profile");
                    Get.toNamed(RouterManager.editProfile);
                    },
                ),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 16.setWidth(),vertical: 5.setHeight()),
                  child: ListTileWidget(
                    title: 'Setting',
                    leftIconHeight: 19.2,
                    leftIconPath: ResourceUtil.getAppPageIcon("my_setting"),
                    onTap: (){
                      Get.toNamed(RouterManager.setting);
                      debugPrint("Setting");
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 16.setWidth(),vertical: 5.setHeight()),
                  child: ListTileWidget(
                    title: 'About',
                    leftIconHeight: 19.2,
                    leftIconPath: ResourceUtil.getAppPageIcon("my_about"),
                    onTap: (){
                      Get.toNamed(RouterManager.aboutPage);
                      debugPrint("Edit Profile");
                    },
                  ),
                )
              ],
            ),
          )
        );
      }
    );
  }

}
