import 'package:flutter_d0601/generated/json/base/json_field.dart';
import 'package:flutter_d0601/generated/json/base_entity.g.dart';
import 'dart:convert';
export 'package:flutter_d0601/generated/json/base_entity.g.dart';

@JsonSerializable()
class BaseEntity {
	int? code;
	dynamic data;
	bool? success;
	dynamic requestId;
	String? message;

	BaseEntity();

	factory BaseEntity.fromJson(Map<String, dynamic> json) => $BaseEntityFromJson(json);

	Map<String, dynamic> toJson() => $BaseEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}