import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart'
    as insetShadow;
import 'package:flutter/material.dart';

class NeumophismButton extends StatefulWidget {
  const NeumophismButton({Key? key}) : super(key: key);

  @override
  State<NeumophismButton> createState() => _NeumophismButtonState();
}

class _NeumophismButtonState extends State<NeumophismButton> {
  bool isPressed = true;
  @override
  Widget build(BuildContext context) {
    Offset distance = isPressed ? Offset(10, 10) : Offset(28, 28);
    double blur = isPressed ? 5 : 30;
    return GestureDetector(
      onTap: () => setState(() => isPressed = !isPressed),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        width: 100,
        height: 100,
        decoration: insetShadow.BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
            boxShadow: [
              insetShadow.BoxShadow(
                  offset: -distance,
                  color: Colors.white,
                  blurRadius: blur,
                  inset: isPressed),
              insetShadow.BoxShadow(
                  offset: distance,
                  color: Colors.grey,
                  blurRadius: blur,
                  inset: isPressed),
            ]),
      ),
    );
  }
}
