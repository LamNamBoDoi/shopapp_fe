import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp_v1/controller/order_controller.dart';
import 'package:shopapp_v1/data/model/response/order_res.dart';
import 'package:shopapp_v1/screen/order/order_detail_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Danh sách đơn hàng',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: GetBuilder<OrderController>(
        builder: (ctl) {
          if (ctl.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (ctl.listOrders.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_bag_outlined,
                      size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 20),
                  Text(
                    "Chưa có đơn hàng nào",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Hãy mua sắm và quay lại sau!",
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => await ctl.getListOrderByUserId(4),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: ctl.listOrders.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final OrderResponse order = ctl.listOrders[index];
                return _buildOrderCard(order, index + 1);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildOrderCard(OrderResponse order, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // Xử lý khi nhấn vào đơn hàng
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Mã đơn và trạng thái
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Đơn hàng #$index",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    _buildStatusChip(order.status),
                  ],
                ),
                const SizedBox(height: 12),

                // Thông tin khách hàng
                Row(
                  children: [
                    Icon(Icons.person_outline,
                        size: 18, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Text(
                      order.fullName ?? "Không có tên",
                      style: TextStyle(color: Colors.grey[800]),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Ngày đặt hàng
                Row(
                  children: [
                    Icon(Icons.calendar_today,
                        size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Text(
                      order.orderDate != null
                          ? "Ngày: ${_formatDate(order.orderDate!)}"
                          : "Không có ngày",
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Footer: Tổng tiền và chi tiết
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: "Tổng cộng: ",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: "${order.totalMoney?.toStringAsFixed(0)} đ",
                            style: const TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (order.id != null) {
                          Get.find<OrderController>()
                              .getOrderById(order.id ?? 1)
                              .then((value) {
                            if (value != null) {
                              Get.to(() => OrderDetailScreen(
                                    listOrderDetail: value,
                                  ));
                            }
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.deepOrange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text("Chi tiết",
                                style: TextStyle(
                                    color: Colors.deepOrange, fontSize: 13)),
                            SizedBox(width: 4),
                            Icon(Icons.chevron_right,
                                size: 16, color: Colors.deepOrange),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Hàm tạo Chip hiển thị trạng thái
  Widget _buildStatusChip(String? status) {
    final Map<String, Map<String, dynamic>> statusConfig = {
      'Pending': {
        'color': Colors.orange,
        'icon': Icons.hourglass_empty,
        'text': 'Chờ xử lý',
      },
      'Processing': {
        'color': Colors.blue,
        'icon': Icons.autorenew,
        'text': 'Đang xử lý',
      },
      'Shipped': {
        'color': Colors.green,
        'icon': Icons.local_shipping,
        'text': 'Đang giao',
      },
      'Delivered': {
        'color': Colors.purple,
        'icon': Icons.check_circle,
        'text': 'Đã giao',
      },
      'Cancelled': {
        'color': Colors.red,
        'icon': Icons.cancel,
        'text': 'Đã hủy',
      },
    };

    final config = statusConfig[status] ??
        {
          'color': Colors.grey,
          'icon': Icons.help,
          'text': 'Không xác định',
        };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: config['color']!.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(config['icon'] as IconData,
              size: 14, color: config['color'] as Color),
          const SizedBox(width: 4),
          Text(
            config['text'] as String,
            style: TextStyle(
              color: config['color'] as Color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
