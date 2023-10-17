import 'package:flutter/material.dart';

class InheritedWidgetPage extends StatefulWidget {
  const InheritedWidgetPage({super.key});

  @override
  State createState() {
    return _InheritedWidgetPageState();
  }
}

class _InheritedWidgetPageState extends State<InheritedWidgetPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("InheritedWidgetPage"),
      ),
      body: Center(
        child: ShareDataWidget(
            data: count,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _TestWidget(),
                ElevatedButton(
                    onPressed: () => setState(() {
                          count++;
                        }),
                    child: const Text("Click to add"))
              ],
            )),
      ),
    );
  }
}

class ShareDataWidget extends InheritedWidget {
  final int data;

  const ShareDataWidget({super.key, required this.data, required super.child});

  static ShareDataWidget? of(BuildContext context) {
    // return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
    return context.getElementForInheritedWidgetOfExactType<ShareDataWidget>()!.widget as ShareDataWidget;
  }

  @override
  bool updateShouldNotify(ShareDataWidget oldWidget) {
    return oldWidget.data != data;
  }
}

class _TestWidget extends StatefulWidget {
  @override
  State createState() {
    return _TestWidgetState();
  }
}

class _TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    // return Text("This is the value");
    return Text("This is the value:value${ShareDataWidget.of(context)!.data}");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //这里首次进入的时候还是一样会调用一次
    print("did change Dependencies!");
  }
}
