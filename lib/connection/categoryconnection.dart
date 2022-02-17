import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/category.dart';
import '../widgets/categorybanner.dart';

class CategoryConnection extends StatelessWidget {
  late ValueChanged<int> _setSelectedIndex;
  CategoryConnection(this._setSelectedIndex);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('categories').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Bağlantı hatası oluştu!');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                return CategoryBanner(
                    setSelectedIndex: _setSelectedIndex,
                    category: Category(
                      id: int.parse(data['id'].toString()),
                      title: data['title'].toString(),
                      imageUrl: data['imageUrl'].toString(),
                    ));
              }).toList(),
            ),
          );
        }
      },
    );
  }
}
