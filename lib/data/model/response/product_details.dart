import 'package:shopapp_v1/data/model/body/category_model.dart';
import 'package:shopapp_v1/data/model/body/image_model.dart';
import 'package:shopapp_v1/data/model/body/review.dart';
import 'package:shopapp_v1/data/model/body/wishlist.dart';

class ProductDetails {
  String? createdAt;
  String? updatedAt;
  int? id;
  String? name;
  double? price;
  String? thumbnail;
  String? description;
  List<ImageModel>? productImages;
  CategoryModel? category;
  List<Wishlist>? wishlists;
  List<Review>? reviews;
  double? averageRating;
  int? totalReviews;

  ProductDetails(
      {this.createdAt,
      this.updatedAt,
      this.id,
      this.name,
      this.price,
      this.thumbnail,
      this.description,
      this.productImages,
      this.category,
      this.wishlists,
      this.reviews,
      this.averageRating,
      this.totalReviews});

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        id: json['id'],
        name: json['name'],
        price: json['price']?.toDouble(),
        thumbnail: json['thumbnail'],
        description: json['description'],
        productImages: json['product_images'] != null
            ? List<ImageModel>.from(
                json['product_images'].map((item) => ImageModel.fromJson(item)))
            : null,
        category: json['category'] != null
            ? CategoryModel.fromJson(json['category'])
            : null,
        wishlists: json['wishlists'] != null
            ? List<Wishlist>.from(
                json['wishlists'].map((item) => Wishlist.fromJson(item)))
            : null,
        reviews: json['reviews'] != null
            ? List<Review>.from(
                json['reviews'].map((item) => Review.fromJson(item)))
            : null,
        averageRating: json['average_rating'],
        totalReviews: json['total_reviews']);
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'id': id,
      'name': name,
      'price': price,
      'thumbnail': thumbnail,
      'description': description,
      'productImages': productImages?.map((img) => img.toJson()).toList(),
      'category': category?.toJson(),
      'wishlists': wishlists?.map((wishlist) => wishlist.toJson()).toList(),
      'reviews': reviews?.map((review) => review.toJson()).toList(),
      'average_rating': averageRating,
      'total_reviews': totalReviews,
    };
  }
}
