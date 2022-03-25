import 'package:flutter/material.dart';

class CrossFadeWidget extends StatefulWidget {
  const CrossFadeWidget({Key? key}) : super(key: key);

  @override
  State<CrossFadeWidget> createState() => _CrossFadeWidgetState();
}

class _CrossFadeWidgetState extends State<CrossFadeWidget> {
  bool isFirst = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () => setState(() {
          isFirst = !isFirst;
        }),
        child: AnimatedCrossFade(
            firstChild: _testChild(context: context, text: "FirstChild"),
            secondChild: _testChild(context: context, text: "SecondChild"),
            crossFadeState:
                isFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: Duration(milliseconds: 300)),
      ),
    );
  }

  Container _testChild({required BuildContext context, String? text}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      child: Text(
        text ?? "Sample Item",
        style: TextStyle(fontSize: 30),
      ),
      decoration: BoxDecoration(color: Colors.red),
    );
  }
}
