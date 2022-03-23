import 'package:flutter/material.dart';

class SliverAppBarPage extends StatelessWidget {
  const SliverAppBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 160,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Sliver AppBar'),
              background: FlutterLogo(),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                color: Colors.red,
                height: 100,
                child: Center(
                  child: Text(index.toString()),
                ),
              );
            },
            childCount: 20,
          ))
        ],
      ),
    );
  }
}
