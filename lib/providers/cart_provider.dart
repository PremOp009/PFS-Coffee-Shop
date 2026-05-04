import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart_item.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(CartItem item) {
    // Check if exactly same item exists (same id, size, sugar, milk)
    final index = state.indexWhere((element) => 
      element.coffee.id == item.coffee.id &&
      element.size == item.size &&
      element.sugarLevel == item.sugarLevel &&
      element.milkLevel == item.milkLevel
    );

    if (index >= 0) {
      final updatedList = [...state];
      updatedList[index] = updatedList[index].copyWith(
        quantity: updatedList[index].quantity + item.quantity
      );
      state = updatedList;
    } else {
      state = [...state, item];
    }
  }

  void removeFromCart(String cartItemId) {
    state = state.where((item) => item.id != cartItemId).toList();
  }

  void updateQuantity(String cartItemId, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(cartItemId);
      return;
    }
    
    final index = state.indexWhere((element) => element.id == cartItemId);
    if (index >= 0) {
      final updatedList = [...state];
      updatedList[index] = updatedList[index].copyWith(quantity: newQuantity);
      state = updatedList;
    }
  }

  void clearCart() {
    state = [];
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

final cartTotalProvider = Provider<double>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold(0.0, (total, item) => total + (item.coffee.price * item.quantity));
});
