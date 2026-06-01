import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';

final productsProvider = Provider<List<Product>>((ref) {
  return [
    Product(
      id: '1',
      name: 'iPhone 24',
      category: 'Electronics',
      price: 99900.99,
      image: '📱',
    ),
    Product(
      id: '2',
      name: 'MacBook Pro Mega Ultra',
      category: 'Electronics',
      price: 1999.99,
      image: '💻',
    ),
    Product(
      id: '3',
      name: 'Apple Watch',
      category: 'Accessories',
      price: 399.99,
      image: '⌚',
    ),
    Product(
      id: '4',
      name: 'Coffee Maker',
      category: 'Home',
      price: 2,
      image: '☕',
    ),
    Product(
      id: '5',
      name: 'Headphones',
      category: 'Accessories',
      price: 199.99,
      image: '🎧',
    ),
  ];
});
