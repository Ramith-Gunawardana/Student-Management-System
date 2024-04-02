import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomNavigationDestination extends StatelessWidget {
  CustomNavigationDestination({
    super.key,
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });
  AssetImage icon;
  AssetImage selectedIcon;
  String label;

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      icon: ImageIcon(
        icon,
        color: Theme.of(context).colorScheme.secondary,
      ),
      label: label,
      selectedIcon: ImageIcon(
        selectedIcon,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
