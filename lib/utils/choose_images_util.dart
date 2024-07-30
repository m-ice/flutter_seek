import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

/// 图片选择工具
class ChooseImagesUtil{

  /// 选择图片  maxAssets：最多选择数 requestType：选择类型 - image common video audio all
  static Future<List<AssetEntity>> resultImages({int maxAssets=1,RequestType requestType=RequestType.image,
    List<AssetEntity>? selectedAssets,
  })async{
    final List<AssetEntity>? result = await AssetPicker.pickAssets(
      Get.context!,
      pickerConfig: AssetPickerConfig(
          maxAssets: maxAssets, requestType: requestType,
        selectedAssets: selectedAssets
      ),
    );
    return result??[];
  }
}