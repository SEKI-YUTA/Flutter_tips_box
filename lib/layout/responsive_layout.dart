import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  ResponsiveLayout({Key? key}) : super(key: key);
  final Widget itemA = const Expanded(
    child: Center(
      child: Text(
        'ItemA',
        style: TextStyle(fontSize: 40),
      ),
    ),
  );
  final Widget itemB = const Expanded(
    child: Center(
      child: Text(
        'ItemB',
        style: TextStyle(fontSize: 40),
      ),
    ),
  );
  final Widget itemC = const Expanded(
    child: Center(
      child: Text(
        'ItemC',
        style: TextStyle(fontSize: 40),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 780) {
        return Column(
          children: [itemA, itemB, itemC],
        );
      }
      if (constraints.maxWidth < 1270) {
        return Column(
          children: [
            Row(
              children: [itemA, itemB],
            ),
            itemC
          ],
        );
      }

      return Row(
        children: [itemA, itemB, itemC],
      );
    });
  }
}
