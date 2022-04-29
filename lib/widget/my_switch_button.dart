import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class MySwitchButton extends StatefulWidget {
  const MySwitchButton({Key? key}) : super(key: key);

  @override
  State<MySwitchButton> createState() => _MySwitchButtonState();
}

class _MySwitchButtonState extends State<MySwitchButton> {
  bool _checked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Switch(
        value: _checked,
        onChanged: (bool val) async {
          setState(() {
            _checked = val;
          });
          if (await Vibration.hasVibrator() &&
              await Vibration.hasAmplitudeControl()) {
            Vibration.vibrate(amplitude: 100, duration: 100);
          }
        },
      ),
    );
  }
}
