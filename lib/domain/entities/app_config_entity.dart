import 'dart:convert';

class AppConfig {
  final String appName;
  final String appVersion;

  AppConfig({required this.appName, required this.appVersion});
}

List<ProductDataEntity> ProductDataEntityFromJson(String str) =>
    List<ProductDataEntity>.from(
        json.decode(str).map((x) => ProductDataEntity.fromJson(x)));

String ProductDataEntityToJson(List<ProductDataEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductDataEntity {
  ProductDataEntity({
    required this.productBrand,
    required this.productName,
    required this.gender,
    required this.color,
    required this.price,
    required this.ogPrice,
    required this.discount,
    required this.imgUrl,
    required this.reviewCount,
  });

  String productBrand;
  String productName;
  String gender;
  String color;
  String price;
  int ogPrice;
  double discount;
  String imgUrl;
  String reviewCount;

  factory ProductDataEntity.fromJson(Map<String, dynamic> json) =>
      ProductDataEntity(
        productBrand: json["productBrand"],
        productName: json["productName"],
        gender: json["gender"],
        color: json["color"],
        price: json["price"],
        ogPrice: json["ogPrice"],
        discount: json["discount"],
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
}
