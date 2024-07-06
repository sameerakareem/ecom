import 'dart:convert';

class ProductModel {
  int id;
  String title;
  double price;
  String description;
  List<String> images;
  bool? isFavorite;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    this.isFavorite,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      images: List<String>.from(json['images']),
      isFavorite: json['isFavorite'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'images': images,
      'isFavorite': isFavorite,
    };
  }

  String? getFirstImage() {
    return images.isNotEmpty ? images.first : null;
  }
}
