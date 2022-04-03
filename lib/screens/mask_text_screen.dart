import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class MaskTextScreen extends StatelessWidget {
  const MaskTextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("MaskImage"),
          MaskImage(
              image: AssetImage('assets/image1.jpg'),
              child: Text(
                "Mask",
                style: TextStyle(
                    fontSize: 120,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}

class MaskImage extends StatelessWidget {
  const MaskImage({Key? key, required this.image, required this.child})
      : super(key: key);
  final ImageProvider image;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    print("MaskImage");
    return FutureBuilder<ui.Image>(
      future: loadImage(),
      builder: (context, snap) => snap.hasData
          ? ShaderMask(
              shaderCallback: (bounds) => ImageShader(snap.data!,
                  TileMode.clamp, TileMode.clamp, Matrix4.identity().storage),
            )
          : Container(),
    );
  }

  Future<ui.Image> loadImage() async {
    final completer = Completer<ui.Image>();
    final stream = image.resolve((ImageConfiguration()));
    stream.addListener(
        ImageStreamListener((info, _) => completer.complete(info.image)));
    return completer.future;
  }
}
