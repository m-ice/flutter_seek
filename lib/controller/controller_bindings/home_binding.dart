import 'package:get/get.dart';
import '../circle_controller.dart';
import '../home_controller.dart';
import '../my_controller.dart';
import '../sed_controller.dart';
import '../discover_controller.dart';


class HomeBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<SedController>(() => SedController());
    Get.lazyPut<DiscoverController>(() => DiscoverController());
    Get.lazyPut<CircleController>(() => CircleController());
    Get.lazyPut<MyController>(() => MyController());
  }
}