import 'package:flutter/material.dart';
import 'package:flutter_learning_project/entry_list_type.dart';
import 'package:go_router/go_router.dart';

class Entry extends StatefulWidget {

  static List<RouteBase> routes = EntryListType.values
      .map((e) => GoRoute(path: e.name, builder: (context, state) => e.getPageWidget(context, state)))
      .toList();

  const Entry({super.key});

  @override
  State createState() {
    return EntryState();
  }
}

class EntryState extends State<Entry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FlutterLearningProject"),
      ),
      body: Center(
        child: ListView(
          children: EntryListType.values.map((type) {
            return ListTile(
              title: Text(type.name),
              onTap: () {
                context.go("/${type.name}?params1=Params1&params2=Params2");
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => type.pageWidget));
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
