import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learning_project/providers/config_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ErrorRiverpodParentPage extends StatelessWidget {

  @override
  ConsumerState createState() {
    return _ErrorRiverpodPageState();
  }

  @override
  Widget build(BuildContext context) {
    return ErrorRiverpodPage((ref) => ErrorWidget(ref));
  }
}

class ErrorRiverpodPage extends ConsumerStatefulWidget {

  Widget Function(WidgetRef ref) childBuilder;


  ErrorRiverpodPage(this.childBuilder);

  @override
  ConsumerState createState() {
    return _ErrorRiverpodPageState();
  }
}

class _ErrorRiverpodPageState extends ConsumerState<ErrorRiverpodPage> {

  late Widget child;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // child = widget.childBuilder(ref);
  }

  @override
  Widget build(BuildContext context) {
    child = widget.childBuilder(ref);
    return Scaffold(
      appBar: AppBar(title: Text("ErrorRiverpodPage"),),
      body: Center(
        child: Column(
          children: [
            Text("below is the Error state!"),
            child
          ],
        ),
      ),
    );
  }
}

class ErrorParentWidget extends  StatelessWidget  {

  WidgetRef ref;

  ErrorParentWidget(this.ref);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("HH"),
        ErrorWidget(ref)
      ],
    );
  }
}

class ErrorWidget extends StatelessWidget {

  WidgetRef ref;

  ErrorWidget(this.ref);

  @override
  Widget build(BuildContext context) {
    String value = ref.watch(errorProvider);
    print("newValue:$value");
    return Column(
      children: [
        Text("This is the value from riverpod:$value"),
        ElevatedButton(onPressed: (){
          print("change");
          ref.read(errorProvider.notifier).changeValue("newValue");
        }, child: Text("ChangeState"))
      ],
    );
  }
}