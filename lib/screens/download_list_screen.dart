import 'package:flutter/material.dart';
import 'dart:math';

import 'package:tips_box/widget/download_list_item.dart';

List<Map<String, dynamic>> itemList = [
  {"text": "HTML", "color": Colors.blue},
  {"text": "CSS", "color": Colors.yellow},
  {"text": "javaScript", "color": Colors.orange},
  {"text": "React", "color": Colors.blue[900]},
  {"text": "Dart", "color": Colors.blue[200]},
  {"text": "C", "color": Colors.grey},
  {"text": "C++", "color": Colors.grey[300]},
  {"text": "Kotlin", "color": Colors.orange[200]},
  {"text": "Java", "color": Colors.red},
  {"text": "Swift", "color": Colors.pink[100]},
  {"text": "ObjectiveC", "color": Colors.pink[300]},
  {"text": "Python", "color": Colors.yellow[300]}
  // "HTML",
  // "CSS",
  // "javaScript",
  // "React",
  // "Dart",
  // "Flutter",
  // "C",
  // "C++",
  // "Kotlin",
  // "Java",
  // "Swift",
  // "ObjectiveC",
  // "Python"
];

class DownloadListScreen extends StatelessWidget {
  bool isDownloading = false;
  bool downloadComplete = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (BuildContext context, int index) {
          return DownloadListItem(item: itemList[index]);
        },
      ),
    );
  }
}
