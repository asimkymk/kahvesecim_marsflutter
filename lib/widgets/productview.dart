import 'package:flutter/material.dart';

import '../models/product.dart';
import '../screens/imageview.dart';

class ProductView extends StatelessWidget {
  final Product? product;
  final double? height;
  ProductView({this.product, this.height});

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      height:
          orientation == Orientation.landscape ? height! * 0.45 : height! * 0.7,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FullScreenPage(
                              child: Image.network(product!.imageUrl!),
                              dark: true,
                            )));
              },
              child: Image.network(
                product!.imageUrl!,
                fit: orientation == Orientation.landscape ? null : BoxFit.cover,
                height: (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom) *
                    0.4,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              product!.title!,
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
                  Text((product!.details! as String).replaceAll("\\n", "\n"),
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
                            Text(product!.brand!),
                          ]),
                      TableRow(children: [
                        Text("Model No"),
                        Text(product!.model!),
                      ]),
                      TableRow(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 248, 244, 244)),
                          children: [
                            Text("Barkod"),
                            Text(product!.barcode!),
                          ]),
                      TableRow(children: [
                        Text("Renk"),
                        Text(product!.color!),
                      ]),
                      TableRow(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 248, 244, 244)),
                          children: [
                            Text("Malzeme Türü"),
                            Text(product!.materialType!),
                          ]),
                      TableRow(children: [
                        Text("Ürün Grubu"),
                        Text(product!.productGroup!),
                      ]),
                      TableRow(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 248, 244, 244)),
                          children: [
                            Text("Menşei"),
                            Text(product!.origin!),
                          ]),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
