import 'package:flutter/material.dart';

class StateChangeTest extends StatefulWidget {
  @override
  State createState() {
    return _StateChangeState();
  }
}

class _StateChangeState extends State<StateChangeTest> {

  String myText = "1";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("StateChange")),
      body: Column(
        children: [
          MyWidget(myText),
          ElevatedButton(onPressed: (){
            setState(() {
              myText = "2";
            });
          }, child: Text("click"))
        ],
      ),
    );
  }
}

class MyWidget extends StatefulWidget {

  String text;


  MyWidget(this.text);

  @override
  State createState() {
    return _MyWidget();
  }
}

class _MyWidget extends State<MyWidget> {



  @override
  Widget build(BuildContext context) {
    return Text(widget.text);
  }

  @override
  void initState() {
    super.initState();
    debugPrint("initState");
  }
}
