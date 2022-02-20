import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kahvesecim_marsflutter/widgets/productbutton.dart';

import '../models/product.dart';

class ProductConnection extends StatelessWidget {
  int _selectedIndex;

  ProductConnection(this._selectedIndex);
  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return StreamBuilder<QuerySnapshot>(
      stream: _selectedIndex == 0
          ? FirebaseFirestore.instance.collection('products').snapshots()
          : FirebaseFirestore.instance
              .collection('products')
              .where("categoryId", isEqualTo: _selectedIndex)
              .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Bağlantı hatası oluştu!');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          List<Product> products = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            Map<String, dynamic> data =
                snapshot.data!.docs[i].data() as Map<String, dynamic>;

            products.add(Product(
                id: int.parse(data['id'].toString()),
                title: data['title'],
                categoryId: int.parse(data['categoryId'].toString()),
                imageUrl: data['imageUrl'].toString(),
                details: data['details'].toString(),
                brand: data['brand'].toString(),
                model: data['model'].toString(),
                barcode: data['barcode'].toString(),
                color: data['color'].toString(),
                materialType: data['materialType'].toString(),
                productGroup: data['productGroup'].toString(),
                origin: data['origin'].toString(),
                videoUrl: data['videoUrl'].toString()));
          }

          return Expanded(
            child: GridView.count(
              crossAxisCount: orientation == Orientation.landscape ? 3 : 2,
              childAspectRatio:
                  orientation == Orientation.landscape ? 7 / 5 : 4 / 5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: List.generate(snapshot.data!.docs.length, (index) {
                return ProductButton(products, index);
              }).toList(),
            ),
          );
        }
      },
    );
  }
}
