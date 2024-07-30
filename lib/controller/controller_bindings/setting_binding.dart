import 'package:flutter_d0601/controller/setting_controller.dart';
import 'package:get/get.dart';

class SettingBinding  extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SettingController>(() => SettingController());
  }

}