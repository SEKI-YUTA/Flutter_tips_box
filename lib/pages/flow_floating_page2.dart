import 'dart:math';

import 'package:flutter/material.dart';

final double buttonSize = 60;

class FlowFloatingButtonPage2 extends StatelessWidget {
  const FlowFloatingButtonPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flow Floating Button"),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          // Expanded(child: FlowButton()),
          // ExpandedとContainerは意味がないが
          // 挙動がイメージしやすいので残しておく
          Expanded(
            child: Container(
              child: FlowButton(),
            ),
          ),
        ],
      ),
    );
  }
}

class FlowButton extends StatefulWidget {
  const FlowButton({
    Key? key,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  }) : super(key: key);
  final EdgeInsets padding;
  @override
  State<FlowButton> createState() => _FlowButtonState();
}

class _FlowButtonState extends State<FlowButton>
    with SingleTickerProviderStateMixin {
  late AnimationController buttonAnimationController;
  IconData lastTapped = Icons.notifications;
  final List<Map> buttonItems = [
    {"icon": Icons.home, "color": Colors.blue},
    {"icon": Icons.new_releases, "color": Colors.blue[400]},
    {"icon": Icons.notifications, "color": Colors.blue[300]},
    {"icon": Icons.settings, "color": Colors.blue[200]},
    {"icon": Icons.menu, "color": Colors.blue[100]},
  ];

  void _updateMenu(IconData icon) {
    if (icon != Icons.menu) {
      setState(() {
        lastTapped = icon;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    buttonAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  Widget flowButtonItem(IconData icon, Color iconColor, int index) {
    final double buttonDiameter =
        MediaQuery.of(context).size.width / buttonItems.length - 20;
    print("buttonSize: ${buttonSize}");
    return Container(
      width: buttonSize,
      height: buttonSize,
      child: RawMaterialButton(
        fillColor: lastTapped == icon ? Colors.amber[700] : iconColor,
        splashColor: Colors.amber[100],
        shape: const CircleBorder(),
        // 後で調べる↓
        // constraints: BoxConstraints.tight(Size(buttonDiameter, buttonDiameter)),
        onPressed: () {
          _updateMenu(icon);
          buttonAnimationController.status == AnimationStatus.completed
              ? buttonAnimationController.reverse()
              : buttonAnimationController.forward();
          // ここにボタンを押したときの処理を書く
          if (index == 0) {
            print("homeButton");
            // ホームボタンを押したときの処理
          }
          if (index == 2) {
            print("notifications");
            // 通知ボタンを押したときの処理
          }
        },
        child: Icon(
          icon,
          color: Colors.white,
          size: 45.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> flowButtons = [];
    buttonItems.asMap().forEach((int index, dynamic value) {
      flowButtons.add(
          {"icon": value["icon"], "color": value["color"], "index": index});
    });
    return Flow(
      delegate: FlowButtonDelegate(
          buttonAnimationController: buttonAnimationController,
          bContext: context),
      children: flowButtons
          .map((dynamic item) => Container(
                child:
                    flowButtonItem(item["icon"], item["color"], item["index"]),
              ))
          .toList(),
    );
  }
}

class FlowButtonDelegate extends FlowDelegate {
  FlowButtonDelegate(
      {required this.buttonAnimationController, required this.bContext})
      : super(repaint: buttonAnimationController);

  final Animation<double> buttonAnimationController;
  BuildContext bContext;

  @override
  bool shouldRepaint(FlowButtonDelegate oldDelegate) {
    return buttonAnimationController != oldDelegate.buttonAnimationController;
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    int n = context.childCount;
    // for (int i = context.childCount - 1; i >= 0; i--) {
    for (int i = 0; i < context.childCount; i++) {
      final isLastItem = (i == context.childCount - 1);
      final setValue = (value) => isLastItem ? 0.0 : value;

      final radius = 180 * buttonAnimationController.value - 30;

      final theta = i * pi * 0.5 / (n - 2);
      final x = setValue(radius * cos(theta));
      final y = setValue(radius * sin(theta));
      double dx = context.getChildSize(i)!.width * i;
      context.paintChild(i,
          transform: Matrix4.identity()
            ..translate(x, y, 0)
            ..translate(buttonSize / 2, buttonSize / 2)
            ..rotateZ(pi * (1 - buttonAnimationController.value))
            ..scale(
                isLastItem ? 1.0 : max(buttonAnimationController.value, 0.0))
            ..translate(-buttonSize / 2, -buttonSize / 2));
    }
  }
}
