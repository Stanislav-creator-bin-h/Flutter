class Product {
  final String id;
  final String nameKey;
  final String emoji;
  final double price;
  final DateTime addedDate;

  const Product({
    required this.id,
    required this.nameKey,
    required this.emoji,
    required this.price,
    required this.addedDate,
  });

  static final List<Product> demoProducts = [
    Product(
      id: '1',
      nameKey: 'tshirt',
      emoji: '👕',
      price: 379,
      addedDate: DateTime(2026, 3, 17, 14, 25),
    ),
    Product(
      id: '2',
      nameKey: 'sneakers',
      emoji: '👟',
      price: 1849,
      addedDate: DateTime(2026, 5, 8, 9, 42),
    ),
    Product(
      id: '3',
      nameKey: 'backpack',
      emoji: '🎒',
      price: 967,
      addedDate: DateTime(2026, 1, 23, 18, 11),
    ),
    Product(
      id: '4',
      nameKey: 'book',
      emoji: '📚',
      price: 245,
      addedDate: DateTime(2026, 4, 2, 11, 37),
    ),
    Product(
      id: '5',
      nameKey: 'headphones',
      emoji: '🎧',
      price: 2150,
      addedDate: DateTime(2026, 2, 28, 20, 54),
    ),
  ];
}
