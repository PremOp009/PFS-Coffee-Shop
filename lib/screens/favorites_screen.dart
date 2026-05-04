import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import '../core/app_theme.dart';
import '../providers/coffee_provider.dart';
import '../providers/favorite_provider.dart';
import '../widgets/coffee_card.dart';
import 'detail_screen.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allCoffees = ref.watch(coffeeListProvider);
    final favoriteIds = ref.watch(favoriteProvider);
    
    final favoriteCoffees = allCoffees.where((c) => favoriteIds.contains(c.id)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: favoriteCoffees.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.network(
                    'https://lottie.host/e2ba28bd-9bfa-49d7-897c-e09da86f1e00/A0tqW50XWv.json', // Empty favorites / heart animation
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 16),
                  const Text('No favorites yet.', style: TextStyle(fontSize: 18, color: AppTheme.textSecondary)),
                  const SizedBox(height: 8),
                  const Text('Like a coffee to see it here!', style: TextStyle(color: AppTheme.textSecondary)),
                ],
              ).animate().fadeIn(),
            )
          : GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: favoriteCoffees.length,
              itemBuilder: (context, index) {
                return CoffeeCard(
                  coffee: favoriteCoffees[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => DetailScreen(coffee: favoriteCoffees[index]),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return FadeTransition(opacity: animation, child: child);
                        },
                      ),
                    );
                  },
                );
              },
            ).animate().fadeIn(),
    );
  }
}
