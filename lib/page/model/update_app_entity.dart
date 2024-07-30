import 'package:flutter_d0601/generated/json/base/json_field.dart';
import 'package:flutter_d0601/generated/json/update_app_entity.g.dart';
import 'dart:convert';
export 'package:flutter_d0601/generated/json/update_app_entity.g.dart';

@JsonSerializable()
class UpdateAppEntity {
	int? code;
	List<UpdateAppData>? data;
	bool? success;
	dynamic requestId;
	int? count;
	String? message;

	UpdateAppEntity();

	factory UpdateAppEntity.fromJson(Map<String, dynamic> json) => $UpdateAppEntityFromJson(json);

	Map<String, dynamic> toJson() => $UpdateAppEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class UpdateAppData {
	dynamic owner;
	int? productId;
	String? gmtModify;
	int? sort;
	int? cityId;
	String? gmtCreate;
	int? parentId;
	int? biz;
	bool? enable;
	String? appId;
	String? name;
	String? startTime;
	int? id;
	String? endTime;
	String? value;
	String? key;
	int? classType;

	UpdateAppData();

	factory UpdateAppData.fromJson(Map<String, dynamic> json) => $UpdateAppDataFromJson(json);

	Map<String, dynamic> toJson() => $UpdateAppDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}