import 'package:flutter_d0601/generated/json/base/json_field.dart';
import 'package:flutter_d0601/generated/json/audit_switch_entity.g.dart';
import 'dart:convert';
export 'package:flutter_d0601/generated/json/audit_switch_entity.g.dart';

@JsonSerializable()
class AuditSwitchEntity {
	int? code = 0;
	AuditSwitchData? data;
	bool? success = false;
	dynamic requestId;
	String? message = '';

	AuditSwitchEntity();

	factory AuditSwitchEntity.fromJson(Map<String, dynamic> json) => $AuditSwitchEntityFromJson(json);

	Map<String, dynamic> toJson() => $AuditSwitchEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AuditSwitchData {
	int? appVersion = 0;
	int? paySwitch = 0;
	int? docSwitch = 0;

	AuditSwitchData();

	factory AuditSwitchData.fromJson(Map<String, dynamic> json) => $AuditSwitchDataFromJson(json);

	Map<String, dynamic> toJson() => $AuditSwitchDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}