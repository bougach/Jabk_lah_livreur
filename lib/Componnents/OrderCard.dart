import 'package:jabklah_livreur/entities/order.dart';
import 'package:flutter/material.dart';
import 'package:jabklah_livreur/services/Commandeapi.dart';

import '../OrderDetailPage.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final Function(String) onStatusChange;
  String selectedValue = 'ORDER_ON_PROCESS';

  OrderCard({required this.order, required this.onStatusChange});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailPage(order: order),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage("assets/imgs/order.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order ${order.id}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              DropdownButton<String>(
                value: selectedValue,
                onChanged: (newValue) {
                  selectedValue = newValue!; // Update the selected value

                  // Call the provided onStatusChange callback to update the status
                  onStatusChange(newValue);

                  // Call the updateOrderStatus method from DeliveryService
                  DeliveryService().updateOrderStatus(order.id , newValue)
                      .then((message) {
                    // Handle the response if needed
                    print('Order status updated: $message');
                  }).catchError((error) {
                    // Handle any error that occurs during the API call
                    print('Failed to update order status: $error');
                  });
                },
                items: [
                  DropdownMenuItem<String>(
                    value: 'ORDER_ON_PROCESS',
                    child: Text('ORDER_ON_PROCESS'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'ORDER_ON_DELIVERY',
                    child: Text('ORDER_ON_DELIVERY'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'PACKAGE_DELIVERED',
                    child: Text('PACKAGE_DELIVERED'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
