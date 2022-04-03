import 'dart:math';

import 'package:flutter/material.dart';

class MyScaffold3D extends StatefulWidget {
  const MyScaffold3D({Key? key}) : super(key: key);

  @override
  State<MyScaffold3D> createState() => _MyScaffold3DState();
}

class _MyScaffold3DState extends State<MyScaffold3D> {
  int _count = 0;
  Offset _offset = Offset(0, 0);
  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.bottomCenter,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(0.001 * _offset.dx)
        ..rotateX(0.001 * _offset.dy),
      child: GestureDetector(
          onTap: () {
            print('tapped');
          },
          onPanUpdate: (details) {
            print(details);
            setState(() {
              _offset += details.delta;
            });
          },
          onDoubleTap: () {
            setState(() {
              _offset = Offset.zero;
            });
          },
          child: _appScreen(context)),
    );
  }

  Widget _appScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Scaffold3D",
        ),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          Text("Count ${_count}"),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _count++;
                });
              },
              child: Text('Up'))
        ]),
      ),
    );
  }
}
