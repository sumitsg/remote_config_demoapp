import 'dart:convert';

import 'package:remote_congigue_demoapp/domain/entities/app_config_entity.dart';

List<ProductDataModel> productDataModelFromJson(String str) =>
    List<ProductDataModel>.from(
        json.decode(str).map((x) => ProductDataModel.fromJson(x)));

String productDataModelToJson(List<ProductDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductDataModel {
  ProductDataModel(
      {required this.productBrand,
      required this.productName,
      required this.gender,
      required this.color,
      required this.price,
      required this.ogPrice,
      required this.discount,
      required this.imgUrl,
      required this.reviewCount});

  String productBrand;
  String productName;
  String gender;
  String color;
  String price;
  int ogPrice;
  double discount;
  String imgUrl;
  String reviewCount;

  factory ProductDataModel.fromJson(Map<String, dynamic> json) =>
      ProductDataModel(
        productBrand: json["productBrand"],
        productName: json["productName"],
        gender: json["gender"],
        color: json["color"],
        price: json["price"],
        ogPrice: json["ogPrice"],
        discount: double.parse((json["discount"]?.toString()) ?? "0.0"),
        imgUrl: json["imgUrl"],
        reviewCount: json["reviewCount"],
      );

  Map<String, dynamic> toJson() => {
        "productBrand": productBrand,
        "productName": productName,
        "gender": gender,
        "color": color,
        "price": price,
        "ogPrice": ogPrice,
        "discount": discount,
        "imgUrl": imgUrl,
        "reviewCount": reviewCount
      };

  ProductDataEntity transform() {
    return ProductDataEntity(
        productBrand: productBrand,
        productName: productName,
        gender: gender,
        color: color,
        price: price,
        ogPrice: ogPrice,
        discount: discount,
        imgUrl: imgUrl,
        reviewCount: reviewCount);
  }
}
