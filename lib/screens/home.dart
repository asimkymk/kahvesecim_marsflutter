import 'package:flutter/material.dart';
import 'package:kahvesecim_marsflutter/connection/categoryconnection.dart';
import 'package:kahvesecim_marsflutter/connection/productconnection.dart';
import '../widgets/header.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Home();
  }

  int getSelectedIndex() {
    return selectedIndex;
  }
}

int selectedIndex = 0;

class _Home extends State<Home> {
  void setSelectedIndex(int si) {
    setState(() {
      selectedIndex = si;
    });
  }

  @override
  Widget build(BuildContext context) {
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
