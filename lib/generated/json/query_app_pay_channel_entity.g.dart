import 'package:flutter_d0601/generated/json/base/json_convert_content.dart';
import 'package:flutter_d0601/page/home/my/model/query_app_pay_channel_entity.dart';

QueryAppPayChannelEntity $QueryAppPayChannelEntityFromJson(
    Map<String, dynamic> json) {
  final QueryAppPayChannelEntity queryAppPayChannelEntity = QueryAppPayChannelEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    queryAppPayChannelEntity.code = code;
  }
  final List<QueryAppPayChannelData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<QueryAppPayChannelData>(e) as QueryAppPayChannelData)
      .toList();
  if (data != null) {
    queryAppPayChannelEntity.data = data;
  }
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    queryAppPayChannelEntity.success = success;
  }
  final dynamic requestId = json['requestId'];
  if (requestId != null) {
    queryAppPayChannelEntity.requestId = requestId;
  }
  final int? count = jsonConvert.convert<int>(json['count']);
  if (count != null) {
    queryAppPayChannelEntity.count = count;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    queryAppPayChannelEntity.message = message;
  }
  return queryAppPayChannelEntity;
}

Map<String, dynamic> $QueryAppPayChannelEntityToJson(
    QueryAppPayChannelEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  data['success'] = entity.success;
  data['requestId'] = entity.requestId;
  data['count'] = entity.count;
  data['message'] = entity.message;
  return data;
}

extension QueryAppPayChannelEntityExtension on QueryAppPayChannelEntity {
  QueryAppPayChannelEntity copyWith({
    int? code,
    List<QueryAppPayChannelData>? data,
    bool? success,
    dynamic requestId,
    int? count,
    String? message,
  }) {
    return QueryAppPayChannelEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..success = success ?? this.success
      ..requestId = requestId ?? this.requestId
      ..count = count ?? this.count
      ..message = message ?? this.message;
  }
}

QueryAppPayChannelData $QueryAppPayChannelDataFromJson(
    Map<String, dynamic> json) {
  final QueryAppPayChannelData queryAppPayChannelData = QueryAppPayChannelData();
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    queryAppPayChannelData.country = country;
  }
  final dynamic gmtModify = json['gmtModify'];
  if (gmtModify != null) {
    queryAppPayChannelData.gmtModify = gmtModify;
  }
  final double? presentRate = jsonConvert.convert<double>(json['presentRate']);
  if (presentRate != null) {
    queryAppPayChannelData.presentRate = presentRate;
  }
  final int? probability = jsonConvert.convert<int>(json['probability']);
  if (probability != null) {
    queryAppPayChannelData.probability = probability;
  }
  final String? icon = jsonConvert.convert<String>(json['icon']);
  if (icon != null) {
    queryAppPayChannelData.icon = icon;
  }
  final int? sort = jsonConvert.convert<int>(json['sort']);
  if (sort != null) {
    queryAppPayChannelData.sort = sort;
  }
  final dynamic gmtCreate = json['gmtCreate'];
  if (gmtCreate != null) {
    queryAppPayChannelData.gmtCreate = gmtCreate;
  }
  final int? payType = jsonConvert.convert<int>(json['payType']);
  if (payType != null) {
    queryAppPayChannelData.payType = payType;
  }
  final int? enable = jsonConvert.convert<int>(json['enable']);
  if (enable != null) {
    queryAppPayChannelData.enable = enable;
  }
  final String? appId = jsonConvert.convert<String>(json['appId']);
  if (appId != null) {
    queryAppPayChannelData.appId = appId;
  }
  final String? payChannel = jsonConvert.convert<String>(json['payChannel']);
  if (payChannel != null) {
    queryAppPayChannelData.payChannel = payChannel;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    queryAppPayChannelData.id = id;
  }
  return queryAppPayChannelData;
}

Map<String, dynamic> $QueryAppPayChannelDataToJson(
    QueryAppPayChannelData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['country'] = entity.country;
  data['gmtModify'] = entity.gmtModify;
  data['presentRate'] = entity.presentRate;
  data['probability'] = entity.probability;
  data['icon'] = entity.icon;
  data['sort'] = entity.sort;
  data['gmtCreate'] = entity.gmtCreate;
  data['payType'] = entity.payType;
  data['enable'] = entity.enable;
  data['appId'] = entity.appId;
  data['payChannel'] = entity.payChannel;
  data['id'] = entity.id;
  return data;
}

extension QueryAppPayChannelDataExtension on QueryAppPayChannelData {
  QueryAppPayChannelData copyWith({
    String? country,
    dynamic gmtModify,
    double? presentRate,
    int? probability,
    String? icon,
    int? sort,
    dynamic gmtCreate,
    int? payType,
    int? enable,
    String? appId,
    String? payChannel,
    int? id,
  }) {
    return QueryAppPayChannelData()
      ..country = country ?? this.country
      ..gmtModify = gmtModify ?? this.gmtModify
      ..presentRate = presentRate ?? this.presentRate
      ..probability = probability ?? this.probability
      ..icon = icon ?? this.icon
      ..sort = sort ?? this.sort
      ..gmtCreate = gmtCreate ?? this.gmtCreate
      ..payType = payType ?? this.payType
      ..enable = enable ?? this.enable
      ..appId = appId ?? this.appId
      ..payChannel = payChannel ?? this.payChannel
      ..id = id ?? this.id;
  }
}