import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/coffee_model.dart';
import '../core/constants.dart';

// Provider for all coffees
final coffeeListProvider = Provider<List<CoffeeModel>>((ref) {
  return AppConstants.mockCoffees;
});

// Provider for selected category
final categoryProvider = StateProvider<String>((ref) => 'All');

// Provider for filtered coffees based on category
final filteredCoffeeProvider = Provider<List<CoffeeModel>>((ref) {
  final coffees = ref.watch(coffeeListProvider);
  final category = ref.watch(categoryProvider);

  if (category == 'All') {
    return coffees;
  }
  return coffees.where((coffee) => coffee.category == category).toList();
});

// AI Recommended Coffee (Mock)
final recommendedCoffeeProvider = Provider<CoffeeModel>((ref) {
  final coffees = ref.watch(coffeeListProvider);
  // Just return the first one as a mock recommendation
  return coffees.first;
});
