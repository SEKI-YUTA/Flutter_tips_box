import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StreamApiCall extends StatefulWidget {
  const StreamApiCall({Key? key}) : super(key: key);

  @override
  State<StreamApiCall> createState() => _StreamApiCallState();
}

class _StreamApiCallState extends State<StreamApiCall> {
  var streamController = StreamController<List>();
  var apiData = [];
  @override
  void initState() {
    super.initState();
    getData();
    streamController.stream.listen((data) {
      setState(() {
        apiData = data;
      });
    });
  }

  void getData() async {
    var res =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/todos"));
    var decoded = utf8.decode(res.bodyBytes);
    var jsonResponse = json.decode(decoded);
    streamController.sink.add(jsonResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Stream API Call'),
        Flexible(
          child: ListView.builder(
            itemCount: apiData.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(apiData[index]["title"]),
              );
            },
          ),
        )
      ],
    );
  }
}
