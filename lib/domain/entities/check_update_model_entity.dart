// To parse this JSON data, do
//
//     final CheckUpdateModelEntity = CheckUpdateModelEntityFromJson(jsonString);

import 'dart:convert';

CheckUpdateModelEntity checkUpdateModelFromJson(String str) =>
    CheckUpdateModelEntity.fromJson(json.decode(str));

String checkUpdateModelToJson(CheckUpdateModelEntity data) =>
    json.encode(data.toJson());

class CheckUpdateModelEntity {
  CheckUpdateModelEntity({
    required this.version,
    required this.buildNumber,
    required this.isOptional,
  });

  String version;
  String buildNumber;
  String isOptional;

  factory CheckUpdateModelEntity.fromJson(Map<String, dynamic> json) =>
      CheckUpdateModelEntity(
        version: json["version"],
        buildNumber: json["build_number"],
        isOptional: json["is_optional"],
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "build_number": buildNumber,
        "is_optional": isOptional,
      };
}
