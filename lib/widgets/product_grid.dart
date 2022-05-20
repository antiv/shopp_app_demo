import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product.dart';
import '../providers/cart_provider.dart';

class ProductGrid extends ConsumerWidget {
  const ProductGrid({Key? key, required this.products, }) : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _cart = ref.watch(cartProvider);
    List<Product> _cartList = _cart.products;
    return GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: products.length,
        itemBuilder: (context, index) {
          var item = products[index];
          return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 4.0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(item.image ??
                                'http://dummyimage.com/100x100.png/000000/000000'))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FadeInImage.assetNetwork(
                          width: 100.0,
                          placeholder: 'assets/images/loader.gif',
                          image: item.image ??
                              'http://dummyimage.com/100x100.png/000000/000000',
                        ),
                        // Image.network(
                        //   item.image ??
                        //       'http://dummyimage.com/100x100.png/000000/000000',
                        //   // scale: 0.4,
                        // ),
                        Container(
                          color: Colors.white38,
                          width: double.infinity,
                          height: 60,
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            item.name ?? '',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline6,
                            maxLines: 2,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 8.0,
                      bottom: 8.0,
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        child: (!_cartList.contains(item))
                            ? const Icon(
                          Icons.add_circle,
                          color: Colors.green,
                        )
                            : const Icon(
                          Icons.remove_circle,
                          color: Colors.red,
                        ),
                        onTap: () {
                          // setState(() {
                          if (!_cartList.contains(item)) {
                            _cart.addToCart(item);
                            // _cartList.add(item);
                            // ref.read(cartProvider.notifier).state.add(item);
                          } else {
                            _cart.removeFromCart(item);
                            // _cartList.remove(item);
                            // ref.read(cartProvider.notifier).state.remove(item);
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
