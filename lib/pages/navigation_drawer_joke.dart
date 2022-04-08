import 'package:flutter/material.dart';

class NavigationDrawerJoke extends StatefulWidget {
  const NavigationDrawerJoke({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerJoke> createState() => _NavigationDrawerJokeState();
}

class _NavigationDrawerJokeState extends State<NavigationDrawerJoke> {
  double value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.orange, Colors.orange[700]!],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
          ),
          // SafeArea(
          //   child: Container(
          //     width: 200.0,
          //     padding: const EdgeInsets.all(8.0),
          //     child: Column(
          //       children: [
          //         DrawerHeader(
          //             child: Column(
          //           children: [
          //             CircleAvatar(
          //               radius: 50.0,
          //               backgroundColor: Colors.blue,
          //             ),
          //             SizedBox(
          //               height: 10.0,
          //             ),
          //             Text(
          //               "User Name",
          //               style: TextStyle(
          //                   fontSize: 30.0,
          //                   color: Colors.white,
          //                   fontWeight: FontWeight.bold),
          //             )
          //           ],
          //         )),
          //         Expanded(
          //             child: ListView(
          //           children: [
          //             ListTile(
          //               onTap: () {},
          //               leading: Icon(
          //                 Icons.home,
          //                 color: Colors.white,
          //               ),
          //               title: Text(
          //                 "Home",
          //                 style: TextStyle(color: Colors.white),
          //               ),
          //             ),
          //             ListTile(
          //               onTap: () {},
          //               leading: Icon(
          //                 Icons.person,
          //                 color: Colors.white,
          //               ),
          //               title: Text(
          //                 "Profile",
          //                 style: TextStyle(color: Colors.white),
          //               ),
          //             ),
          //             ListTile(
          //               onTap: () {},
          //               leading: Icon(
          //                 Icons.settings,
          //                 color: Colors.white,
          //               ),
          //               title: Text(
          //                 "Settings",
          //                 style: TextStyle(color: Colors.white),
          //               ),
          //             ),
          //             ListTile(
          //               onTap: () {},
          //               leading: Icon(
          //                 Icons.logout,
          //                 color: Colors.white,
          //               ),
          //               title: Text(
          //                 "LogOut",
          //                 style: TextStyle(color: Colors.white),
          //               ),
          //             ),
          //           ],
          //         ))
          //       ],
          //     ),
          //   ),
          // ),
          TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: value),
              duration: Duration(milliseconds: 150),
              builder: (_, double val, __) {
                return Transform(
                    origin: Offset(0, 300),
                    alignment: Alignment.topCenter,
                    transform: Matrix4.identity()..scale(1 - (0.2 * val)),
                    child: PageView(
                      physics: BouncingScrollPhysics(),
                      pageSnapping: false,
                      children: [
                        _pageItem(
                          context,
                          text: "page1",
                        ),
                        _pageItem(
                          context,
                          text: "page2",
                        ),
                        _pageItem(
                          context,
                          text: "page3",
                        ),
                      ],
                    ));
              }),
          GestureDetector(
            onVerticalDragUpdate: (details) {
              print({"dx: ${details.delta.dx}"});
              print({"dy: ${details.delta.dy}"});
              if (details.delta.dy < 0) {
                // show list action
                setState(() {
                  value = 1;
                });
              } else if (details.delta.dy > 0) {
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

  Scaffold _pageItem(BuildContext context, {required String text}) {
    return Scaffold(
      appBar: AppBar(title: const Text("Page Item")),
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                text,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )
            ],
          )),
    );
  }
}
