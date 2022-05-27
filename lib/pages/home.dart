import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopp_app/models/cart.dart';
import 'package:shopp_app/providers/cart_provider.dart';
import 'package:shopp_app/widgets/product_grid.dart';

import '../models/product.dart';
import '../utils/http_utils.dart';
import '../widgets/cart_icon.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  List<Product> _products = [];
  Cart? _cart;
  @override
  void initState() {
    super.initState();
    _populateProducts();
  }

  Future<void> _populateProducts() async {
    _products = await getProducts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _cart = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: const [
          CartIcon()
        ],
      ),
      body: //_buildGridView()
          _products.isNotEmpty
              ? RefreshIndicator(onRefresh: () { _cart?.removeAllCart(); return _populateProducts(); },
              child: ProductGrid(products: _products,))
              : Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                  ],
                ),
              ), // _buildListView(),
    );
  }


}

