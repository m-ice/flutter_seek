import 'package:flutter_d0601/generated/json/base/json_field.dart';
import 'package:flutter_d0601/generated/json/upload_resource_configuration_entity.g.dart';
import 'dart:convert';
export 'package:flutter_d0601/generated/json/upload_resource_configuration_entity.g.dart';

@JsonSerializable()
class UploadResourceConfigurationEntity {
	int? code;
	UploadResourceConfigurationData? data;
	bool? success;
	dynamic requestId;
	String? message;

	UploadResourceConfigurationEntity();

	factory UploadResourceConfigurationEntity.fromJson(Map<String, dynamic> json) => $UploadResourceConfigurationEntityFromJson(json);

	Map<String, dynamic> toJson() => $UploadResourceConfigurationEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class UploadResourceConfigurationData {
	String? ossType;
	String? accessUrl;
	String? filePath;
	String? accessSecret;
	String? bucket;
	String? securityToken;
	String? uploadHost;
	String? accessKey;
	int? configId;
	String? domain;
	String? region;
	int? expirySeconds;

	UploadResourceConfigurationData();

	factory UploadResourceConfigurationData.fromJson(Map<String, dynamic> json) => $UploadResourceConfigurationDataFromJson(json);

	Map<String, dynamic> toJson() => $UploadResourceConfigurationDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}