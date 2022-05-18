import 'package:flutter/material.dart';
import '../models/product.dart';

class Cart extends StatefulWidget {
  final List<Product> cart;
  final Function(Product)? onRemove;

  const Cart({Key? key, required this.cart, this.onRemove}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {

  @override
  Widget build(BuildContext context) {

    List<Product> _cart = widget.cart;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: ListView.builder(
          itemCount: _cart.length,
          itemBuilder: (context, index) {
            var item = _cart[index];
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
                  trailing: GestureDetector(
                      child: const Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      ),
                      onTap: () {
                        if (widget.onRemove != null) widget.onRemove!(item);
                        setState(() {
                          _cart.remove(item);
                        });
                      }),
                ),
              ),
            );
          }),
    );
  }
}