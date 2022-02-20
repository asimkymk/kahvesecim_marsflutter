import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/product.dart';
import '../screens/imageview.dart';

/*
TODO

Product değiştiğinde player güncellenecek.

*/

class ProductView extends StatefulWidget {
  final Product? product;
  final double? height;
  ProductView({Key? key, this.product, this.height}) : super(key: key);

  @override
  State<ProductView> createState() => _ProductView();
}

class _ProductView extends State<ProductView> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.product!.videoUrl!,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Product product = widget.product!;
    final double height = widget.height!;
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Column(
      children: [
        Container(
          height: orientation == Orientation.landscape
              ? height * 0.3
              : height * 0.25,
          child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
              topActions: <Widget>[
                Expanded(
                  child: Text(
                    _controller.metadata.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                )
              ]),
        ),
        Container(
          height: orientation == Orientation.landscape
              ? height * 0.1
              : height * 0.45,
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
                      Text((product.details! as String).replaceAll("\\n", "\n"),
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
