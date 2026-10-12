import 'package:flutter/material.dart';

class Restaurant {
  const Restaurant({
    required this.name,
    required this.tag,
    required this.rating,
    required this.time,
    required this.delivery,
    required this.color,
    required this.icon,
  });

  final String name;
  final String tag;
  final String rating;
  final String time;
  final String delivery;
  final Color color;
  final IconData icon;
}

class RestaurantPage {
  const RestaurantPage({required this.items, required this.hasMore});

  final List<Restaurant> items;
  final bool hasMore;
}

class RestaurantRepository {
  static const _restaurants = [
    Restaurant(
      name: 'Rose Garden Restaurant',
      tag: 'Burger • Fast Food • Western',
      rating: '4.8',
      time: '20-25 min',
      delivery: 'Free Delivery',
      color: Color(0xFFFFECE0),
      icon: Icons.lunch_dining_rounded,
    ),
    Restaurant(
      name: 'Luigi\'s Pizza House',
      tag: 'Pizza • Italian • Calzone',
      rating: '4.9',
      time: '15-20 min',
      delivery: 'Free Delivery',
      color: Color(0xFFFEF3C7),
      icon: Icons.local_pizza_rounded,
    ),
    Restaurant(
      name: 'Tokyo Ramen Kitchen',
      tag: 'Japanese • Ramen • Asian',
      rating: '4.7',
      time: '25-30 min',
      delivery: '\$1.99 Delivery',
      color: Color(0xFFE0F2FE),
      icon: Icons.ramen_dining_rounded,
    ),
    Restaurant(
      name: 'Green Bowl Co.',
      tag: 'Healthy • Salads • Vegan',
      rating: '4.6',
      time: '18-22 min',
      delivery: 'Free Delivery',
      color: Color(0xFFDCFCE7),
      icon: Icons.eco_rounded,
    ),
    Restaurant(
      name: 'The Dessert Room',
      tag: 'Dessert • Cakes • Sweet',
      rating: '4.9',
      time: '10-15 min',
      delivery: '\$0.99 Delivery',
      color: Color(0xFFFCE7F3),
      icon: Icons.cake_rounded,
    ),
    Restaurant(
      name: 'Sizzle & Spice',
      tag: 'Indian • Curry • Grill',
      rating: '4.8',
      time: '30-35 min',
      delivery: 'Free Delivery',
      color: Color(0xFFFFEDD5),
      icon: Icons.local_fire_department_rounded,
    ),
  ];

  Future<RestaurantPage> fetchPage({
    required int page,
    int pageSize = 3,
  }) async {
    final start = page * pageSize;
    if (start >= _restaurants.length) {
      return const RestaurantPage(items: [], hasMore: false);
    }
    final end = (start + pageSize).clamp(0, _restaurants.length);
    return RestaurantPage(
      items: _restaurants.sublist(start, end),
      hasMore: end < _restaurants.length,
    );
  }
}
