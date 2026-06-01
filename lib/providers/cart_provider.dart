import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';

// 1. Спочатку визначаємо сам провайдер кошика
final cartProvider = StateNotifierProvider<CartNotifier, List<Product>>((ref) {
  return CartNotifier();
});

final cartTotalProvider = Provider<double>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold(0.0, (sum, product) => sum + product.price);
});

class CartNotifier extends StateNotifier<List<Product>> {
  CartNotifier() : super([]);

  void addProduct(Product product) {
    state = [...state, product];
  }

  void removeProduct(String productId) {
    final index = state.indexWhere((p) => p.id == productId);
    if (index == -1) return;
    final newState = [...state];
    newState.removeAt(index);
    state = newState;
  }

  void clear() {
    state = [];
  }
}
