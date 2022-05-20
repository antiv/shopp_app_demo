import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../models/product.dart';

Future<List<Product>> getProducts() async {
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
          id: item['id'], name: item['name'], image: item['image'], price: double.parse('${item['price']}'));
    })
        .toList()
        .cast<Product>();
    return list;
  } else {
    log('ERROR: ${response.statusCode} - ${response.body}');
    return [];
  }
}