class Wishlist {
  int? id;
  int? userId;
  int? productId;

  Wishlist({
    this.id,
    this.userId,
    this.productId,
  });

  factory Wishlist.fromJson(Map<String, dynamic> json) {
    return Wishlist(
      id: json['id'],
      userId: json['user_id'],
      productId: json['product_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'product_id': productId,
    };
  }
}
