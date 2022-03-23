import 'package:flutter/material.dart';
import 'package:tips_box/widget/rotation_card.dart';

class CardListScreen extends StatelessWidget {
  const CardListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return const RotationCard();
        },
      ),
    );
  }
}
