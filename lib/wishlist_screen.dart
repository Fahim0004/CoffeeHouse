import 'package:flutter/material.dart';
import 'package:my_coffee/wishlist_provider.dart';
import 'package:provider/provider.dart';

import 'item_detail_screen.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishListProvider = Provider.of<WishListProvider>(context);
    final wishListItems = wishListProvider.wishListItems;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF3A0202),
                  Color(0xFF080329),
                  Color(0xFF190320),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Favorites",
                  style: TextStyle(
                    color: Colors.amber.shade300,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Your favorite drinks, just a tap away!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: wishListItems.isEmpty
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.favorite_border,
                                size: 50,
                                color: Colors.white54,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Your wishList is Empty!",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: wishListItems.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final item = wishListItems[index];
                            return _buildWishListItem(context, item);
                          },
                        ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget _buildWishListItem(BuildContext context, WishListItem item) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: Material(
                color: Colors.transparent,
                child: ItemDetailsPopup(
                  title: item.name,
                  category: item.category,
                  image: item.imageUrl,
                  price: item.price,
                ),
              ),
            );
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFAA6132),
              Color(0xFFB9E4F3),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                item.imageUrl,
                height: 120,
                width: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Category: ${item.category}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Price: ₹${item.price.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        final wishListProvider = Provider.of<WishListProvider>(
                            context,
                            listen: false);
                        wishListProvider.removeFromWishList(item.name);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "${item.name} removed from wishlist!",
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red.shade700,
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 22,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}