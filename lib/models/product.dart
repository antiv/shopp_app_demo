import 'dart:convert';

class Product {
  Product({
    required this.id,
    this.name,
    this.price,
    this.barcode,
    this.image,
    this.vatGroup,
  });

  final int id;
  final String? name;
  final double? price;
  final String? barcode;
  final String? image;
  final int? vatGroup;

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    price: json["price"]?.toDouble(),
    barcode: json["barcode"],
    image: json["image"],
    vatGroup: json["vat_group"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "barcode": barcode,
    "image": image,
    "vat_group": vatGroup,
  };
}