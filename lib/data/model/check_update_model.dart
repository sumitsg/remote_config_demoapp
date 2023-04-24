// To parse this JSON data, do
//
//     final checkUpdateModel = checkUpdateModelFromJson(jsonString);

import 'dart:convert';

import 'package:remote_congigue_demoapp/domain/entities/check_update_model_entity.dart';

CheckUpdateModel checkUpdateModelFromJson(String str) =>
    CheckUpdateModel.fromJson(json.decode(str));

String checkUpdateModelToJson(CheckUpdateModel data) =>
    json.encode(data.toJson());

class CheckUpdateModel {
  CheckUpdateModel({
    required this.version,
    required this.buildNumber,
    required this.isOptional,
  });

  String version;
  String buildNumber;
  String isOptional;

  factory CheckUpdateModel.fromJson(Map<String, dynamic> json) =>
      CheckUpdateModel(
        version: json["version"],
        buildNumber: json["build_number"],
        isOptional: json["is_optional"],
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "build_number": buildNumber,
        "is_optional": isOptional,
      };

  CheckUpdateModelEntity transform() {
    return CheckUpdateModelEntity(
      version: version,
      buildNumber: buildNumber,
      isOptional: isOptional,
    );
  }
}
