import 'package:flutter/material.dart';
import 'package:kahvesecim_marsflutter/widgets/navigationbutton.dart';

import '../models/product.dart';
import '../widgets/header.dart';
import '../widgets/productview.dart';

class ProductDetails extends StatefulWidget {
  List<Product> products;
  int index;
  ProductDetails(this.products, this.index);
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            //BAŞLIK

            Header(),

            SizedBox(
              height: 10,
            ),

            // Geri tuşu
            Container(
                alignment: Alignment.topLeft,
                child: NavigationButton(
                  rightToLeft: true,
                  icon: Icons.arrow_back,
                  title: "Geri",
                  onTap: () {
                    Navigator.pop(context);
                  },
                )),

            SizedBox(
              height: 16,
            ),

            //product view

            ProductView(
              product: widget.products[widget.index],
              height: (MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom),
            ),

            SizedBox(
              height: 16,
            ),

            ///alt butonlar
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  NavigationButton(
                    rightToLeft: true,
                    title: "Önceki",
                    icon: Icons.keyboard_arrow_left,
                    onTap: () {
                      setState(() {
                        if (widget.index > 0) {
                          widget.index -= 1;
                        }
                      });
                    },
                  ),
                  Spacer(),
                  NavigationButton(
                    rightToLeft: false,
                    title: "Sonraki",
                    icon: Icons.keyboard_arrow_right,
                    onTap: () {
                      setState(() {
                        if (widget.index < widget.products.length - 1) {
                          widget.index += 1;
                        }
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
