import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFFFFFFFF),
      selectedItemColor: const Color(0xFF4B2C20),
      unselectedItemColor: const Color(0xFFA63708),
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home),label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.favorite),label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person),label: ''),
      ],
    );
  }
}