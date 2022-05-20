
import 'package:flutter/material.dart';

import '../models/cart.dart';
import '../models/product.dart';
import '../routes.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({
    Key? key,
    required Cart? cart,
    required List<Product> cartList,
  }) : _cart = cart, _cartList = cartList, super(key: key);

  final Cart? _cart;
  final List<Product> _cartList;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(_cart?.total.toStringAsFixed(2) ?? '0.00'),
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