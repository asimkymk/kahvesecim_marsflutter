import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kahvesecim_marsflutter/connection/categoryconnection.dart';
import 'package:kahvesecim_marsflutter/connection/productconnection.dart';
import 'package:kahvesecim_marsflutter/models/category.dart';
import 'package:kahvesecim_marsflutter/widgets/categorybanner.dart';

import '../models/product.dart';
import '../widgets/header.dart';
import '../widgets/productbutton.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}

class _Home extends State<Home> {
  int selectedIndex = 0;
  void setSelectedIndex(int si) {
    setState(() {
      selectedIndex = si;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height -
            MediaQuery.of(context).padding.top -
            MediaQuery.of(context).padding.bottom) *
        0.3;
    final double itemWidth = size.width / 2;

    return Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("assets/images/bc.jpg"),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: <Widget>[
                  //BAŞLIK

                  Header(),

                  SizedBox(
                    height: 18,
                  ),

                  //BANNER
                  buildBanner(),

                  SizedBox(
                    height: 18,
                  ),

                  //Categories

                  CategoryConnection(setSelectedIndex),

                  SizedBox(height: 18),

                  //products
                  ProductConnection(selectedIndex),
                ],
              )),
        ),
      ),
    );
  }

  buildBanner() {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "EVİNDE KOLAYCA İÇECEĞİNİ HAZIRLA!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                textAlign: TextAlign.center,
              ),
              Text("Hangi içecek türü sizi anlatıyor? Favori makineni seç",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center)
            ],
          ),
        ],
      ),
    );
  }
}
