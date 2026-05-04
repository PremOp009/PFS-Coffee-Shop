import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../core/app_theme.dart';
import '../models/coffee_model.dart';
import '../models/cart_item.dart';
import '../providers/cart_provider.dart';
import '../providers/favorite_provider.dart';
import '../widgets/glassmorphism.dart';
import 'package:lottie/lottie.dart';

class DetailScreen extends ConsumerStatefulWidget {
  final CoffeeModel coffee;

  const DetailScreen({super.key, required this.coffee});

  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> with SingleTickerProviderStateMixin {
  String selectedSize = 'M';
  int sugarLevel = 50;
  int milkLevel = 50;
  bool isAddingToCart = false;

  late AnimationController _cartAnimController;

  @override
  void initState() {
    super.initState();
    _cartAnimController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
  }

  @override
  void dispose() {
    _cartAnimController.dispose();
    super.dispose();
  }

  void _handleAddToCart() async {
    if (isAddingToCart) return;

    setState(() => isAddingToCart = true);

    // Add to cart state
    final item = CartItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      coffee: widget.coffee,
      size: selectedSize,
      sugarLevel: sugarLevel,
      milkLevel: milkLevel,
    );
    
    ref.read(cartProvider.notifier).addToCart(item);

    // Play animation
    _cartAnimController.forward();
    
    await Future.delayed(const Duration(milliseconds: 1500));
    
    if (mounted) {
      setState(() => isAddingToCart = false);
      _cartAnimController.reset();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Added to cart successfully!'),
          backgroundColor: AppTheme.primaryCoffee,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFav = ref.watch(favoriteProvider).contains(widget.coffee.id);

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: 400,
                pinned: true,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: Glassmorphism(
                    borderRadius: BorderRadius.circular(12),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(LucideIcons.arrowLeft, color: Colors.white),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [
                  IconButton(
                    icon: Glassmorphism(
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          isFav ? LucideIcons.heart : LucideIcons.heart,
                          color: isFav ? Colors.red : Colors.white,
                        ).animate(target: isFav ? 1 : 0).scale(begin: const Offset(1,1), end: const Offset(1.2,1.2)),
                      ),
                    ),
                    onPressed: () {
                      ref.read(favoriteProvider.notifier).toggleFavorite(widget.coffee.id);
                    },
                  ),
                  const SizedBox(width: 8),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: 'coffee_image_${widget.coffee.id}',
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(widget.coffee.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              AppTheme.darkBackground.withValues(alpha: 0.8),
                              AppTheme.darkBackground,
                            ],
                            stops: const [0.5, 0.8, 1.0],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.coffee.name,
                                  style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 28),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  widget.coffee.category,
                                  style: const TextStyle(color: AppTheme.textSecondary, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppTheme.surfaceLight,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                const Icon(LucideIcons.star, color: AppTheme.starYellow, size: 20),
                                const SizedBox(width: 4),
                                Text(
                                  widget.coffee.rating.toString(),
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
                      
                      const SizedBox(height: 24),
                      
                      // Description
                      const Text(
                        'Description',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ).animate().fadeIn(delay: 300.ms),
                      const SizedBox(height: 8),
                      Text(
                        widget.coffee.description,
                        style: const TextStyle(color: AppTheme.textSecondary, height: 1.5),
                      ).animate().fadeIn(delay: 400.ms),
                      
                      const SizedBox(height: 24),

                      // Size Selection
                      const Text(
                        'Size',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ).animate().fadeIn(delay: 500.ms),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: ['S', 'M', 'L'].map((size) {
                          final isSelected = selectedSize == size;
                          return GestureDetector(
                            onTap: () => setState(() => selectedSize = size),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 100,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: isSelected ? AppTheme.primaryCoffee : AppTheme.surfaceLight,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected ? AppTheme.primaryCoffee : Colors.transparent,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  size,
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : AppTheme.textSecondary,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ).animate().fadeIn(delay: 600.ms),

                      const SizedBox(height: 24),

                      // Sugar Level
                      const Text(
                        'Sugar Level',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ).animate().fadeIn(delay: 700.ms),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: AppTheme.primaryCoffee,
                          inactiveTrackColor: AppTheme.surfaceLight,
                          thumbColor: Colors.white,
                          overlayColor: AppTheme.primaryCoffee.withValues(alpha: 0.2),
                        ),
                        child: Slider(
                          value: sugarLevel.toDouble(),
                          min: 0,
                          max: 100,
                          divisions: 4,
                          label: '$sugarLevel%',
                          onChanged: (value) => setState(() => sugarLevel = value.toInt()),
                        ),
                      ).animate().fadeIn(delay: 800.ms),

                      // Milk Level
                      const Text(
                        'Milk Level',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ).animate().fadeIn(delay: 900.ms),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.white,
                          inactiveTrackColor: AppTheme.surfaceLight,
                          thumbColor: Colors.white,
                          overlayColor: Colors.white.withValues(alpha: 0.2),
                        ),
                        child: Slider(
                          value: milkLevel.toDouble(),
                          min: 0,
                          max: 100,
                          divisions: 4,
                          label: '$milkLevel%',
                          onChanged: (value) => setState(() => milkLevel = value.toInt()),
                        ),
                      ).animate().fadeIn(delay: 1000.ms),

                      const SizedBox(height: 100), // Space for bottom bar
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Bottom Bar (Price and Add to Cart)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Glassmorphism(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: AppTheme.surfaceColor,
              opacity: 0.9,
              blur: 20,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Price', style: TextStyle(color: AppTheme.textSecondary, fontSize: 14)),
                        Text(
                          '\$${widget.coffee.price.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    
                    // Add to cart button with morphing animation
                    GestureDetector(
                      onTap: _handleAddToCart,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: isAddingToCart ? 60 : 200,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryCoffee,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: isAddingToCart
                              ? Lottie.network(
                                  'https://lottie.host/17e5cd3a-4414-432a-bc9e-8c33ea50ab77/B2VIt5oY6H.json', // Success checkmark
                                  controller: _cartAnimController,
                                  onLoaded: (comp) => _cartAnimController.duration = comp.duration,
                                )
                              : const Text(
                                  'Add to Cart',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ).animate().slideY(begin: 1.0, end: 0, duration: 600.ms, curve: Curves.easeOutCubic),
        ],
      ),
    );
  }
}
