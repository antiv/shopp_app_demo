import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopp_app/widgets/product_card.dart';
import 'package:vector_math/vector_math.dart' as math;

import '../models/product.dart';
import '../providers/cart_provider.dart';

class ProductGrid extends ConsumerStatefulWidget {
  const ProductGrid({Key? key, required this.products, }) : super(key: key);

  final List<Product> products;

  @override
  ConsumerState<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends ConsumerState<ProductGrid> {
  double _height = 300;
  double _width = 300;
  var rng = Random();

  @override
  Widget build(BuildContext context) {
    final _cart = ref.watch(cartProvider);
    List<Product> _cartList = _cart.products;
    int next = rng.nextInt(7);
    return GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          var item = widget.products[index];
          return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 4.0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierColor: Colors.black.withOpacity(0.4),
                          barrierLabel: '',
                          transitionBuilder: (context, anim1, anim2, child) {
                            List<Offset> offsets = [
                              Offset(0, anim1.value * 500 - 500),
                              Offset(anim1.value * 500 - 500, anim1.value * 500 - 500),
                              Offset(anim1.value * 500 - 500, 0),
                              Offset(anim1.value * -500 + 500, 0),
                              Offset(0, anim1.value * -500 + 500),
                              Offset(anim1.value * -500 + 500, anim1.value * 500 - 500),
                              Offset(anim1.value * -500 + 500, anim1.value * -500 + 500),
                              Offset(anim1.value * 500 - 500, anim1.value * -500 + 500),
                            ];
                            return Transform.rotate(
                              angle: math.radians(anim1.value * 360),
                              // scale: anim1.value,
                              // offset: offsets[next],
                              child: Opacity(
                                opacity: anim1.value,
                                child: AlertDialog(
                                  shape:
                                  OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
                                  title: Text(item.name ?? ''),
                                  content: InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      // setState(() {
                                      //   _height = _height == 300 ? 600 : 300;
                                      //   _width = _width == 300 ? 600 : 300;
                                      // });
                                    },
                                    child: SizedBox(
                                      height: _height,
                                      width: _width,
                                      child: ProductCard(item: item,),
                                    ),
                                  )
                                ),
                              ),
                            );
                          },
                          transitionDuration: Duration(milliseconds: 300),
                          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => SizedBox(height: 0,));
                    },
                    child: ProductCard(item: item)
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 8.0,
                      bottom: 8.0,
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        child:
                        AnimatedSwitcher(
                          switchInCurve: Curves.easeInOutBack,
                          duration: const Duration(milliseconds: 650),
                          transitionBuilder: (Widget child, Animation<double> animation) {
                            return ScaleTransition(scale: animation, child: child);
                          },
                          child:
                          _cartList.contains(item) ?
                          const Icon(
                            Icons.remove_circle,
                            key: ValueKey<int>(0),
                            color: Colors.red,
                          ) : const Icon(
                              Icons.add_circle,
                            key: ValueKey<int>(1),
                              color: Colors.green,
                            ),
                        ),
                        // (!_cartList.contains(item))
                        //     ? const Icon(
                        //   Icons.add_circle,
                        //   color: Colors.green,
                        // )
                        //     : const Icon(
                        //   Icons.remove_circle,
                        //   color: Colors.red,
                        // ),
                        onTap: () {
                          if (!_cartList.contains(item)) {
                            _cart.addToCart(item);
                          } else {
                            _cart.removeFromCart(item);
                          }
                          // });

                        },
                      ),
                    ),
                  ),
                ],
              ));
        });
  }
}

