import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final total = ref.watch(cartTotalProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Кошик'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () => ref.read(cartProvider.notifier).clear(),
          ),
        ],
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('Кошик порожній'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return ListTile(
                        leading: Text(item.image, style: const TextStyle(fontSize: 24)),
                        title: Text(item.name),
                        subtitle: Text('\$${item.price}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            ref.read(cartProvider.notifier).removeProduct(item.id);
                          },
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.blueGrey,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Всього: \$${total.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 20, color: Colors.white)),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Оплатити'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}