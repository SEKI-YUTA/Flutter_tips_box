import 'package:flutter/material.dart';

class DragAndDropScreen extends StatefulWidget {
  const DragAndDropScreen({Key? key}) : super(key: key);

  @override
  State<DragAndDropScreen> createState() => _DragAndDropScreenState();
}

class _DragAndDropScreenState extends State<DragAndDropScreen> {
  List<Color> stack1 = [Colors.red, Colors.blue];
  List<Color> stack2 = [Colors.green];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildStack(stack1),
            buildStack(stack2),
          ],
        ),
      ),
    );
  }

  Widget buildStack(List<Color> stack) => DragTarget<Color>(onAccept: (data) {
        if (stack.isNotEmpty && data == stack.last) return;
        // print("stack.isNotEmpty: ${stack.isNotEmpty}");
        // print("data == stack.last: ${data == stack.last}");

        setState(() {
          stack.add(data);

          final otherStacks = [stack1, stack2]..remove(stack);
          print(otherStacks);
          for (final stack in otherStacks) {
            stack.remove(data);
          }
        });
      }, builder: (context, _, __) {
        return Stack(
          children: [
            Container(
              color: Colors.black,
              width: 200,
              height: 200,
              child: const Center(
                child: Text(
                  'Empty',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            ...stack.map(buildStackItem).toList()
          ],
        );
      });

  Widget buildStackItem(Color color) {
    final coloredBox = Container(
      color: color,
      width: 200,
      height: 200,
    );

    return Draggable(
      data: color,
      child: coloredBox,
      feedback: coloredBox,
      childWhenDragging: const SizedBox(
        width: 200,
        height: 200,
      ),
    );
  }
}
