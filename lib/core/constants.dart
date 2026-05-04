import '../models/coffee_model.dart';

class AppConstants {
  static const List<String> categories = [
    'All',
    'Espresso',
    'Latte',
    'Cappuccino',
    'Cold Brew',
    'Macchiato'
  ];

  static final List<CoffeeModel> mockCoffees = [
    CoffeeModel(
      id: '1',
      name: 'Caramel Macchiato',
      description: 'A layered espresso beverage with vanilla syrup, steamed milk, and a caramel drizzle.',
      price: 4.50,
      rating: 4.8,
      category: 'Macchiato',
      imageUrl: 'https://images.unsplash.com/photo-1485808191679-5f86510681a2?auto=format&fit=crop&q=80&w=800',
    ),
    CoffeeModel(
      id: '2',
      name: 'Iced Cold Brew',
      description: 'Slow-steeped custom blend with hints of citrus and chocolate.',
      price: 3.90,
      rating: 4.6,
      category: 'Cold Brew',
      imageUrl: 'https://images.unsplash.com/photo-1517701550927-30cf4ba1dba5?auto=format&fit=crop&q=80&w=800',
    ),
    CoffeeModel(
      id: '3',
      name: 'Classic Latte',
      description: 'Rich espresso balanced with steamed milk and a light layer of foam.',
      price: 4.20,
      rating: 4.7,
      category: 'Latte',
      imageUrl: 'https://images.unsplash.com/photo-1551030173-122aabc4489c?auto=format&fit=crop&q=80&w=800',
    ),
    CoffeeModel(
      id: '4',
      name: 'Double Espresso',
      description: 'Two shots of our signature espresso roast.',
      price: 2.50,
      rating: 4.5,
      category: 'Espresso',
      imageUrl: 'https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?auto=format&fit=crop&q=80&w=800',
    ),
    CoffeeModel(
      id: '5',
      name: 'Vanilla Cappuccino',
      description: 'Dark espresso lies in wait under a smoothed and stretched layer of thick milk foam, flavored with vanilla.',
      price: 4.80,
      rating: 4.9,
      category: 'Cappuccino',
      imageUrl: 'https://images.unsplash.com/photo-1534778101976-62847782c213?auto=format&fit=crop&q=80&w=800',
    ),
  ];
}
