class Product {
  String name;
  String description;
  double price;
  String imageUrl;
  int quantity;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
    };
  }
}
