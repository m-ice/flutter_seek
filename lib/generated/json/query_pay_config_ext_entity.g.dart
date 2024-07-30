import 'package:flutter_d0601/generated/json/base/json_convert_content.dart';
import 'package:flutter_d0601/page/home/my/model/query_pay_config_ext_entity.dart';

QueryPayConfigExtEntity $QueryPayConfigExtEntityFromJson(
    Map<String, dynamic> json) {
  final QueryPayConfigExtEntity queryPayConfigExtEntity = QueryPayConfigExtEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    queryPayConfigExtEntity.code = code;
  }
  final QueryPayConfigExtData? data = jsonConvert.convert<
      QueryPayConfigExtData>(json['data']);
  if (data != null) {
    queryPayConfigExtEntity.data = data;
  }
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    queryPayConfigExtEntity.success = success;
  }
  final dynamic requestId = json['requestId'];
  if (requestId != null) {
    queryPayConfigExtEntity.requestId = requestId;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    queryPayConfigExtEntity.message = message;
  }
  return queryPayConfigExtEntity;
}

Map<String, dynamic> $QueryPayConfigExtEntityToJson(
    QueryPayConfigExtEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data?.toJson();
  data['success'] = entity.success;
  data['requestId'] = entity.requestId;
  data['message'] = entity.message;
  return data;
}

extension QueryPayConfigExtEntityExtension on QueryPayConfigExtEntity {
  QueryPayConfigExtEntity copyWith({
    int? code,
    QueryPayConfigExtData? data,
    bool? success,
    dynamic requestId,
    String? message,
  }) {
    return QueryPayConfigExtEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..success = success ?? this.success
      ..requestId = requestId ?? this.requestId
      ..message = message ?? this.message;
  }
}

QueryPayConfigExtData $QueryPayConfigExtDataFromJson(
    Map<String, dynamic> json) {
  final QueryPayConfigExtData queryPayConfigExtData = QueryPayConfigExtData();
  final int? channelType = jsonConvert.convert<int>(json['channelType']);
  if (channelType != null) {
    queryPayConfigExtData.channelType = channelType;
  }
  return queryPayConfigExtData;
}

Map<String, dynamic> $QueryPayConfigExtDataToJson(
    QueryPayConfigExtData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['channelType'] = entity.channelType;
  return data;
}

extension QueryPayConfigExtDataExtension on QueryPayConfigExtData {
  QueryPayConfigExtData copyWith({
    int? channelType,
  }) {
    return QueryPayConfigExtData()
      ..channelType = channelType ?? this.channelType;
  }
}