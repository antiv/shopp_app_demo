
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../routes.dart';

class CartIcon extends ConsumerStatefulWidget {
  const CartIcon({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<CartIcon> createState() => _CartIconState();
}

class _CartIconState extends ConsumerState<CartIcon> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 500));
  Animation? _colorTween;

  @override
  void initState() {
    Future.delayed(Duration.zero,() {_colorTween = ColorTween(begin: Theme.of(context).appBarTheme.foregroundColor, end: Theme.of(context).errorColor)
        .animate(_animationController);});
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  _onAddToCartAnimation() async {
    try {
      await _animationController.forward();
      _animationController.reset();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    final _cart = ref.watch(cartProvider);
    _onAddToCartAnimation();
    List<Product> _cartList = _cart.products;
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
        return Row(
          children: [
            Text(_cart.total.toStringAsFixed(2), style: TextStyle(color: _colorTween?.value)),
            Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 8.0),
              child: GestureDetector(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                     Icon(
                      Icons.shopping_cart,
                      size: 36.0,
                      color: _colorTween?.value,
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
    );
  }
}