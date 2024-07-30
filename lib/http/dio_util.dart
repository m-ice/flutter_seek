import '../utils/log_util.dart';
import 'dio_interceptors.dart';
import 'http_util.dart';

// 二次封装使用
class DioUtil{
  static  DioUtil? _instance;
  late HttpUtil httpUtil;

  // 私有的命名构造函数
  DioUtil._internal();

  static DioUtil getInstance() {
    if (_instance == null) {
      _instance = DioUtil._internal();
      _instance!._init();
    }
    return _instance!;
  }
  _init() {
    LogUtil.logUtil("初始化",tag: "dio_util");
    // 调试用的监听器
    httpUtil = HttpUtil.getInstance(interceptorsList: [
      LogInterceptors(),
    ])!;
  }
}