import 'package:flutter/material.dart';
import 'package:tips_box/widget/my_switch_button.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(title: Text("Item Name"), trailing: MySwitchButton(),);
        },
      ),
    );
  }
}