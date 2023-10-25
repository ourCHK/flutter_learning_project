import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TouchEventPage extends StatefulWidget {
  const TouchEventPage({super.key});

  @override
  State createState() {
    return _TouchEventState();
  }
}

class _TouchEventState extends State<TouchEventPage> {
  String _operation = "This will show your gesture!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TouchEventPage")),
      body: ListView(
        children: [
          Text("以下点击显示指针位置", textAlign: TextAlign.center),
          PointerMoveIndicator(),

          Text("以下显示具体手势", textAlign: TextAlign.center),
          Center(
            child: GestureDetector(
              onTap: () => updateOperation("Tap!"),
              onDoubleTap: () => updateOperation("Double Tap!"),
              onLongPress: () => updateOperation("On Long Press!"),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  _operation,
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.deepOrange,
                height: 150,
              ),
            ),
          ),

          Text("以下实现拖动", textAlign: TextAlign.center),
          Container(
            height: 150,
            color: Colors.amberAccent,
            child: _Drag(),
          ),

          Text("以下实现GestureRecoginzer", textAlign: TextAlign.center),
          Container(
            height: 150,
            color: Colors.amberAccent,
            child: _GestureRecognizer(),
          )

          // const Text(data)
        ],
      ),
    );
  }

  void updateOperation(String operation) {
    setState(() {
      _operation = operation;
    });
  }

  @override
  void didChangeDependencies() {
    print("didChangeDependencies!");
  }

  @override
  void didUpdateWidget(TouchEventPage oldWidget) {
    print("didUpdateWidget!");
  }
}

class _GestureRecognizer extends StatefulWidget {
  @override
  State createState() {
    return _GestureRecognizerState();
  }
}

class _GestureRecognizerState extends State<_GestureRecognizer> {
  final TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();

  bool _toggle = false; //变色开关

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(TextSpan(children: [
        TextSpan(text: "Hello World!"),
        TextSpan(
            text: "click me to change color",
            style: TextStyle(
                fontSize: 30, color: _toggle ? Colors.blue : Colors.red),
          recognizer: _tapGestureRecognizer
            ..onTap = () {
              setState(() {
                _toggle = !_toggle;
              });
            }
        ),
        TextSpan(text: "Hello World Again!")
      ])),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tapGestureRecognizer.dispose();
  }
}

class _Drag extends StatefulWidget {
  @override
  State createState() {
    return _DragState();
  }
}

class _DragState extends State<_Drag> {
  double _top = 0;
  double _left = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: _top,
            left: _left,
            child: GestureDetector(
              onPanDown: (e) {
                print("onPanDown");
              },
              onPanStart: (e) {
                print("onPanStart!");
              },
              onPanUpdate: (e) {
                //用户手指滑动时会触发此回调
                setState(() {
                  _left += e.delta.dx;
                  _top += e.delta.dy;
                });
              },
              onPanEnd: (e) {
                print("on pan end!");
              },
              child: CircleAvatar(
                child: Text("A"),
              ),
            ))
      ],
    );
  }
}

class PointerMoveIndicator extends StatefulWidget {
  const PointerMoveIndicator({super.key});

  @override
  State createState() {
    return _PointerMoveIndicatorState();
  }
}

class _PointerMoveIndicatorState extends State<PointerMoveIndicator> {
  PointerEvent? _event;
  Color color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        print("onPointerDown");
        setState(() {
          _event = event;
        });
      },
      onPointerMove: (event) {
        print("onPointerMove!");
      },
      onPointerUp: (event) {
        print("onPointerUp!");
      },
      onPointerCancel: (event) {
        print("onPointerCancel!");
      },
      child: Container(
          color: color,
          width: 300,
          height: 150,
          alignment: Alignment.center,
          child: Text(
            '${_event?.localPosition ?? ''}',
            style: const TextStyle(color: Colors.white),
          )),
    );
  }
}
