import 'package:flutter/material.dart';

class EditPage extends StatelessWidget {
  EditPage({Key? key, required this.updateData, required this.id})
      : super(key: key);
  Function(int, String) updateData;
  int id;
  TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('新しいタイトル'),
            Hero(
              tag: "item${id}",
              child: Flexible(
                  child: TextField(
                controller: _titleController,
              )),
            ),
            ElevatedButton(
                onPressed: () {
                  updateData(id, _titleController.text);
                  Navigator.of(context).pop();
                },
                child: Text('更新'))
          ],
        ),
      ),
    );
  }
}
