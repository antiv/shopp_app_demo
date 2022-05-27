import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Product item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(item.image ??
                  'http://dummyimage.com/100x100.png/000000/000000'))),
      child: LayoutBuilder(
          builder: (context, constraints)  {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 1,),
                Container(
                  color: Colors.white38,
                  width: double.infinity,
                  height: constraints.maxHeight / 3,
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      item.name ?? '',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6,
                      maxLines: 2,
                    ),
                  ),
                )
              ],
            );
          }
      ),
    );
  }
}