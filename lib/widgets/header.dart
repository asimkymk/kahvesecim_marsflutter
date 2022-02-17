import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final Orientation orientation = MediaQuery.of(context).orientation;

    return Container(
      height:
          orientation == Orientation.landscape ? height * 0.15 : height * 0.08,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 16),
      child: Image.asset(
        "assets/images/logo.png",
      ),
    );
  }
}
