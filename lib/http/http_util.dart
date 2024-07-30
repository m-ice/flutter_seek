import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_d0601/utils/log_util.dart';
import 'package:flutter_d0601/utils/custom_library/custom_library_export_util.dart';

import '../common/constants.dart';
import '../enum/cache_data_enum.dart';
import 'http_config.dart';


enum RequestType {
  POST,
  GET,
  PUT,
  DEL,
}

class HttpUtil {
  static Dio? _dio;
  HttpUtil._privateConstructor();
  static final HttpUtil _instance = HttpUtil._privateConstructor();
  static HttpUtil? get instance {
    return _instance;
  }

  static HttpUtil? getInstance({List<dynamic>? interceptorsList}) {
    if (_dio == null) {
      _instance._init(interceptorsList: interceptorsList);
    }
    return _instance;
  }

  _init({List<dynamic>? interceptorsList}) {
    _dio = Dio();
    _dio!.options.baseUrl = HttpConfig.baseUrl;
    _dio!.options.connectTimeout = Duration(milliseconds: HttpConfig.connectTimeout);
    _dio!.options.receiveTimeout = Duration(milliseconds: HttpConfig.receiveTimeout);
    // 可传入多个监听器
    if (interceptorsList != null && interceptorsList.isNotEmpty) {
      for (var element in interceptorsList) {
        _dio!.interceptors.add(element);
      }
    }
    // 调试用的监听器
    // _dio!.interceptors.add(DioLogInterceptor());
  }
  /// 生成请求头
  generateRequestHeader({required String requestType,required String pathTmp,
    required String method,required String module,Map<String, dynamic>? params,dynamic data})async{
    int timestamp=0;
    try{
      timestamp=DateTime.now().millisecondsSinceEpoch;
    }catch(e){
      LogUtil.logUtil(e.toString());
    }
    Constants.loginData=CacheUserDataUtil.getCacheLoginData(CacheDataEnum.loginData);
    if(Constants.loginData!=null){
      LogUtil.logUtil("我的登录信息${Constants.loginData!.toJson()}");
    }
    _dio!.options.headers = {
      "Content-Type": "application/json",
      "module": module,
      "appId": "v.$pathTmp.$method",
      "appVersion": 1,
      "method": method,
      "appKey": "vivalive-qa",
      "timestamp": timestamp,
      // "publicKey": "3e3dcf27c0de",
      "rpcType": "dubbo",
    };
    _dio!.options.headers['sign']= MD5Util.generateMd5("content${jsonEncode(data)}method${method}module"
        "${module}rpcTypedubbotimestamp${timestamp}vivalive-qa");

    return true;
  }
  Future<Map<String, dynamic>?> get<T>(url,
      {Map<String, dynamic>? params,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    Response<Map<String, dynamic>>? map = await _dio!.get(url,
        queryParameters: params,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress);
    return map.data;
  }

  Future<Map<String, dynamic>?> post<T>(method,
      {Map<String, dynamic>? params,required String module,required String pathTmp, dynamic data}) async {

    generateRequestHeader(requestType: 'POST',pathTmp: pathTmp, method: method, module: module,data: data,params: params);
    Response<Map<String, dynamic>> map =
        await _dio!.post('', queryParameters: params, data: data);
    return map.data;
  }

  Future<Map<String, dynamic>?> postData<T>(url,
      {Map<String, dynamic>? params, dynamic data}) async {
    Response<Map<String, dynamic>> map =
        await _dio!.post(url, queryParameters: params, data: data);
    return map.data;
  }

  Future<Map<String, dynamic>?> delete<T>(url,
      {Map<String, dynamic>? params, withLoading}) async {
    Response<Map<String, dynamic>> map =
        await _dio!.delete(url, queryParameters: params);
    return map.data;
  }

  Future<Response> download(
    url, {
    Map<String, dynamic>? params,
    String savePath = '/storage/emulated/0/',
  }) async {
    Response response = await _dio!.download(url, savePath);
    return response.data;
  }

  Future<Map<String, dynamic>?> del<T>(url,
      {Map<String, dynamic>? params, dynamic data, withLoading}) async {
    Response<Map<String, dynamic>> map =
        await _dio!.delete(url, queryParameters: params, data: data);
    return map.data;
  }

  Future<Map<String, dynamic>?> put<T>(url,
      {Map<String, dynamic>? params, dynamic data, withLoading}) async {
    Response<Map<String, dynamic>> map =
        await _dio!.put(url, queryParameters: params, data: data);
    return map.data;
  }
}
