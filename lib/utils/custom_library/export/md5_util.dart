import 'package:crypto/crypto.dart';
import 'dart:convert';


/// md5工具
class MD5Util{
  static String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString().toUpperCase();
  }
}