import 'package:flutter/material.dart';


class LifecycleTestPage extends StatefulWidget {
  const LifecycleTestPage({super.key});

  @override
  State createState() {
    return _LifecycleTestPageState();
  }
}

class _LifecycleTestPageState extends State<LifecycleTestPage> {

  String name = "";

  int age = 18;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("LifecycleTestPage")),
      body: Center(
        child: DependencyWidget(age, child: Column(
          children: [
            ...renderChildren()
          ],
        )),
      ),
    );
  }

  List<Widget> renderChildren() {
      return [
        LifecycleWidget(name, age),
        ElevatedButton(onPressed: (){
          setState(() {
            age++;
          });
        }, child: Text("ChangeDependencyAndUpdateWidget")),
        ElevatedButton(onPressed: (){
          setState(() {
            name = "${name}1";
          });
        }, child: Text("UpdateWidget")),
      ];
  }
}

class DependencyWidget extends InheritedWidget {

  final int data;

  const DependencyWidget(this.data,{super.key, required super.child});

  @override
  bool updateShouldNotify(DependencyWidget oldWidget) {
    return oldWidget.data != data;
  }

  static DependencyWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DependencyWidget>();
  }

}

class LifecycleWidget extends StatefulWidget {

  final String name;

  final int age;

  const LifecycleWidget(this.name, this.age, {super.key});

  @override
  State createState() {
    return _LifecycleWidgetState();
  }
}

class _LifecycleWidgetState extends State<LifecycleWidget> {

  late String nameDesc;

  @override
  void initState() {
    super.initState();
    debugPrint("Lifecycle initState");
    //这里如果只在initState处理的话，那么didUpdateWidget如果没有处理的话，就会导致数据无法跟新，所以我们需要在didUpdateWidget做处理
    nameDesc = "My name:${widget.name} ";
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Lifecycle build");
    return Text("$nameDesc My age:${DependencyWidget.of(context)?.data}");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //也就是实际上这个方法应该是依赖的对象的状态发生变化才会重新调用，而不是层级的变化发生变化，因为层级变化的话会重新走initState了，并且dispose方法也会走
    debugPrint("Lifecycle didChangeDependencies");
  }

  @override
  void didUpdateWidget(LifecycleWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint("Lifecycle didUpdateWidget");
    //我们必须在这里重新处理才可以正常更新，这里注释掉的话会导致无法更新，因为initState不会重新走
    nameDesc = "My name:${widget.name}";
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("Lifecycle dispose");
  }

}