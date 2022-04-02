import 'dart:io';

import 'package:flutter/material.dart';
import 'package:edge_detection/edge_detection.dart' as detection;

class EdgeDetectionPage extends StatefulWidget {
  const EdgeDetectionPage({Key? key}) : super(key: key);

  @override
  State<EdgeDetectionPage> createState() => _EdgeDetectionPageState();
}

class _EdgeDetectionPageState extends State<EdgeDetectionPage> {
  String? _imgPath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detect Object'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: detectObject, child: const Text('Scan Object')),
            Text(_imgPath ?? "選択されていません"),
            _imgPath != null ? Image.file(File(_imgPath!)) : Container()
          ],
        ),
      ),
    );
  }

  void detectObject() async {
    String? path = await detection.EdgeDetection.detectEdge;
    setState(() {
      _imgPath = path;
    });
  }
}
