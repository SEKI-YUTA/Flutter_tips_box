import 'package:flutter/material.dart';

class GridScreen extends StatelessWidget {
  GridScreen({Key? key}) : super(key: key);

  List<Widget> _items = List.generate(
      100,
      (index) => Container(
            child: Center(
                child: Text(
              index.toString(),
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )),
          )).toList();

  @override
  Widget build(BuildContext context) {
    print(_items);
    return SafeArea(
      child: Column(
        children: [
          Text('Grid Screen'),
          Flexible(
            child: GridView.count(
              crossAxisCount: 2,
              children: _items,
            ),
          )
        ],
      ),
    );
  }
}
