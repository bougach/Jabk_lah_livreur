import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:jabklah_livreur/services/AuthInterceptor.dart';
import 'package:jabklah_livreur/entities/order.dart';

class DeliveryService {
  Dio dio = Dio();

  static const String baseUrl = 'https://jabak-lah-app.herokuapp.com/api/delivery';

  Future<List<Order>> getOrdersForDG() async {
    dio.interceptors.add(AuthInterceptor());

    final url = '$baseUrl/getOrders';
    final response = await dio.get(url);

    print(response.data); // Print the response data for debugging

    if (response.statusCode == 200) {
      final data = response.data as Map<String, dynamic>;
      final ordersData = data['data']['orders'] as List<dynamic>;

      if (ordersData != null) {
        List<Order> orders = [];

        for (var orderData in ordersData) {
          Order order = Order.fromJson(orderData);
          orders.add(order);
        }

        return orders;
      } else {
        throw Exception('Failed to retrieve orders for delivery man');
      }
    } else {
      throw Exception('Failed to retrieve orders for delivery man');
    }
  }

  Future<String> updateOrderStatus(int id, String status) async {
    dio.interceptors.add(AuthInterceptor());

    final url = '$baseUrl/update/$id';
    final response = await dio.put(url, data: status);

    if (response.statusCode == 200) {
      final data = response.data as Map<String, dynamic>;
      final message = data['message'] as String;
      return message;
    } else {
      throw Exception('Failed to update order status');
    }
  }

  Future<List<dynamic>> getProductsByOrder(int id) async {
    dio.interceptors.add(AuthInterceptor());

    final url = '$baseUrl/getProducts/$id';
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final data = response.data as Map<String, dynamic>;
      final products = data['data']['products'] as List<dynamic>;
      return products;
    } else {
      throw Exception('Failed to retrieve products for order');
    }
  }

}
