import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_d0601/common/constants.dart';
import 'package:flutter_d0601/utils/log_util.dart';
import 'package:flutter_d0601/utils/toast_util.dart' as t;
import 'package:logger/logger.dart';
import 'package:pretty_json/pretty_json.dart';

/// [LogInterceptor] is used to print logs during network requests.
/// It's better to add [LogInterceptor] to the tail of the interceptor queue,
/// otherwise the changes made in the interceptor behind A will not be printed out.
/// This is because the execution of interceptors is in the order of addition.
class LogInterceptors extends Interceptor {
  LogInterceptors({
    this.request = true,
    this.requestHeader = true,
    this.requestBody = true,
    this.responseHeader = true,
    this.responseBody = true,
    this.error = true,
    this.logPrint = print,
  });

  /// Print request [Options]
  bool request;

  /// Print request header [Options.headers]
  bool requestHeader;

  /// Print request data [Options.data]
  bool requestBody;

  /// Print [Response.data]
  bool responseBody;

  /// Print [Response.headers]
  bool responseHeader;

  /// Print error message
  bool error;

  /// Log printer; defaults print log to console.
  /// In flutter, you'd better use debugPrint.
  /// you can also write log in a file, for example:
  ///```dart
  ///  var file=File("./log.txt");
  ///  var sink=file.openWrite();
  ///  dio.interceptors.add(LogInterceptor(logPrint: sink.writeln));
  ///  ...
  ///  await sink.close();
  ///```
  void Function(Object object) logPrint;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // 设置token 和 请求时间
    // LoginData? loginData = getUserUtil();
    String reqStr =
        "\n==================================== Request start ====================================\n";
    if (request) {
      reqStr += '|- "uri": ${options.uri}\n';
      reqStr += '|- "method": ${options.method}\n';
      reqStr += '|- "responseType": ${options.responseType.toString()}\n';
      reqStr += '|- "followRedirects": ${options.followRedirects}\n';
      reqStr += '|- "connectTimeout": ${options.connectTimeout}\n';
      reqStr += '|- "sendTimeout": ${options.sendTimeout}\n';
      reqStr += '|- "receiveTimeout": ${options.receiveTimeout}\n';
      reqStr +=
          '|- "receiveDataWhenStatusError": ${options.receiveDataWhenStatusError}\n';
      reqStr += '|- "extra": ${options.extra}\n';
    }
    if (requestHeader) {
      String head = "\n{\n";
      options.headers.forEach((key, v) {
        head += "   \"$key\"：$v\n";
      });
      reqStr += '|- "headers": $head}\n';
    }
    if (requestBody) {
      // logPrint('body:');
      if (options.data is FormData || options.data is Map) {
        reqStr += '|- "body": \n${prettyJson(options.data??{})}\n';
        // logPrint(prettyJson(options.data));
      } else {
        reqStr += '|- "body": \n${options.data}\n';
        // _printAll(options.data ?? {});
      }
      reqStr +=
          '|- "queryParameters": \n${prettyJson(options.queryParameters)}\n';
    }
    log(
        "$reqStr\n==================================== Request End ====================================\n",
        name: "Request log print");
    handler.next(options);
  }


  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.data != null) {
      if(response.data is Map){
        if (response.data["code"] != 200||response.data['success']==null||response.data['success']==false) {
          /// 后端的异常 非请求异常
          t.error("${response.data['message']}");
          if (response.data["code"] == 30010205 || response.data["code"] ==  30010204) {
            Constants.commonLogOut();
          }
        }
        _printResponse(response, "Response");
      }else{
        LogUtil.logUtil('接口《${response.requestOptions.headers['method']}》响应异常，请联系后台开发人员');
        LogUtil.logInfo(response.data,level: Level.warning);
        t.error("${response.data}");
       response.data={'warning':"出现异常"};
      }
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (error) {
      logPrint(
          '==================================== DioError Start ====================================');
      logPrint('uri: ${err.requestOptions.uri}');
      logPrint('$err');
      if (err.response != null) {
        Response? errorResp = err.response!;
        t.error("${errorResp.data["message"]}");
        ///errorResp.statusCode == 401
        if (errorResp.statusCode == 401 || errorResp.data['code'] == 30010205 || errorResp.data['code'] ==  30010204) {
          Constants.commonLogOut();
        }
        _printResponse(err.response!, "DioError");
      } else {
        logPrint(
            '==================================== DioError End ====================================');
      }
    }
    handler.next(err);
  }

  void _printResponse(Response response, name) {
    String printStr =
        "\n==================================== $name Start ====================================\n";
    printStr += '|- "uri": ${response.requestOptions.uri}\n';
    printStr += '|- "方法名称": ${response.requestOptions.headers['method']}\n';
    printStr +=
        '|- "请求时间": ${response.requestOptions.headers["reqDateTime"]}\n';
    var difference = DateTime.now()
        .difference(response.requestOptions.headers["reqDateTime"]??DateTime.now());
    printStr += '|- "耗时": ${difference.inMilliseconds} ms\n';
    if (responseHeader) {
      printStr += '|- "响应码": ${response.statusCode}\n';

      if (response.isRedirect == true) {
        printStr += '|- redirect: ${response.realUri}\n';
      }
      String queryParameters = "\n";
      response.requestOptions.queryParameters
          .forEach((key, v) => queryParameters += "   L \"$key\"：$v\n");
      printStr += '|- "url参数": $queryParameters';
      if (response.requestOptions.data is Map) {
        String body = "\n";
        response.requestOptions.data
            .forEach((key, v) => body += "   L \"$key\"：$v\n");
        printStr += '|- "body参数": $body';
      }
      String head = "\n{\n";
      response.headers.forEach((key, v) {
        head += "   \"$key\"：${v.join('\r\n\t')}\n";
      });
      printStr += '|- "请求头": $head}\n';
    }
    if (responseBody) {
      if (response.data != null) {
        String data =
            response.data is Map ? prettyJson(response.data) : response.data;
        log(

                '$printStr|- 响应 Body:\n'

                "$data\n\n==================================== $name End ====================================\n",
            name: "$name log print");
      }
    }
  }
}

extension Map2StringEx on Map {
  String mapToStructureString({int indentation = 2}) {
    String result = "";
    String indentationStr = " " * indentation;
    if (true) {
      result += "{";
      forEach((key, value) {
        if (value is Map) {
          var temp = value.mapToStructureString(indentation: indentation + 2);
          result += "\n$indentationStr" "\"$key\" : $temp,";
        } else if (value is List) {
          result += "\n$indentationStr" "\"$key\" : ${value.listToStructureString(indentation: indentation + 2)},";
        } else {
          if (value is String) {
            result += "\n$indentationStr" "\"$key\" : \"$value\",";
          } else {
            result += "\n$indentationStr" "\"$key\" : \"$value\",";
          }
        }
      });
      result = result.substring(0, result.length - 1);
      result += indentation == 2 ? "\n}" : "\n${" " * (indentation - 1)}}";
    }

    return result;
  }
}

extension List2StringEx on List {
  String listToStructureString({int indentation = 2}) {
    String result = "";
    String indentationStr = " " * indentation;
    result += "$indentationStr[";
    for (var value in this) {
      if (value is Map) {
        var temp = value.mapToStructureString(indentation: indentation + 2);
        result += "\n$indentationStr" "\"$temp\",";
      } else if (value is List) {
        result += value.listToStructureString(indentation: indentation + 2);
      } else {
        result += "\n$indentationStr" "\"$value\",";
      }
    }
    result = result.substring(0, result.length - 1);
    result += "\n$indentationStr]";

    return result;
  }
}
