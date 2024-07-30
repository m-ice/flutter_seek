import 'package:flutter_d0601/generated/json/base/json_convert_content.dart';
import 'package:flutter_d0601/page/model/upload_resource_configuration_entity.dart';

UploadResourceConfigurationEntity $UploadResourceConfigurationEntityFromJson(
    Map<String, dynamic> json) {
  final UploadResourceConfigurationEntity uploadResourceConfigurationEntity = UploadResourceConfigurationEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    uploadResourceConfigurationEntity.code = code;
  }
  final UploadResourceConfigurationData? data = jsonConvert.convert<
      UploadResourceConfigurationData>(json['data']);
  if (data != null) {
    uploadResourceConfigurationEntity.data = data;
  }
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    uploadResourceConfigurationEntity.success = success;
  }
  final dynamic requestId = json['requestId'];
  if (requestId != null) {
    uploadResourceConfigurationEntity.requestId = requestId;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    uploadResourceConfigurationEntity.message = message;
  }
  return uploadResourceConfigurationEntity;
}

Map<String, dynamic> $UploadResourceConfigurationEntityToJson(
    UploadResourceConfigurationEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['data'] = entity.data?.toJson();
  data['success'] = entity.success;
  data['requestId'] = entity.requestId;
  data['message'] = entity.message;
  return data;
}

extension UploadResourceConfigurationEntityExtension on UploadResourceConfigurationEntity {
  UploadResourceConfigurationEntity copyWith({
    int? code,
    UploadResourceConfigurationData? data,
    bool? success,
    dynamic requestId,
    String? message,
  }) {
    return UploadResourceConfigurationEntity()
      ..code = code ?? this.code
      ..data = data ?? this.data
      ..success = success ?? this.success
      ..requestId = requestId ?? this.requestId
      ..message = message ?? this.message;
  }
}

UploadResourceConfigurationData $UploadResourceConfigurationDataFromJson(
    Map<String, dynamic> json) {
  final UploadResourceConfigurationData uploadResourceConfigurationData = UploadResourceConfigurationData();
  final String? ossType = jsonConvert.convert<String>(json['ossType']);
  if (ossType != null) {
    uploadResourceConfigurationData.ossType = ossType;
  }
  final String? accessUrl = jsonConvert.convert<String>(json['accessUrl']);
  if (accessUrl != null) {
    uploadResourceConfigurationData.accessUrl = accessUrl;
  }
  final String? filePath = jsonConvert.convert<String>(json['filePath']);
  if (filePath != null) {
    uploadResourceConfigurationData.filePath = filePath;
  }
  final String? accessSecret = jsonConvert.convert<String>(
      json['accessSecret']);
  if (accessSecret != null) {
    uploadResourceConfigurationData.accessSecret = accessSecret;
  }
  final String? bucket = jsonConvert.convert<String>(json['bucket']);
  if (bucket != null) {
    uploadResourceConfigurationData.bucket = bucket;
  }
  final String? securityToken = jsonConvert.convert<String>(
      json['securityToken']);
  if (securityToken != null) {
    uploadResourceConfigurationData.securityToken = securityToken;
  }
  final String? uploadHost = jsonConvert.convert<String>(json['uploadHost']);
  if (uploadHost != null) {
    uploadResourceConfigurationData.uploadHost = uploadHost;
  }
  final String? accessKey = jsonConvert.convert<String>(json['accessKey']);
  if (accessKey != null) {
    uploadResourceConfigurationData.accessKey = accessKey;
  }
  final int? configId = jsonConvert.convert<int>(json['configId']);
  if (configId != null) {
    uploadResourceConfigurationData.configId = configId;
  }
  final String? domain = jsonConvert.convert<String>(json['domain']);
  if (domain != null) {
    uploadResourceConfigurationData.domain = domain;
  }
  final String? region = jsonConvert.convert<String>(json['region']);
  if (region != null) {
    uploadResourceConfigurationData.region = region;
  }
  final int? expirySeconds = jsonConvert.convert<int>(json['expirySeconds']);
  if (expirySeconds != null) {
    uploadResourceConfigurationData.expirySeconds = expirySeconds;
  }
  return uploadResourceConfigurationData;
}

Map<String, dynamic> $UploadResourceConfigurationDataToJson(
    UploadResourceConfigurationData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ossType'] = entity.ossType;
  data['accessUrl'] = entity.accessUrl;
  data['filePath'] = entity.filePath;
  data['accessSecret'] = entity.accessSecret;
  data['bucket'] = entity.bucket;
  data['securityToken'] = entity.securityToken;
  data['uploadHost'] = entity.uploadHost;
  data['accessKey'] = entity.accessKey;
  data['configId'] = entity.configId;
  data['domain'] = entity.domain;
  data['region'] = entity.region;
  data['expirySeconds'] = entity.expirySeconds;
  return data;
}

extension UploadResourceConfigurationDataExtension on UploadResourceConfigurationData {
  UploadResourceConfigurationData copyWith({
    String? ossType,
    String? accessUrl,
    String? filePath,
    String? accessSecret,
    String? bucket,
    String? securityToken,
    String? uploadHost,
    String? accessKey,
    int? configId,
    String? domain,
    String? region,
    int? expirySeconds,
  }) {
    return UploadResourceConfigurationData()
      ..ossType = ossType ?? this.ossType
      ..accessUrl = accessUrl ?? this.accessUrl
      ..filePath = filePath ?? this.filePath
      ..accessSecret = accessSecret ?? this.accessSecret
      ..bucket = bucket ?? this.bucket
      ..securityToken = securityToken ?? this.securityToken
      ..uploadHost = uploadHost ?? this.uploadHost
      ..accessKey = accessKey ?? this.accessKey
      ..configId = configId ?? this.configId
      ..domain = domain ?? this.domain
      ..region = region ?? this.region
      ..expirySeconds = expirySeconds ?? this.expirySeconds;
  }
}