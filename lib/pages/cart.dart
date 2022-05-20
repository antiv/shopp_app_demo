import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_provider.dart';

class Cart extends ConsumerWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final _cart = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [Center(child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(_cart.total.toStringAsFixed(2)),
        ))],
      ),
      body: ListView.builder(
          itemCount: _cart.products.length,
          itemBuilder: (context, index) {
            var item = _cart.products[index];
            return Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: Card(
                elevation: 4.0,
                child: ListTile(
                  leading:Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loader.gif',
                      image: item.image ?? 'http://dummyimage.com/100x100.png/000000/000000',
                    ),
                  ),
                  title: Text(item.name ?? ''),
                  subtitle: Text(item.price?.toStringAsFixed(2) ?? '0.00'),
                  trailing: GestureDetector(
                      child: const Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      ),
                      onTap: () {
                        _cart.removeFromCart(item);
                      }),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Show alert with order details
        },
        label: const Text('Poruci'),
        icon: const Icon(Icons.phone_in_talk),
        // backgroundColor: Colors.pink,
      ),
    );
  }
}