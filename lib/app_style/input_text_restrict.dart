

class InputTextRestrict{
  /// 禁止输入空格
  static const String regexNotNull = "[\\s]";
  /// 第一个输入字符不能为空格
  static const String regexFirstNotNull = r'^(\S){1}';
  /// 仅支持数字
  static const String regexOnlyNumber = "[0-9]";
  /// 仅支持字母和数字
  static const String regexOnlyNumberText = "[a-zA-Z]|[0-9]";
}