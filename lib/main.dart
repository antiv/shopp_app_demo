import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopp_app/pages/cart.dart';
import 'package:shopp_app/pages/home.dart';
import 'package:shopp_app/routes.dart';

void main() => runApp(
      const ProviderScope(child: MyApp()),
    );

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
      onGenerateRoute: (settings) {
        if (settings.name == Routes.cart) {
          return PageRouteBuilder(
              settings: settings,
              pageBuilder: (_, __, ___) => const Cart(),
              transitionsBuilder: (_, animation, __, child) {
                // return FadeTransition(opacity: animation, child: child);
                const begin = Offset(1.0, -1.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
                // return RotationTransition(
                //   turns: animation.drive(Tween(begin: 30, end: 40)),
                //   child: child,);
              });
        }
        // Unknown route
        return MaterialPageRoute(
            builder: (_) => const HomePage(title: 'Place order'));
      },
      routes: {
        Routes.home: (context) => const HomePage(title: 'Place order'),
        // Routes.cart: (context) => const Cart(),
      },
    );
  }
}
