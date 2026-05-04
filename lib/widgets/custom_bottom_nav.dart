import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../core/app_theme.dart';
import '../providers/nav_provider.dart';
import 'glassmorphism.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomBottomNav extends ConsumerWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavProvider);

    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
      child: Glassmorphism(
        borderRadius: BorderRadius.circular(30),
        blur: 20,
        opacity: 0.1,
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(context, ref, LucideIcons.home, 0, currentIndex),
              _buildNavItem(context, ref, LucideIcons.heart, 1, currentIndex),
              _buildNavItem(context, ref, LucideIcons.shoppingBag, 2, currentIndex),
              _buildNavItem(context, ref, LucideIcons.user, 3, currentIndex),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, WidgetRef ref, IconData icon, int index, int currentIndex) {
    final isSelected = index == currentIndex;

    return GestureDetector(
      onTap: () {
        ref.read(bottomNavProvider.notifier).state = index;
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryCoffee : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : AppTheme.textSecondary,
          size: 24,
        ),
      ).animate(target: isSelected ? 1 : 0)
        .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1), duration: 200.ms),
    );
  }
}
