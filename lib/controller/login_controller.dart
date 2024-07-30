import 'package:flutter_d0601/utils/google_plug_util.dart';
import 'package:get/get.dart';
import '../enum/login_type_enum.dart';
import '../page/router/router_manager.dart';
import '../utils/app_package_info_util.dart';
import '../utils/toast_util.dart';



class LoginController extends GetxController{

  /// 是否同意隐私协议及用户协议
  bool agreementConsent=false;

  @override
  void onInit(){
    super.onInit();
    GooglePlugUtil.googleAuthListen();
    setAgreementConsent();
  }

  setAgreementConsent(){
    agreementConsent=!agreementConsent;
    if(AppPackageInfoUtil.deviceId==null||AppPackageInfoUtil.networkAddress==null){
      AppPackageInfoUtil.getPackageInfo();
    }
    update();
  }

  loginSubmit({LoginTypeEnum loginTypeEnum=LoginTypeEnum.google}){
    if(!agreementConsent) {
      return toast('Please agree to the agreement!');
    }
    switch(loginTypeEnum){
      case LoginTypeEnum.phone:
        Get.toNamed(RouterManager.phoneLogin);
        break;
      case LoginTypeEnum.google:
        GooglePlugUtil.signInWithGoogle();
        // GooglePlugUtil.handleSignIn();
        // Get.offNamed(RouterManager.personalBasicInformation);
        break;
    }
  }
}