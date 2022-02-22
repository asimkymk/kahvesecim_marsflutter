import 'package:flutter/material.dart';
import 'package:kahvesecim_marsflutter/widgets/navigationbutton.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
  late YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.products[widget.index].videoUrl!,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: true,
        enableCaption: false,
      ),
    );
  }

  @override
  void deactivate() {
    // sayfa değiştiğinde videoyu durdur
    _controller.pause();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final double height = MediaQuery.of(context).size.height;
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
        ),
        builder: (context, player) {
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
                  Container(
                      height: orientation == Orientation.landscape
                          ? height * 0.2
                          : height * 0.25,
                      child: player),

                  ProductView(product: widget.products[widget.index]),

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
                                _controller.load(
                                    widget.products[widget.index].videoUrl!);
                                _controller.pause();
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
                                _controller.load(
                                    widget.products[widget.index].videoUrl!);
                                _controller.pause();
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
        });
  }
}
