class Review {
  int? id;
  int? productId;
  int? userId;
  String? userName;
  int? rating;
  String? comment;
  String? status;
  DateTime? createdAt;

  Review({
    this.id,
    this.productId,
    this.userId,
    this.userName,
    this.rating,
    this.comment,
    this.status,
    this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      productId: json['product_id'],
      userId: json['user_id'],
      userName: json['user_name'],
      rating: json['rating'],
      comment: json['comment'],
      status: json['status'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'user_id': userId,
      'user_name': userName,
      'rating': rating,
      'comment': comment,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
