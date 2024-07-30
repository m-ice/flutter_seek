

import 'package:get/get.dart';

import '../vip_of_open_or_details_controller.dart';

class VipOfOpenOrDetailsBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<VipOfOpenOrDetailsController>(() => VipOfOpenOrDetailsController());
  }

}