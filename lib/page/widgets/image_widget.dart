import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_d0601/controller/overlay_entry_global_config_controller.dart';

import 'package:flutter_d0601/page/widgets/image_error_widget.dart';
import 'package:flutter_d0601/utils/screen_util.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'loading_image_widget.dart';

final networkUrlReg=RegExp('^http');
// final assetsUrlReg=RegExp('^assets');
class ImageWidget extends StatelessWidget {
  final dynamic  url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;
  final Function? onTapDown;
  final Function? onTap;
  final Function? onLongPress;
  final BorderRadius? borderRadius;
  const ImageWidget({Key? key, required this.url, this.width, this.height,this.color, this.fit=BoxFit.cover, this.borderRadius, this.onTapDown, this.onTap, this.onLongPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child:
      networkUrlReg.hasMatch(url.toString())?
      CachedNetworkImage(
        imageUrl: url,
        placeholder: (context, url) =>LoadingImageWidget(width: width,height: height,),
        errorWidget: (context, url, error) =>  LoadingImageWidget(width: width,height: height,),
        //     ImageErrorWidget(
        //   width: width!=null?width!:60.setWidth(),
        //   height: height!=null?height!:60.setWidth(),
        //   error: error.toString(),
        // ),
        fit: fit,
        width: width,
        height: height,
      )
      // Stack(
      //   children: [
      //     ClipRRect(
      //         borderRadius: borderRadius??BorderRadius.zero,
      //         child: CachedNetworkImage(
      //           imageUrl: url,
      //           placeholder: (context, url) =>LoadingImageWidget(width: width,height: height,),
      //           errorWidget: (context, url, error) =>  ImageErrorWidget(
      //             width: width!=null?width!:60.setWidth(),
      //             height: height!=null?height!:60.setWidth(),
      //             error: error.toString(),
      //           ),
      //           fit: fit,
      //           width: width,
      //           height: height,
      //         ),
      //     ),
      //     Positioned.fill(child: Material(
      //       color: Colors.transparent,
      //       child: InkWell(
      //         borderRadius: borderRadius??BorderRadius.zero,
      //         onTap: (){
      //           onTap?.call();
      //         },
      //         onTapDown: (v){
      //           onTapDown?.call(v);
      //         },
      //         onLongPress: (){
      //           onLongPress?.call();
      //         },
      //         child: Ink(
      //           width: width,
      //           height: height,
      //           decoration: BoxDecoration(
      //             color: Colors.transparent,
      //             borderRadius: borderRadius??BorderRadius.zero,
      //           ),
      //         ),
      //       ),
      //     )),
      //   ],
      // )
          : ( url is AssetEntity?
      SizedBox(
        width: width,
        height: height,
        child: Image(image: AssetEntityImageProvider(url, isOriginal: false),fit: BoxFit.cover,
          errorBuilder: (context,error,stackTrace,)=> LoadingImageWidget(width: width,height: height,),
          //     ImageErrorWidget(
          //   width: width!=null?width!:60.setWidth(),
          //   height: height!=null?height!:60.setWidth(),
          //   error: error.toString(),
          // ),
        ),
      )
          :Image.asset(url, width: width,color: color,height: height,fit: fit,
        errorBuilder: (context,error,stackTrace,)=> LoadingImageWidget(width: width,height: height,),
        // ImageErrorWidget(
        //   width: width!=null?width!:60.setWidth(),
        //   height: height!=null?height!:60.setWidth(),
        //   error: error.toString(),
        // ),
      )),

    );
  }
}

