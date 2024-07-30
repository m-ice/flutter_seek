import 'package:get/get.dart';

class UserAgreementOrPrivacyPolicyController extends GetxController{
  String title='';
  String userPrivacyKey='';
  double onProgress=0;
  String? url;
  // RegExp regExp=RegExp('http');
  // RegExpMatch? regExpMatch;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    title=Get.parameters['title'].toString();
    if(Get.parameters['userPrivacyKey']!=null){
      userPrivacyKey=Get.parameters['userPrivacyKey'].toString();
    }else{
      url=Get.parameters['url'].toString();
    }

  }
}