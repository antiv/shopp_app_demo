import 'package:flutter/material.dart';
import 'package:shopp_app/pages/cart.dart';
import 'package:shopp_app/pages/home.dart';
import 'package:shopp_app/routes.dart';

void main() => runApp(const MyApp());

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
      // home: HomePage(title: 'Place order'),
      onGenerateRoute: (settings) {
        if (settings.name == Routes.cart) {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return Cart(
                cart: args['cart'],
                onRemove: args['onRemove'],
              );
            },
          );
        }
      },
      initialRoute: Routes.home,
      routes: {
        Routes.home: (context) => const HomePage(title: 'Place order'),
        // Routes.cart: (context) => Cart(),
      },
    );
  }
}