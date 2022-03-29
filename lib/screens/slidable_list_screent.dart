import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:tips_box/pages/edit_page.dart';

class SlidableListScreen extends StatefulWidget {
  const SlidableListScreen({Key? key}) : super(key: key);

  @override
  State<SlidableListScreen> createState() => _SlidableListScreenState();
}

class _SlidableListScreenState extends State<SlidableListScreen> {
  List data = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var res =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    var decoded = utf8.decode(res.bodyBytes);
    var jsonResponse = json.decode(decoded);
    print('sample data');
    print(jsonResponse[0]);
    setState(() {
      data = jsonResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _buildListItem(
            index: index,
          );
        },
      ),
    );
  }

  Widget _buildListItem({
    required int index,
  }) {
    return Slidable(
      key: const ValueKey(0),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () {},
        ),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              deleteData(data[index]["id"]);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'delete',
          ),
          SlidableAction(
            onPressed: (BuildContext context) {
              editData(data[index]["id"]);
            },
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'edit',
          ),
        ],
      ),
      child: ListTile(
        leading: Text(
          'No:${data[index]["id"]}',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        title: Text(data[index]["title"]),
      ),
    );
  }

  void deleteData(int id) {
    var filtered = data.where((element) => element["id"] != id).toList();
    print(filtered[0]);
    setState(() {
      data = filtered;
    });
  }

  void editData(int id) {
    // updateData(1, "Hello !");
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EditPage(
              updateData: updateData,
              id: id,
            )));
  }

  void updateData(int id, String newTitle) {
    var updated = data.map((element) {
      if (element["id"] == id) {
        element["title"] = newTitle;
        return element;
      }
      return element;
    }).toList();
    setState(() {
      data = updated;
    });
  }
}
