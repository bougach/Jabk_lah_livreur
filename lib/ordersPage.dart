import 'package:flutter/material.dart';
import 'package:jabklah_livreur/Componnents/OrderCard.dart';
import 'package:jabklah_livreur/background/Background.dart';
import 'package:jabklah_livreur/entities/order.dart';
import 'package:jabklah_livreur/services/Commandeapi.dart';

class DeliveryScreen extends StatefulWidget {
  @override
  _DeliveryScreenState createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  DeliveryService deliveryService = DeliveryService();
  List<Order> orders = [];

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      List<Order> fetchedOrders = await deliveryService.getOrdersForDG();
      setState(() {
        orders = fetchedOrders;
      });
      print(orders);
    } catch (e) {
      // Handle error
      print('Failed to fetch orders: $e');
    }
  }

  Future<void> changeOrderStatus(String newStatus, int index) async {
    try {
      String message = await deliveryService.updateOrderStatus( orders[index].id , newStatus);
      setState(() {
        orders[index].status = newStatus;
      });
      print('Order status updated: $message');
    } catch (e) {
      // Handle error
      print('Failed to update order status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF1E6FF), Color(0xFF6F35A5)], // Set the desired gradient colors
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text('Delivery App'),
      ),
      body: Background(
        child: ListView.builder(
          padding: EdgeInsets.only(top: 30),
          itemCount: orders.length,
          itemBuilder: (BuildContext context, int index) {
            return OrderCard(
              order: orders[index],
              onStatusChange: (newStatus) => changeOrderStatus(newStatus, index),
            );
          },
        ),
      ),
    );
  }
}
