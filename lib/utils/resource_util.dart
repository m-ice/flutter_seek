
class ResourceUtil{
  /// 获取底部栏图标资源
  static String getBottomPanel(String name){
    return "assets/images/bottom_panel/$name.png";
  }
  /// 获取背景主题资源
  static String getBackground(String name){
    return "assets/images/background/$name.png";
  }
  /// 获取页面图标资源
  static String getAppPageIcon(String name,{String type='.png'}){
    return "assets/images/app_page_icon/$name$type";
  }
  /// 获取国家图标资源
  static String getCountryIcon(String name){
    return "assets/images/app_page_icon/country/$name.png";
  }
}