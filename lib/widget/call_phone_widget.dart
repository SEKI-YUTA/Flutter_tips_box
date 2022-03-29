import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallPhoneWidget extends StatelessWidget {
  const CallPhoneWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('Call'),
        onPressed: () async {
          launch('tel://117');
        },
      ),
    );
  }
}
