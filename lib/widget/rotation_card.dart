import 'package:flutter/material.dart';
import 'dart:math';

class RotationCard extends StatefulWidget {
  const RotationCard({Key? key}) : super(key: key);

  @override
  State<RotationCard> createState() => _RotationCardState();
}

class _RotationCardState extends State<RotationCard> {
  bool isFront = true;
  double angle = 0;

  void flip() {
    setState(() {
      angle = (angle + pi) % (2 * pi);
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    print("width: $width");
    return GestureDetector(
        onTap: flip,
        onLongPress: () {
          // some feature
          // ex: delete action
        },
        child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: angle),
            duration: const Duration(milliseconds: 300),
            builder: (BuildContext context, double val, _) {
              if (val >= (pi / 2)) {
                isFront = false;
              } else {
                isFront = true;
              }
              print(val);
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..rotateY(val),
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  height: 120,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(5, 5))
                    ],
                  ),
                  child: isFront
                      ? Container(
                          child: Expanded(
                            child: Image.network(
                              "https://images.unsplash.com/photo-1497215728101-856f4ea42174?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Container(
                          child: Expanded(
                            child: Image.network(
                              "https://images.unsplash.com/photo-1647888535973-a9c2a15ad19b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ),
              );
            }));
  }
}
