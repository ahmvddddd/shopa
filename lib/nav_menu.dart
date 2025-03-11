// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/account/account_screen.dart';
import 'screens/explore/explore_screen.dart';
import 'screens/home/home_screen.dart';
import 'utils/constants/colors.dart';
import 'utils/helpers/helper_function.dart';


final bottomNavProvider = StateNotifierProvider<BottomNavController, int>((ref) {
  return BottomNavController();
});

class BottomNavController extends StateNotifier<int> {
  BottomNavController() : super(0);
  void changeIndex(int index) => state = index;
}

class NavigationMenu extends ConsumerWidget {
  final List<Widget> _pages = [
    HomeScreen(), 
    ExploreScreen(), 
    AccountScreen()
    ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dark = THelperFunctions.isDarkMode(context);
    final currentIndex = ref.watch(bottomNavProvider);
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: dark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1),
          boxShadow: [
            // BoxShadow(
            //   blurRadius: 10,
            //   color: dark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1),
            // )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: GNav(
            gap: 8,
            color: dark ? Colors.white : Colors.black,
            // backgroundColor: dark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1),
            activeColor: TColors.primary,
            tabBackgroundColor: Colors.transparent,
            padding: EdgeInsets.all(16),
            tabs: [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.explore, text: 'Explore'),
              GButton(icon: Icons.person, text: 'Account'),
            ],
            selectedIndex: currentIndex,
            onTabChange: (index) => ref.read(bottomNavProvider.notifier).changeIndex(index),
          ),
        ),
      ),
    );
  }
}
