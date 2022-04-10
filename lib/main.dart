import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tips_box/layout/responsive_layout.dart';
import 'package:tips_box/pages/edge_detection_page.dart';
import 'package:tips_box/pages/flow_floating_page2.dart';
import 'package:tips_box/pages/my_scaffold_3d.dart';
import 'package:tips_box/pages/navigation_drawer_3d.dart';
import 'package:tips_box/pages/navigation_drawer_joke.dart';
import 'package:tips_box/pages/navigation_drawer_rotated.dart';
import 'package:tips_box/pages/search_bar_page.dart';
import 'package:tips_box/pages/sliver_appbar_page.dart';
import 'package:tips_box/screens/basic_api_call.dart';
import 'package:tips_box/screens/card_list_screen.dart';
import 'package:tips_box/screens/download_list_screen.dart';
import 'package:tips_box/screens/drag_and_drop_screen.dart';
import 'package:tips_box/screens/future_api_call.dart';
import 'package:tips_box/screens/grid_screen.dart';
import 'package:tips_box/screens/mask_text_screen.dart';
import 'package:tips_box/screens/my_animation_screen.dart';
import 'package:tips_box/screens/parallax_list_horizontal_screen.dart';
import 'package:tips_box/screens/parallax_list_screen.dart';
import 'package:tips_box/screens/photo_filter_screen.dart';
import 'package:tips_box/screens/shimmer_screen.dart';
import 'package:tips_box/screens/slidable_list_screent.dart';
import 'package:tips_box/screens/stream_api_call.dart';
import 'package:tips_box/widget/NeumophismButton.dart';
import 'package:tips_box/widget/animated_title.dart';
import 'package:tips_box/widget/call_phone_widget.dart';
import 'package:tips_box/widget/clip_path_widget.dart';
import 'package:tips_box/widget/cross_fade_widget.dart';
import 'package:tips_box/pages/flow_floating_page.dart';
import 'package:tips_box/widget/horizontal_selector_widget.dart';
import 'package:tips_box/widget/like_button.dart';
import 'package:tips_box/widget/linear_flow_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print("padding top: ${MediaQuery.of(context).padding.top}");

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('TipsBox'),
      ),
      // body: Container(
      //   width: double.infinity,
      //   height: MediaQuery.of(context).size.height,
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       HorizontalSelector(),
      //     ],
      //   ),
      // ),
      // body: MyAnimationScreen(
      //     statusBarHeight: MediaQuery.of(context).padding.top),
      body: ParallaxListHorizontalScreen(),
    );
  }
}
