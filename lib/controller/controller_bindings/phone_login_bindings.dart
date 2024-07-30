import 'package:flutter_d0601/controller/phone_login_controller.dart';
import 'package:get/get.dart';

class PhoneLoginBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PhoneLoginController>(() => PhoneLoginController());
  }
}