import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cart.dart';

final cartProvider = ChangeNotifierProvider<Cart>((ref) {
  return Cart();
});