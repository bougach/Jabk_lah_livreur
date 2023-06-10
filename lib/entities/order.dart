class Order {
  int id;
  double totalPrice;
  String? status; // Make the 'status' field nullable
  String orderTrackingNumber;
  String dateCreated;
  String lastUpdated;

  Order({
    required this.id,
    required this.totalPrice,
    this.status,
    required this.orderTrackingNumber,
    required this.dateCreated,
    required this.lastUpdated,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as int,
      totalPrice: json['totalPrice'] as double,
      status: json['status'] as String?, // Handle nullable status field
      orderTrackingNumber: json['orderTrackingNumber'] as String,
      dateCreated: json['dateCreated'] as String,
      lastUpdated: json['lastUpdated'] as String,
    );
  }
}
