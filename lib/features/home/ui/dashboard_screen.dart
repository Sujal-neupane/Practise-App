import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practise_app/common/config/routes.dart';
import 'package:practise_app/common/theme/app_colors.dart';
import 'package:practise_app/common/widgets/custom_bottom_nav_bar.dart';
import 'package:practise_app/features/auth/bloc/auth_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentTabIndex = 0;
  int _selectedCategoryIndex = 0;

  final List<Map<String, dynamic>> _categories = const [
    {'name': 'All', 'icon': Icons.restaurant_rounded},
    {'name': 'Burger', 'icon': Icons.lunch_dining_rounded},
    {'name': 'Pizza', 'icon': Icons.local_pizza_rounded},
    {'name': 'Ramen', 'icon': Icons.ramen_dining_rounded},
    {'name': 'Dessert', 'icon': Icons.cake_rounded},
    {'name': 'Drinks', 'icon': Icons.local_cafe_rounded},
  ];

  final List<Map<String, dynamic>> _restaurants = const [
    {
      'name': 'Rose Garden Restaurant',
      'tag': 'Burger • Fast Food • Western',
      'rating': '4.8',
      'time': '20-25 min',
      'delivery': 'Free Delivery',
      'color': Color(0xFFFFECE0),
      'icon': Icons.lunch_dining_rounded,
    },
    {
      'name': 'Luigi\'s Pizza House',
      'tag': 'Pizza • Italian • Calzone',
      'rating': '4.9',
      'time': '15-20 min',
      'delivery': 'Free Delivery',
      'color': Color(0xFFFEF3C7),
      'icon': Icons.local_pizza_rounded,
    },
    {
      'name': 'Tokyo Ramen Kitchen',
      'tag': 'Japanese • Ramen • Asian',
      'rating': '4.7',
      'time': '25-30 min',
      'delivery': '\$1.99 Delivery',
      'color': Color(0xFFE0F2FE),
      'icon': Icons.ramen_dining_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: IndexedStack(
          index: _currentTabIndex,
          children: [
            _buildHomeTab(),
            _buildSearchTab(),
            _buildOrdersTab(),
            _buildProfileTab(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentTabIndex,
        cartBadgeCount: 2,
        onTap: (index) {
          setState(() {
            _currentTabIndex = index;
          });
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // TAB 1: HOME FEED
  // ---------------------------------------------------------------------------
  Widget _buildHomeTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. TOP APP BAR (Location + Cart/Notification Button)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'DELIVER TO',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: const [
                      Text(
                        'Halal Lab office',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.keyboard_arrow_down_rounded, size: 18),
                    ],
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // 2. GREETING & HEADLINE
          RichText(
            text: const TextSpan(
              style: TextStyle(fontSize: 22, height: 1.3),
              children: [
                TextSpan(
                  text: 'Hey Foodie, ',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: 'Good Afternoon! 🍔\n',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // 3. SEARCH BAR
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search dishes, restaurants...',
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: AppColors.textMuted,
                    ),
                    fillColor: const Color(0xFFF0F5FA),
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.tune_rounded, color: Colors.white),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // 4. CATEGORIES
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'All Categories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                'See All',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Category Pills Horizontal List
          SizedBox(
            height: 48,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final cat = _categories[index];
                final isSelected = _selectedCategoryIndex == index;
                return Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: FilterChip(
                    selected: isSelected,
                    showCheckmark: false,
                    avatar: Icon(
                      cat['icon'] as IconData,
                      size: 18,
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                    ),
                    label: Text(cat['name'] as String),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w600,
                      fontSize: 14,
                    ),
                    backgroundColor: Colors.white,
                    selectedColor: AppColors.primary,
                    side: BorderSide(
                      color: isSelected ? AppColors.primary : AppColors.border,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    onSelected: (_) {
                      setState(() {
                        _selectedCategoryIndex = index;
                      });
                    },
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          // 5. PROMO OFFER BANNER
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF7622), Color(0xFFFFA05C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.25),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'LIMITED OFFER',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Get 30% OFF\non your first 3 orders',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Use code: FOODIE30',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.fastfood_rounded,
                    size: 34,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // 6. POPULAR RESTAURANTS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Open Restaurants',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                'See All',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Restaurant Cards List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _restaurants.length,
            separatorBuilder: (_, _) => const SizedBox(height: 14),
            itemBuilder: (context, index) {
              final r = _restaurants[index];
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    // Restaurant Icon Thumbnail
                    Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                        color: r['color'] as Color,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        r['icon'] as IconData,
                        size: 34,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 14),
                    // Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            r['name'] as String,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            r['tag'] as String,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                size: 16,
                                color: AppColors.ratingStar,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                r['rating'] as String,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Icon(
                                Icons.schedule_rounded,
                                size: 14,
                                color: AppColors.textMuted,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                r['time'] as String,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                r['delivery'] as String,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // TAB 2: SEARCH
  // ---------------------------------------------------------------------------
  Widget _buildSearchTab() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Search Dishes',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              hintText: 'What are you craving today?',
              prefixIcon: Icon(Icons.search_rounded),
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Recent Searches',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              Chip(label: Text('Burgers')),
              Chip(label: Text('Chicken Wings')),
              Chip(label: Text('Pepperoni Pizza')),
              Chip(label: Text('Bubble Tea')),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // TAB 3: ORDERS
  // ---------------------------------------------------------------------------
  Widget _buildOrdersTab() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Orders',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Order #4829',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'On the way 🛵',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Rose Garden Restaurant • 3 items',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 14),
                LinearProgressIndicator(
                  value: 0.7,
                  backgroundColor: AppColors.border,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.primary,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Estimated arrival in 12 mins',
                  style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // TAB 4: PROFILE
  // ---------------------------------------------------------------------------
  Widget _buildProfileTab() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final user = state.user;
        if (user == null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.lock_outline,
                    size: 52,
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Sign in to manage your profile',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed(AppRoutes.login),
                    child: const Text('Sign in'),
                  ),
                ],
              ),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 44,
                backgroundColor: AppColors.primaryLight,
                child: Icon(
                  user.photoURL == null ? Icons.person_rounded : Icons.image,
                  size: 48,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                user.displayName ?? 'Your profile',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 4),
              Text(
                user.email ?? 'No email added',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
              ),
              const SizedBox(height: 28),
              ListTile(
                leading: const Icon(
                  Icons.edit_outlined,
                  color: AppColors.primary,
                ),
                title: const Text('Edit profile'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRoutes.profileEdit),
              ),
              ListTile(
                leading: const Icon(
                  Icons.location_on_outlined,
                  color: AppColors.primary,
                ),
                title: const Text('My Addresses'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.payment_rounded,
                  color: AppColors.primary,
                ),
                title: const Text('Payment Methods'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.settings_outlined,
                  color: AppColors.primary,
                ),
                title: const Text('Settings'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () {},
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () =>
                    context.read<AuthBloc>().add(AuthLogoutRequested()),
                icon: const Icon(Icons.logout_rounded),
                label: const Text('Sign out'),
              ),
            ],
          ),
        );
      },
    );
  }
}
