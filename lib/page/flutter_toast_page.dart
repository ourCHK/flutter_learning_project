import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FlutterToastPage extends StatefulWidget {

  @override
  State createState() {
    return _FlutterToastState();
  }
}

class _FlutterToastState extends State<FlutterToastPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FlutterToastPage")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: ()=>showToast(), child: const Text("Click to Show Toast!"))
          ],
        ),
      ),
    );
  }

  void showToast() {
    Fluttertoast.showToast(msg: "This is the toast!",gravity: ToastGravity.BOTTOM, webPosition: "center", webBgColor: "#00ff00");
  }

}