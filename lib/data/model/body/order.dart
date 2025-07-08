import 'package:shopapp_v1/data/model/body/cart_item.dart';

class Order {
  int? userId;
  String? fullname;
  String? email;
  String? phoneNumber;
  String? address;
  String? note;
  double? totalMoney;
  String? shippingMethod;
  String? paymentMethod;
  bool? active;
  List<CartItem>? listCartItem;

  Order({
    this.userId,
    this.fullname,
    this.email,
    this.phoneNumber,
    this.address,
    this.note,
    this.totalMoney,
    this.shippingMethod,
    this.paymentMethod,
    this.active,
    this.listCartItem,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      userId: json['user_id'],
      fullname: json['fullname'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      address: json['address'],
      note: json['note'],
      totalMoney: json['total_money'] != null
          ? double.tryParse(json['total_money'].toString())
          : null,
      shippingMethod: json['shipping_method'],
      paymentMethod: json['payment_method'],
      active: json['active'],
      listCartItem: json['cart_items'] != null
          ? (json['cart_items'] as List)
              .map((item) => CartItem.fromJson(item))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'fullname': fullname,
      'email': email,
      'phone_number': phoneNumber,
      'address': address,
      'note': note,
      'total_money': totalMoney,
      'shipping_method': shippingMethod,
      'payment_method': paymentMethod,
      'active': active,
      'cart_items': listCartItem?.map((item) => item.toJson()).toList(),
    };
  }
}
