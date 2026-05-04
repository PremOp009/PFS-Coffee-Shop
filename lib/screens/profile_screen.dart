import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../core/app_theme.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(LucideIcons.settings), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            // Profile Header
            Center(
              child: const Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'),
                  ),
                  SizedBox(height: 16),
                  Text('Alex Johnson', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('Coffee Enthusiast', style: TextStyle(color: AppTheme.textSecondary)),
                ],
              ).animate().fadeIn().slideY(begin: 0.2),
            ),
            
            const SizedBox(height: 32),
            
            // Stats Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem('Orders', 42),
                Container(height: 40, width: 1, color: AppTheme.textSecondary.withValues(alpha: 0.3)),
                _buildStatItem('Points', 1250),
                Container(height: 40, width: 1, color: AppTheme.textSecondary.withValues(alpha: 0.3)),
                _buildStatItem('Level', 5),
              ],
            ).animate().fadeIn(delay: 200.ms),
            
            const SizedBox(height: 32),
            
            // Options List
            _buildOptionItem(LucideIcons.user, 'Personal Info'),
            _buildOptionItem(LucideIcons.history, 'Order History'),
            _buildOptionItem(LucideIcons.creditCard, 'Payment Methods'),
            _buildOptionItem(LucideIcons.mapPin, 'Delivery Addresses'),
            _buildOptionItem(LucideIcons.bell, 'Notifications'),
            _buildOptionItem(LucideIcons.helpCircle, 'Help & Support'),
            _buildOptionItem(LucideIcons.logOut, 'Logout', isDestructive: true),
            
            const SizedBox(height: 100), // Space for bottom nav
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, int value) {
    return Column(
      children: [
        TweenAnimationBuilder<int>(
          tween: IntTween(begin: 0, end: value),
          duration: const Duration(seconds: 2),
          builder: (context, val, child) {
            return Text(
              val.toString(),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.primaryCoffee),
            );
          },
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: AppTheme.textSecondary)),
      ],
    );
  }

  Widget _buildOptionItem(IconData icon, String title, {bool isDestructive = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: isDestructive ? Colors.red : Colors.white),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDestructive ? Colors.red : Colors.white,
              ),
            ),
          ),
          const Icon(LucideIcons.chevronRight, color: AppTheme.textSecondary, size: 20),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms).slideX(begin: 0.1);
  }
}
