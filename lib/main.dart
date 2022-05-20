import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopp_app/pages/cart.dart';
import 'package:shopp_app/pages/home.dart';
import 'package:shopp_app/routes.dart';

void main() => runApp(const ProviderScope(child: MyApp()),);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopp Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: Routes.home,
      routes: {
        Routes.home: (context) => const HomePage(title: 'Place order'),
        Routes.cart: (context) => const Cart(),
      },
    );
  }
}