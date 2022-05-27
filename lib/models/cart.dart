import 'package:flutter/material.dart';
import 'package:shopp_app/models/product.dart';

class Cart extends ChangeNotifier {
  List<Product> products = [];

  double get total {
    return products.fold(0.0, (double currentTotal, Product nextProduct) {
      return currentTotal + (nextProduct.price ?? 0.0);
    });
  }

  void addToCart(Product product) {
    products.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    products.remove(product);
    notifyListeners();
  }

  void removeAllCart() {
    products.clear();
    notifyListeners();
  }
}
