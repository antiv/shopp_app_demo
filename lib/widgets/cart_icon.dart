
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../routes.dart';

class CartIcon extends ConsumerWidget {
  const CartIcon({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context, ref) {
    final _cart = ref.watch(cartProvider);
    List<Product> _cartList = _cart.products;
    return Row(
      children: [
        Text(_cart.total.toStringAsFixed(2)),
        Padding(
          padding: const EdgeInsets.only(right: 16.0, top: 8.0),
          child: GestureDetector(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                const Icon(
                  Icons.shopping_cart,
                  size: 36.0,
                ),
                if (_cartList.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: CircleAvatar(
                      radius: 8.0,
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      child: Text(
                        _cartList.length.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            onTap: () {
              if (_cartList.isNotEmpty) {
                Navigator.of(context).pushNamed(Routes.cart);
              }
            },
          ),
        ),
      ],
    );
  }
}