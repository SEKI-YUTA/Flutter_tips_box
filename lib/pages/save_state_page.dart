import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class SaveStatePage extends StatefulWidget {
  const SaveStatePage({Key? key}) : super(key: key);

  @override
  State<SaveStatePage> createState() => _SaveStatePageState();
}

class _SaveStatePageState extends State<SaveStatePage>
    with WidgetsBindingObserver {
  TextEditingController _controller = TextEditingController();
  int count = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    initInputedData();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused) {
      saveInputedData();
      print("paused");
    } else if (state == AppLifecycleState.inactive) {
      print("inactive");
    } else if (state == AppLifecycleState.resumed) {
      print("resumed");
    }
  }

  void initInputedData() async {
    final prefs = await SharedPreferences.getInstance();
    _controller.text = await prefs.getString("inputedData") ?? "";
  }

  void saveInputedData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("inputedData", _controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Flexible(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: Colors.grey)),
            child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "please type some data!",
                    label: Text(
                      "inputData",
                      style: TextStyle(color: Colors.red),
                    ))),
          )),

          //                     InputBorder? errorBorder,
          // InputBorder? focusedBorder,
          // InputBorder? focusedErrorBorder,
          // InputBorder? disabledBorder,
          // InputBorder? enabledBorder,
          // InputBorder? border,
        ]),
      ),
    );
  }
}
