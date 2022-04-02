import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DownloadListItem extends StatefulWidget {
  DownloadListItem({Key? key, required this.item}) : super(key: key);
  Map<String, dynamic> item;

  @override
  State<DownloadListItem> createState() => _DownloadListItemState();
}

class _DownloadListItemState extends State<DownloadListItem> {
  bool isDownloading = false;
  bool isDownloadComplete = false;
  int downloadProgress = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: widget.item["color"],
          child: Text(
            widget.item["text"].substring(0, 1),
            style: TextStyle(fontSize: 26),
          ),
        ),
        title: Text(widget.item["text"]),
        trailing: Column(
          children: [
            Visibility(
              visible: !isDownloading,
              child: IconButton(
                icon: Icon(
                  Icons.download,
                  color: isDownloadComplete ? Colors.blue : Colors.grey,
                ),
                onPressed: downloadItem,
              ),
            ),
            Visibility(
              visible: isDownloading,
              child: CircularPercentIndicator(
                radius: 20.0,
                lineWidth: 3.0,
                percent: (downloadProgress / 100),
                center: Text(
                  "${downloadProgress}%",
                  style: TextStyle(fontSize: 14, color: Colors.blue[200]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void downloadItem() async {
    isDownloading = true;
    isDownloadComplete = false;
    downloadProgress = 0;
    setState(() {});
    while (downloadProgress < 100) {
      downloadProgress += 5;
      setState(() {});
      if (downloadProgress == 100) {
        isDownloading = false;
        isDownloadComplete = true;
        setState(() {});
        break;
      }
      await Future.delayed(Duration(milliseconds: 500));
    }
  }
}
