import 'package:flutter/material.dart';
import 'package:jabklah_livreur/entities/order.dart';
import 'package:jabklah_livreur/services/Commandeapi.dart';

class OrderDetailPage extends StatefulWidget {
  final Order order;

  OrderDetailPage({required this.order});

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  List<dynamic> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final deliveryService = DeliveryService();
      final fetchedProducts = await deliveryService.getProductsByOrder(widget.order.id);
      setState(() {
        products = fetchedProducts;
      });
      print(products);
    } catch (e) {
      // Handle error
      print('Failed to fetch products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF1E6FF), Color(0xFF6F35A5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text('Order Detail'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage("assets/imgs/product.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 36),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order ${widget.order.id}:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Status: ${widget.order.status}',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 36),
            Text(
              'Products:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  final product = products[index];
                  return Card(
                    elevation: 2,
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      leading: Image.asset(
                        "assets/imgs/product.jpg",
                        width: 48,
                        height: 48,
                      ),
                      title: Text(product['name']),
                      trailing: Text('ID: ${product['id']}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
