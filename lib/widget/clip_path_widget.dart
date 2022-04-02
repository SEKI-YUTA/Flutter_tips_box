import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ClipPathWidget extends StatelessWidget {
  const ClipPathWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipPath(
        clipper: CustomClipPath(),
        child: Container(
          child: const Center(
              child: Text(
            'ClipPath',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          )),
          color: Colors.red,
          height: 300,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    final path = Path();
    path.lineTo(0, h);
    // path.lineTo(w, h);
    path.quadraticBezierTo(w * 0.5, h - 100, w, h);
    path.lineTo(w, 0);
    path.quadraticBezierTo(w * 0.5, 100, 0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
