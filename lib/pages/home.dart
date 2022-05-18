import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../routes.dart';
import '../models/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> _products = [];

  final List<Product> _cartList = [];

  @override
  void initState() {
    super.initState();
    _populateProducts();
  }

  Future<void> _populateProducts() async {
    String url = 'https://my.api.mockaroo.com/articles.json?key=09a1ba70';

    http.Response response = await http.get(Uri.parse(url), headers: {
      'accept': 'application/json, text/plain, */*',
      'content-type': 'application/json;charset=UTF-8',
    }).timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        // Time has run out, do what you wanted to do.
        return http.Response('Timeout', 408);
      },
    );
    List<Product> list = [];
    if (response.statusCode == 200) {
      list = jsonDecode(utf8.decode(response.bodyBytes))
          .map((item) {
            return Product(
                id: item['id'], name: item['name'], image: item['image']);
          })
          .toList()
          .cast<Product>();
    }

    setState(() {
      _products = list;
    });
  }

  _removeItem(Product item) {
    setState(() {
      _cartList.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 8.0),
            child: GestureDetector(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  const Icon(
                    Icons.shopping_cart,
                    size: 36.0,
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
                  Navigator.pushNamed(
                    context,
                    Routes.cart,
                    arguments: {'cart': _cartList, 'onRemove': _removeItem},
                  );
                }
              },
            ),
          )
        ],
      ),
      body: //_buildGridView()
          _products.isNotEmpty
              ? RefreshIndicator(onRefresh: () { _cartList.clear(); return _populateProducts(); },
              child: _buildGridView())
              : const CircularProgressIndicator(), // _buildListView(),
    );
  }

  GridView _buildGridView() {
    return GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: _products.length,
        itemBuilder: (context, index) {
          var item = _products[index];
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
                          setState(() {
                            if (!_cartList.contains(item)) {
                              _cartList.add(item);
                            } else {
                              _cartList.remove(item);
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ));
        });
  }
}
