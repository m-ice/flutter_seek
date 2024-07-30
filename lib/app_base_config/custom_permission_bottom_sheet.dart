import 'package:flutter/material.dart';
import 'package:flutter_d0601/utils/screen_util.dart';
import 'package:get/get.dart';

import '../app_style/font_style.dart';
import '../page/widgets/button_ink_well_widget.dart';
import '../page/widgets/image_widget.dart';
import '../utils/resource_util.dart';

/// 自定义获取权限弹窗
class CustomPermissionBottomSheet{
  static Future<bool?> customPermissionManageBottomSheet({required String title,
    required String tips,required Map<String,String> itemMap,String buttonTitle='Allow',
    double? iconSize,
    Function? onTap}){
   return Get.bottomSheet<bool?>(
        Material(
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.setRadius()),
                  topRight: Radius.circular(20.setRadius()),
                )
            ),
            width: Get.size.width,
            height: Get.size.height*0.418,
            padding: EdgeInsets.only(right: 24.setWidth(),left: 24.setWidth(),
                bottom: 36.setHeight()+MediaQuery.of(Get.context!).padding.bottom,
                top: 24.setHeight()
            ),
            child: Column(
              children: [
                Text(title,style: getFontStyle(
                    fontHeight: 1.2,
                    fontWeight: FontWeight.w700,
                    fontSize: 20
                ),),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.setHeight()),
                  child: Text(tips,
                    textAlign: TextAlign.center,
                    style: getFontStyle(
                        fontHeight: 1.4,
                        letterSpacing: 0.2,
                        color: const Color(0xFF757575),
                        fontWeight: FontWeight.w400,
                        fontSize: 14
                    ),),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.setWidth(),vertical: 24.setHeight()),
                  padding: EdgeInsets.symmetric(horizontal: 24.setWidth(),vertical: 16.setHeight()),
                  decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(10.setRadius())
                  ),
                  child: Container(
                    width: 252.setWidth(),
                    height: 72.setHeight(),
                    color: const Color(0xFFF5F5F5),
                    child: Row(
                      mainAxisAlignment: itemMap.keys.length>1?MainAxisAlignment.spaceBetween:MainAxisAlignment.center,
                      children: itemMap.keys.map((key) =>      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ShaderMask(shaderCallback: (rect)=>const LinearGradient(colors: [
                            Color(0xFF3A89FF), Color(0xFF7F30FF), Color(0xFFDB3EFF),]).createShader(rect),
                            child: ImageWidget(url: ResourceUtil.getAppPageIcon(key),
                              width: iconSize??24.setWidth(),
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 3.setWidth(),),
                          Text('${itemMap[key]}',
                            textAlign: TextAlign.center,
                            style: getFontStyle(
                                fontHeight: 1.4,
                                letterSpacing: 0.2,
                                fontWeight: FontWeight.w400,
                                fontSize: 14
                            ),),
                        ],
                      )).toList(),

                      // [
                      //   Row(
                      //     mainAxisSize: MainAxisSize.min,
                      //     children: [
                      //       ShaderMask(shaderCallback: (rect)=>const LinearGradient(colors: [
                      //         Color(0xFF3A89FF), Color(0xFF7F30FF), Color(0xFFDB3EFF),]).createShader(rect),
                      //         child: ImageWidget(url: ResourceUtil.getAppPageIcon('camera'),
                      //           width: 24.setWidth(),
                      //           height: 24.setWidth(),
                      //           color: Colors.white,
                      //         ),
                      //       ),
                      //       Text("Camera",
                      //         textAlign: TextAlign.center,
                      //         style: getFontStyle(
                      //             fontHeight: 1.4,
                      //             letterSpacing: 0.2,
                      //             fontWeight: FontWeight.w400,
                      //             fontSize: 14
                      //         ),),
                      //     ],
                      //   ),  Row(
                      //     mainAxisSize: MainAxisSize.min,
                      //     children: [
                      //       ShaderMask(shaderCallback: (rect)=>const LinearGradient(colors: [
                      //         Color(0xFF3A89FF), Color(0xFF7F30FF), Color(0xFFDB3EFF),]).createShader(rect),
                      //         child: ImageWidget(url: ResourceUtil.getAppPageIcon('storage'),
                      //           width: 24.setWidth(),
                      //           height: 24.setWidth(),
                      //           color: Colors.white,
                      //         ),
                      //       ),
                      //       Text("Storage",
                      //         textAlign: TextAlign.center,
                      //         style: getFontStyle(
                      //             fontHeight: 1.4,
                      //             letterSpacing: 0.2,
                      //             fontWeight: FontWeight.w400,
                      //             fontSize: 14
                      //         ),),
                      //     ],
                      //   ),
                      // ],
                    ),
                  ),
                ),
                ButtonInkWellWidget(onTap: (){
                  onTap?.call();
                }, title: buttonTitle, changeColor: true)
              ],
            ),
          ),
        ),
        isDismissible: false,
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