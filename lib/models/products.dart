// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

List<Products> productsFromJson(String str) =>
    List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Products {
  int? id;
  // int? cid;
  String? itemName;
  String? detail;
  String? price;
  double? rating;
  // String? rating;
  // String? date;
  String? images;
  DateTime? date;

  Products({
    this.id,
    // this.cid,
    this.itemName,
    this.detail,
    this.price,
    this.rating,
    this.date,
    this.images
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        // cid: json["cid"],
        id: json["id"],
        itemName: json["itemName"],
        detail: json["detail"],
        price: json["price"],
        rating: json["rating"]?.toDouble(),
        // date: json["date"],
        images: json["images"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        // "cid": cid,
        "id": id,
        "itemName": itemName,
        "detail": detail,
        "price": price,
        "rating": rating,
        // "date": date,
        "images": images,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
      };
}