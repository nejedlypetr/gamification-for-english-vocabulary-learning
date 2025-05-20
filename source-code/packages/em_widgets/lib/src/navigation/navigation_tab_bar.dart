import 'package:em_widgets/src/navigation/notch_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NavigationItem {
  final String label;
  final IconData icon;
  final int? indicator;
  final IconData? activeIcon;

  NavigationItem({
    required this.icon,
    required this.label,
    this.indicator,
    this.activeIcon,
  });
}

class NavigationTabBar extends HookWidget {
  final Widget? child;
  final int currentIndex;
  final List<NavigationItem> items;
  final TabController? tabController;
  final Function(int index) onIndexChange;

  const NavigationTabBar({
    required this.items,
    required this.currentIndex,
    required this.onIndexChange,
    this.child,
    this.tabController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NotchNavigationBar(
      items: items,
      onTap: onIndexChange,
      currentIndex: currentIndex,
    );
  }
}
