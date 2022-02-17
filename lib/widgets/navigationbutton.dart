import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Function? onTap;
  final bool? rightToLeft;

  NavigationButton({this.title, this.icon, this.onTap, this.rightToLeft});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: rightToLeft!
                    ? [Icon(icon), SizedBox(width: 8), Text(title!)]
                    : [Text(title!), SizedBox(width: 8), Icon(icon)],
              )),
        ],
      ),
    );
  }
}
