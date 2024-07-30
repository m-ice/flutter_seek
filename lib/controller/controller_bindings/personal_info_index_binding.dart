import 'package:flutter_d0601/controller/personal_info_index_controller.dart';
import 'package:get/get.dart';

class PersonalInfoIndexBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PersonalInfoIndexController>(() => PersonalInfoIndexController());
  }

}