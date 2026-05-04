import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteNotifier extends StateNotifier<List<String>> {
  FavoriteNotifier() : super([]); // stores coffee IDs

  void toggleFavorite(String coffeeId) {
    if (state.contains(coffeeId)) {
      state = state.where((id) => id != coffeeId).toList();
    } else {
      state = [...state, coffeeId];
    }
  }

  bool isFavorite(String coffeeId) {
    return state.contains(coffeeId);
  }
}

final favoriteProvider = StateNotifierProvider<FavoriteNotifier, List<String>>((ref) {
  return FavoriteNotifier();
});
