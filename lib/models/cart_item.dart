import 'coffee_model.dart';

class CartItem {
  final String id;
  final CoffeeModel coffee;
  final int quantity;
  final String size;
  final int sugarLevel;
  final int milkLevel;

  CartItem({
    required this.id,
    required this.coffee,
    this.quantity = 1,
    required this.size,
    required this.sugarLevel,
    required this.milkLevel,
  });

  CartItem copyWith({
    int? quantity,
    String? size,
    int? sugarLevel,
    int? milkLevel,
  }) {
    return CartItem(
      id: id,
      coffee: coffee,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      sugarLevel: sugarLevel ?? this.sugarLevel,
      milkLevel: milkLevel ?? this.milkLevel,
    );
  }
}
