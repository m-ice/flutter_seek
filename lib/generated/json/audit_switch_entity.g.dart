import 'package:flutter_d0601/generated/json/base/json_convert_content.dart';
import 'package:flutter_d0601/page/model/audit_switch_entity.dart';

AuditSwitchEntity $AuditSwitchEntityFromJson(Map<String, dynamic> json) {
  final AuditSwitchEntity auditSwitchEntity = AuditSwitchEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    auditSwitchEntity.code = code;
  }
  final AuditSwitchData? data = jsonConvert.convert<AuditSwitchData>(
      json['data']);
  if (data != null) {
    auditSwitchEntity.data = data;
  }
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    auditSwitchEntity.success = success;
  }
  final dynamic requestId = json['requestId'];
  if (requestId != null) {
    auditSwitchEntity.requestId = requestId;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    auditSwitchEntity.message = message;
  }
  return auditSwitchEntity;
}

Map<String, dynamic> $AuditSwitchEntityToJson(AuditSwitchEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data?.toJson();
  data['success'] = entity.success;
  data['requestId'] = entity.requestId;
  data['message'] = entity.message;
  return data;
}

extension AuditSwitchEntityExtension on AuditSwitchEntity {
  AuditSwitchEntity copyWith({
    int? code,
    AuditSwitchData? data,
    bool? success,
    dynamic requestId,
    String? message,
  }) {
    return AuditSwitchEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..success = success ?? this.success
      ..requestId = requestId ?? this.requestId
      ..message = message ?? this.message;
  }
}

AuditSwitchData $AuditSwitchDataFromJson(Map<String, dynamic> json) {
  final AuditSwitchData auditSwitchData = AuditSwitchData();
  final int? appVersion = jsonConvert.convert<int>(json['appVersion']);
  if (appVersion != null) {
    auditSwitchData.appVersion = appVersion;
  }
  final int? paySwitch = jsonConvert.convert<int>(json['paySwitch']);
  if (paySwitch != null) {
    auditSwitchData.paySwitch = paySwitch;
  }
  final int? docSwitch = jsonConvert.convert<int>(json['docSwitch']);
  if (docSwitch != null) {
    auditSwitchData.docSwitch = docSwitch;
  }
  return auditSwitchData;
}

Map<String, dynamic> $AuditSwitchDataToJson(AuditSwitchData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['appVersion'] = entity.appVersion;
  data['paySwitch'] = entity.paySwitch;
  data['docSwitch'] = entity.docSwitch;
  return data;
}

extension AuditSwitchDataExtension on AuditSwitchData {
  AuditSwitchData copyWith({
    int? appVersion,
    int? paySwitch,
    int? docSwitch,
  }) {
    return AuditSwitchData()
      ..appVersion = appVersion ?? this.appVersion
      ..paySwitch = paySwitch ?? this.paySwitch
      ..docSwitch = docSwitch ?? this.docSwitch;
  }
}