class Product {
  final String id;
  final String name;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name: json['name'] as String,
      category: json['category']['categoryName'] as String,
    );
  }
}
