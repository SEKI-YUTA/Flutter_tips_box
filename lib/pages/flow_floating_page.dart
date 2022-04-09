import 'package:flutter/material.dart';

class FlowFloatingButtonPage extends StatelessWidget {
  const FlowFloatingButtonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Flow Floating Button"),
        ),
        body: _buildBody(context)
        // floatingActionButton: FlowButton(),
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
  const FlowButton(
      {Key? key,
      this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 5)})
      : super(key: key);
  final EdgeInsets padding;
  @override
  State<FlowButton> createState() => _FlowButtonState();
}

class _FlowButtonState extends State<FlowButton>
    with SingleTickerProviderStateMixin {
  late AnimationController buttonAnimation;
  IconData lastTapped = Icons.notifications;
  final List<IconData> buttonItems = <IconData>[
    Icons.home,
    Icons.new_releases,
    Icons.notifications,
    Icons.settings,
    Icons.menu
  ].reversed.toList();

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
    buttonAnimation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  Widget flowButtonItem(IconData icon) {
    final double buttonDiameter =
        MediaQuery.of(context).size.width / buttonItems.length - 20;
    return Container(
      padding: widget.padding,
      child: RawMaterialButton(
        fillColor: lastTapped == icon ? Colors.amber[700] : Colors.blue,
        splashColor: Colors.amber[100],
        shape: const CircleBorder(),
        constraints: BoxConstraints.tight(Size(buttonDiameter, buttonDiameter)),
        onPressed: () {
          _updateMenu(icon);
          buttonAnimation.status == AnimationStatus.completed
              ? buttonAnimation.reverse()
              : buttonAnimation.forward();
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
    return Flow(
      delegate: FlowButtonDelegate(
          buttonAnimation: buttonAnimation, bContext: context),
      children: buttonItems
          .map((IconData icon) => Container(
                child: flowButtonItem(icon),
              ))
          .toList(),
    );
  }
}

class FlowButtonDelegate extends FlowDelegate {
  FlowButtonDelegate({required this.buttonAnimation, required this.bContext})
      : super(repaint: buttonAnimation);

  final Animation<double> buttonAnimation;
  BuildContext bContext;

  @override
  bool shouldRepaint(FlowButtonDelegate oldDelegate) {
    return buttonAnimation != oldDelegate.buttonAnimation;
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    double dx = 0.0;
    for (int i = context.childCount - 1; i >= 0; i--) {
      dx = context.getChildSize(i)!.width * i;
      context.paintChild(i,
          transform: Matrix4.translationValues(
              MediaQuery.of(bContext).size.width - 80,
              (dx * buttonAnimation.value),
              0));
    }
  }
}
