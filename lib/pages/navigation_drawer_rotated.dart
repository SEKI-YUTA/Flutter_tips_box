import 'package:flutter/material.dart';
import 'dart:math';

class NavigationDrawerRotated extends StatefulWidget {
  const NavigationDrawerRotated({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerRotated> createState() =>
      _NavigationDrawerRotatedState();
}

class _NavigationDrawerRotatedState extends State<NavigationDrawerRotated> {
  double value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue[400]!, Colors.blue[800]!],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topLeft)),
          ),
          SafeArea(
              child: Container(
            width: 200.0,
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                DrawerHeader(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundColor: Colors.yellow,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'User Name',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: ListView(
                  children: [
                    ListTile(
                      onTap: () {},
                      leading: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      title: Text(
                        "Home",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      title: Text(
                        "Profile",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      title: Text(
                        "Settings",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      title: Text(
                        "LogOut",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ))
              ],
            ),
          )),
          TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: value),
              duration: Duration(milliseconds: 300),
              builder: (_, double val, __) {
                return (Transform(
                  alignment: Alignment.topLeft,
                  // transform: Matrix4.identity()
                  //   ..setEntry(3, 2, 0.001)
                  //   ..setEntry(0, 3, 200 * val)
                  //   ..rotateY((pi / 6) * val),
                  transform: Matrix4.identity()
                    ..setEntry(0, 3, 100 * val)
                    ..scale(1 - (0.2 * val))
                    ..rotateZ((pi / 180) * (-30 * val)),
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text("Rotated Drawer Menu"),
                    ),
                    body: Center(
                      child: Text("Swipe right to open the menu"),
                    ),
                  ),
                ));
              }),
          GestureDetector(
            // onTap: () {
            //   setState(() {
            //     value == 0 ? value = 1 : value = 0;
            //   });
            // },
            onHorizontalDragUpdate: (details) {
              print(details);
              if (details.delta.dx > 0) {
                setState(() {
                  value = 1;
                });
              } else {
                setState(() {
                  value = 0;
                });
              }
            },
          )
        ],
      ),
    );
  }
}
