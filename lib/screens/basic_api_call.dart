import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BasicApiCall extends StatefulWidget {
  const BasicApiCall({Key? key}) : super(key: key);

  @override
  State<BasicApiCall> createState() => _BasicApiCallState();
}

class _BasicApiCallState extends State<BasicApiCall> {
  var apiData = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/todos"))
        .then((res) {
      print('object');
      print(res.body);
      var decoded = utf8.decode(res.bodyBytes);
      var jsonResponse = json.decode(decoded);
      setState(() {
        apiData = jsonResponse;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Basic API Call'),
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
