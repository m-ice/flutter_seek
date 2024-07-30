import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ViewImagesController extends GetxController{
  List<String> imageList=[];
  int currentIndex=0;
  PageController? pageController;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Map map=Get.arguments as Map;
    imageList=map["imageList"]??[];
    if(map['index']!=null){
      currentIndex=map['index']??0;
    }
    pageController=PageController(initialPage: currentIndex);
  }
}