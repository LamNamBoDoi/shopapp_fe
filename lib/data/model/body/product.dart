import 'package:shopapp_v1/data/model/body/review.dart';
import 'package:shopapp_v1/data/model/body/wishlist.dart';

class Product {
  int? id;
  String? name;
  double? price;
  String? thumbnail;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? categoryId;
  List<Wishlist>? listWishlist;
  List<Review>? reviews;
  double? averageRating;
  int? totalReviews;

  Product(
      {this.id,
      this.name,
      this.price,
      this.thumbnail,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.categoryId,
      this.listWishlist,
      this.reviews,
      this.averageRating,
      this.totalReviews});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        name: json['name'],
        price: json['price']?.toDouble(),
        thumbnail: json['thumbnail'],
        description: json['description'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        categoryId: json['category_id'],
        listWishlist: json['wishlists'] != null
            ? List<Wishlist>.from(json['wishlists']
                .map((wishlist) => Wishlist.fromJson(wishlist)))
            : null,
        reviews: json['reviews'] != null
            ? List<Review>.from(
                json['reviews'].map((item) => Review.fromJson(json)))
            : null,
        averageRating: json['average_rating'],
        totalReviews: json['total_reviews']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'thumbnail': thumbnail,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'category_id': categoryId,
      'wishlists': listWishlist?.map((wishlist) => wishlist.toJson()).toList(),
      'reviews': reviews?.map((review) => review.toJson()).toList(),
      'average_rating': averageRating,
      'total_reviews': totalReviews,
    };
  }
}
