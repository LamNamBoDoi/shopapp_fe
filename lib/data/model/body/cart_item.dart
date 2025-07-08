class CartItem {
  int id;
  int quantity;

  CartItem({required this.id, required this.quantity});

  Map<String, dynamic> toJson() => {'product_id': id, 'quantity': quantity};

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json['product_id'],
        quantity: json['quantity'],
      );
}
