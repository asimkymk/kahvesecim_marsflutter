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
      initialVideoId: widget.products[widget.index].videoUrl!,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
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
    // sayfa değişirken videoyu durdur.
    _controller.pause();
    super.deactivate();
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
    final Orientation orientation = MediaQuery.of(context).orientation;
    final double height = MediaQuery.of(context).size.height;
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

            //player
            Container(
              height: orientation == Orientation.landscape
                  ? height * 0.2
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

            //product view
            ProductView(
              product: widget.products[widget.index],
              height: (MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom),
            ),

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
                          _controller
                              .load(widget.products[widget.index].videoUrl!);
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
                          _controller
                              .load(widget.products[widget.index].videoUrl!);
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
  }
}
