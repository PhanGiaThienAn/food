import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onAddToCart;

  const ProductItem({super.key, 
    required this.product,
    required this.onEdit,
    required this.onDelete,
    required this.onIncrease,
    required this.onDecrease,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              product.imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    '\$${product.price}',
                    style: const TextStyle(fontSize: 18, color: Colors.purple),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: onDecrease,
                      ),
                      Text(product.quantity.toString()),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: onIncrease,
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.shopping_cart),
                        onPressed: onAddToCart,
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: onEdit,
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: onDelete,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
