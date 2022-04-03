import 'package:flutter/material.dart';
import 'dart:async';

class MyAnimationScreen extends StatefulWidget {
  MyAnimationScreen({Key? key, required this.statusBarHeight})
      : super(key: key);
  double statusBarHeight;

  @override
  State<MyAnimationScreen> createState() => _MyAnimationScreenState();
}

class _MyAnimationScreenState extends State<MyAnimationScreen> {
  final double _boxSize = 100;
  // double _fromTop = 0;
  // double _fromleft = 0;

  @override
  void initState() {
    super.initState();
    // Timer.periodic(Duration(milliseconds: 500), (timer) {
    //   // print(timer.tick);
    //   if (_fromleft < MediaQuery.of(context).size.width - _boxSize) {
    //     // まだ右端についてなかったら
    //     print('move horizontal');
    //     setState(() {
    //       _fromleft += 10;
    //     });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    print("height: ${MediaQuery.of(context).size.height}");
    print("appBar height: ${AppBar().preferredSize.height}");
    print("statusBarheight: ${MediaQuery.of(context).padding.top}");
    print("statusBarheight parent: ${widget.statusBarHeight}");
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 5000),
      builder: (context, val, child) {
        // print(val.runtimeType);
        return Stack(
          children: [
            Positioned(
              left: ((MediaQuery.of(context).size.width - _boxSize) *
                  double.parse(val.toString())),
              top: ((MediaQuery.of(context).size.height -
                      _boxSize -
                      AppBar().preferredSize.height -
                      widget.statusBarHeight) *
                  double.parse(val.toString())),
              // left: _fromleft,
              // top: _fromTop,
              child: Container(
                width: 100,
                height: _boxSize,
                color: Colors.red,
              ),
            )
          ],
        );
      },
    );
  }
}
