import 'package:flutter_d0601/generated/json/base/json_convert_content.dart';
import 'package:flutter_d0601/page/home/my/model/recharge_entity.dart';

RechargeEntity $RechargeEntityFromJson(Map<String, dynamic> json) {
  final RechargeEntity rechargeEntity = RechargeEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    rechargeEntity.code = code;
  }
  final RechargeData? data = jsonConvert.convert<RechargeData>(json['data']);
  if (data != null) {
    rechargeEntity.data = data;
  }
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    rechargeEntity.success = success;
  }
  final dynamic requestId = json['requestId'];
  if (requestId != null) {
    rechargeEntity.requestId = requestId;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    rechargeEntity.message = message;
  }
  return rechargeEntity;
}

Map<String, dynamic> $RechargeEntityToJson(RechargeEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data?.toJson();
  data['success'] = entity.success;
  data['requestId'] = entity.requestId;
  data['message'] = entity.message;
  return data;
}

extension RechargeEntityExtension on RechargeEntity {
  RechargeEntity copyWith({
    int? code,
    RechargeData? data,
    bool? success,
    dynamic requestId,
    String? message,
  }) {
    return RechargeEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..success = success ?? this.success
      ..requestId = requestId ?? this.requestId
      ..message = message ?? this.message;
  }
}

RechargeData $RechargeDataFromJson(Map<String, dynamic> json) {
  final RechargeData rechargeData = RechargeData();
  final String? orderId = jsonConvert.convert<String>(json['orderId']);
  if (orderId != null) {
    rechargeData.orderId = orderId;
  }
  final String? extra = jsonConvert.convert<String>(json['extra']);
  if (extra != null) {
    rechargeData.extra = extra;
  }
  return rechargeData;
}

Map<String, dynamic> $RechargeDataToJson(RechargeData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['orderId'] = entity.orderId;
  data['extra'] = entity.extra;
  return data;
}

extension RechargeDataExtension on RechargeData {
  RechargeData copyWith({
    String? orderId,
    String? extra,
  }) {
    return RechargeData()
      ..orderId = orderId ?? this.orderId
      ..extra = extra ?? this.extra;
  }
}