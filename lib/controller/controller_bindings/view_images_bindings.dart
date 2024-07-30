import 'package:get/get.dart';
import '../view_images_controller.dart';

class ViewImagesBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ViewImagesController>(() => ViewImagesController());
  }

}