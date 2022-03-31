import 'package:flutter/material.dart';

class AnimatedTitle extends StatelessWidget {
  const AnimatedTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      child: const Text(
        'Sample Title',
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 38),
      ),
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 1000),
      builder: (BuildContext context, double _val, Widget? child) {
        return Opacity(
          opacity: _val,
          child: Padding(
            padding: EdgeInsets.only(top: 50 * _val),
            child: child,
          ),
        );
      },
    );
  }
}
