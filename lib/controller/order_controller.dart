import 'package:get/get.dart';
import 'package:shopapp_v1/data/model/body/order.dart';
import 'package:shopapp_v1/data/model/body/order_detail.dart';
import 'package:shopapp_v1/data/model/response/order_res.dart';
import 'package:shopapp_v1/data/repository/order_repo.dart';

class OrderController extends GetxController implements GetxService {
  final OrderRepo repo;
  OrderController({required this.repo});

  bool _isLoading = false;
  List<OrderResponse> _listOrders = [];

  List<OrderResponse> get listOrders => _listOrders;
  bool get isLoading => _isLoading;

  Future<int?> createOrder(Order order) async {
    _isLoading = true;
    update();
    try {
      Response response = await repo.createOrder(order: order);
      if (response.statusCode == 200) {
        var responseData = response.body;
        if (responseData is Map<String, dynamic>) {
        } else {
          throw Exception("Unexpected response format");
        }
      } else {
        print("Tạo đơn hàng thất bại: ${response.statusCode}");
      }
      return response.statusCode;
    } catch (e) {
      print("Lỗi khi tạo đơn hàng: $e");
      return null;
    } finally {
      _isLoading = false;
      update();
    }
  }

  Future<void> getListOrderByUserId(int userId) async {
    _isLoading = true;
    update();
    try {
      Response response = await repo.getListOrderByUserId(userId: userId);
      if (response.statusCode == 200) {
        var responseData = response.body;
        if (responseData is List) {
          _listOrders =
              responseData.map((e) => OrderResponse.fromJson(e)).toList();
        } else {
          throw Exception("Expected a list of orders");
        }
      } else {
        print("Lỗi khi lấy danh sách đơn hàng: ${response.statusCode}");
      }
    } catch (e) {
      print("Lỗi khi lấy đơn hàng: $e");
    } finally {
      _isLoading = false;
      update();
    }
  }

  Future<List<OrderDetail>?> getOrderById(int id) async {
    _isLoading = true;
    update();
    try {
      Response response = await repo.getListOrderById(orderId: id);
      if (response.statusCode == 200) {
        var responseData = response.body;
        if (responseData is List) {
          return responseData.map((e) => OrderDetail.fromJson(e)).toList();
        } else {
          throw Exception("Unexpected response format");
        }
      } else {
        print("Lỗi khi lấy đơn hàng theo ID: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Lỗi khi lấy đơn hàng theo ID: $e");
      return null;
    } finally {
      _isLoading = false;
      update();
    }
  }
}
