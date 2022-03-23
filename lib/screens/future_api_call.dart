import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FutureApiCall extends StatelessWidget {
  Future<List> getData() async {
    var res =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/todos"));
    var decoded = utf8.decode(res.bodyBytes);
    var jsonResponse = json.decode(decoded);
    return jsonResponse;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Future API Call'),
        FutureBuilder<List>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  children: const [
                    Text(
                      'Error',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text('something happen')
                  ],
                ),
              );
            }
            return Flexible(
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index]["title"]),
                  );
                },
              ),
            );
          },
        )
      ],
    );
  }
}
