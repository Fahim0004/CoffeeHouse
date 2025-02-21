import 'package:flutter/material.dart';
import 'package:my_coffee/cart_provider.dart';
import 'package:my_coffee/checkout_screen.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;

    return Scaffold(
      backgroundColor: const Color(0xFFE47777),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                'Your cart is empty!',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    leading: Image.asset(
                      item.image,
                      width: 100,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      item.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.category),
                        const SizedBox(height: 4),
                        Text(
                          'Price: \$${item.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (item.quantity > 1) {
                                  cartProvider.decreaseQuantity(item.title);
                                } else {
                                  cartProvider.removeItem(item.title);
                                }
                              },
                              icon: const Icon(Icons.remove),
                            ),
                            Text(
                              '${item.quantity}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              onPressed: () {
                                cartProvider.increaseQuantity(item.title);
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        )
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        cartProvider.removeItem(item.title);
                      },
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: cartItems.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(12),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3A1111),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CheckoutScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Checkout',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : null,
    );
  }
}