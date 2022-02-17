import 'package:flutter/material.dart';

import '../models/category.dart';
import '../screens/home.dart';

class CategoryBanner extends StatelessWidget {
  final Category? category;
  final ValueChanged<int>? setSelectedIndex;

  CategoryBanner({this.category, this.setSelectedIndex});
  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return InkWell(
      onTap: () {
        setSelectedIndex!(category!.id!);
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 19,
            ),
            child: Opacity(
              opacity: Home().getSelectedIndex() == 0
                  ? 1
                  : Home().getSelectedIndex() == category!.id!
                      ? 1
                      : 0.5,
              child: Image.network(
                category!.imageUrl!,
                height: orientation == Orientation.landscape ? 40 : 60,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            category!.title!,
            style: TextStyle(
              fontSize: 14,
              color: Home().getSelectedIndex() == 0
                  ? Colors.black
                  : Home().getSelectedIndex() == category!.id!
                      ? Colors.black
                      : Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
