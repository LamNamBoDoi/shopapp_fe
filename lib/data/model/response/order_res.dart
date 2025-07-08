import 'package:shopapp_v1/data/model/body/order_detail.dart';

class OrderResponse {
  int? id;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? address;
  String? note;
  DateTime? orderDate;
  String? status;
  double? totalMoney;
  String? shippingMethod;
  String? shippingAddress;
  DateTime? shippingDate;
  String? trackingNumber;
  String? paymentMethod;
  bool? active;
  int? userId;
  List<OrderDetail>? orderDetails;

  OrderResponse({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.note,
    required this.orderDate,
    required this.status,
    required this.totalMoney,
    required this.shippingMethod,
    required this.shippingAddress,
    required this.shippingDate,
    required this.trackingNumber,
    required this.paymentMethod,
    required this.active,
    required this.userId,
    required this.orderDetails,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      note: json['note'],
      orderDate: DateTime.parse(json['orderDate']),
      status: json['status'],
      totalMoney: (json['totalMoney'] as num).toDouble(),
      shippingMethod: json['shippingMethod'],
      shippingAddress: json['shippingAddress'],
      shippingDate: DateTime.parse(json['shippingDate']),
      trackingNumber: json['trackingNumber'],
      paymentMethod: json['paymentMethod'],
      active: json['active'],
      userId: json['user_id'],
      orderDetails: (json['order_details'] as List)
          .map((e) => OrderDetail.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'note': note,
      'orderDate': orderDate?.toIso8601String(),
      'status': status,
      'totalMoney': totalMoney,
      'shippingMethod': shippingMethod,
      'shippingAddress': shippingAddress,
      'shippingDate': shippingDate?.toIso8601String(),
      'trackingNumber': trackingNumber,
      'paymentMethod': paymentMethod,
      'active': active,
      'user_id': userId,
      'order_details': orderDetails?.map((e) => e.toJson()).toList(),
    };
  }
}
