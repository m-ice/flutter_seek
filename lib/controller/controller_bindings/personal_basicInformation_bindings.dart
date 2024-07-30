import 'package:flutter_d0601/controller/personal_basicInformation_controller.dart';
import 'package:get/get.dart';

class PersonalBasicInformationBindings implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PersonalBasicInformationController>(() => PersonalBasicInformationController());
  }
}
