import 'package:flutter_screenutil/flutter_screenutil.dart';


extension DuobleMatching on double{
  /// 适配宽度
  double setWidth(){
    return setScreenWidth(this);
  }
  /// 适配高度
  double setHeight(){
    return setScreenHeight(this);
  }
  /// 适配字体大小
  double setFontSize(){
    return setScreenFontSize(this);
  }
  /// 适配圆角大小
  double setRadius(){
    return setScreenRadius(this);
  }
}
extension IntMatching on int{
  /// 适配宽度
  double setWidth(){
    return setScreenWidth(double.parse(toString()));
  }
  /// 适配高度
  double setHeight(){
    return setScreenHeight(double.parse(toString()));
  }
  /// 适配字体大小
  double setFontSize(){
    return setScreenFontSize(double.parse(toString()));
  }
  /// 适配圆角大小
  double setRadius(){
    return setScreenRadius(this);
  }
}
///适配宽度
double setScreenWidth(double width){
  return ScreenUtil().setWidth(width);
}
///适配高度
double setScreenHeight(double height){
  return ScreenUtil().setHeight(height);
}
/// 适配字体大小
double setScreenFontSize(double fontSize){
  return  ScreenUtil().setSp(fontSize);
}

/// 适配圆角大小
double setScreenRadius(num r){
  return ScreenUtil().radius(r);
}