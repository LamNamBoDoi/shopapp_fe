class OrderDetail {
  int? orderId;
  int? productId;
  double? price;
  int? numberOfProducts;
  double? totalMoney;
  String? color;

  OrderDetail({
    required this.orderId,
    required this.productId,
    required this.price,
    required this.numberOfProducts,
    required this.totalMoney,
    this.color,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      orderId: json['order_id'] ?? 0,
      productId: json['product_id'] ?? 0,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      numberOfProducts: json['number_of_products'] ?? 1,
      totalMoney: (json['total_money'] as num?)?.toDouble() ?? 0.0,
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'product_id': productId,
      'price': price,
      'number_of_products': numberOfProducts,
      'total_money': totalMoney,
      'color': color,
    };
  }
}
