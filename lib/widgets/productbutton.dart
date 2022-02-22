import 'package:flutter/material.dart';
import 'package:kahvesecim_marsflutter/screens/productDetails.dart';

import '../models/product.dart';

class ProductButton extends StatelessWidget {
  final List<Product> products;
  final int index;
  ProductButton(this.products, this.index);
  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetails(products, index)));
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
              color: Color.fromARGB(151, 255, 255, 255),
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
                  blurStyle: BlurStyle.outer,
                  blurRadius: 14,
                )
              ]),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            SizedBox(
              height: 16,
            ),
            Image.network(
              products[index].imageUrl!,
              height: orientation == Orientation.landscape ? 80 : 120,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 16,
            ),
            Text(products[index].title!,
                style: TextStyle(
                    color: Color(0xFF0A1034),
                    fontWeight: FontWeight.w500,
                    fontSize: 12))
          ])),
    );
  }
}
