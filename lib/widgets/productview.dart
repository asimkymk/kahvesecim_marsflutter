import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductView extends StatefulWidget {
  final Product? product;
  final double? height;
  ProductView({Key? key, this.product, this.height}) : super(key: key);

  @override
  State<ProductView> createState() => _ProductView();
}

class _ProductView extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    final Product product = widget.product!;
    final double height = widget.height!;
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Column(
      children: [
        Container(
          height: orientation == Orientation.landscape
              ? height * 0.24
              : height * 0.44,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  product.title!,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8, bottom: 8),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text("Ürün Açıklaması\n",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      Text((product.details!).replaceAll("\\n", "\n"),
                          style: TextStyle(fontWeight: FontWeight.w400)),
                      Text("Ürün Özellikleri\n",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      Table(
                        children: [
                          TableRow(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 248, 244, 244)),
                              children: [
                                Text("Marka"),
                                Text(product.brand!),
                              ]),
                          TableRow(children: [
                            Text("Model No"),
                            Text(product.model!),
                          ]),
                          TableRow(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 248, 244, 244)),
                              children: [
                                Text("Barkod"),
                                Text(product.barcode!),
                              ]),
                          TableRow(children: [
                            Text("Renk"),
                            Text(product.color!),
                          ]),
                          TableRow(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 248, 244, 244)),
                              children: [
                                Text("Malzeme Türü"),
                                Text(product.materialType!),
                              ]),
                          TableRow(children: [
                            Text("Ürün Grubu"),
                            Text(product.productGroup!),
                          ]),
                          TableRow(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 248, 244, 244)),
                              children: [
                                Text("Menşei"),
                                Text(product.origin!),
                              ]),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
