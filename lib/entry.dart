
import 'package:flutter/material.dart';
import 'package:flutter_learning_project/entry_list_type.dart';

class Entry extends StatefulWidget {

  @override
  State createState() {
    return EntryState();
  }
}

class EntryState extends State<Entry> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FlutterLearningProject"),),
      body: Center(
        child: ListView(
          children: EntryListType.values.map((type) {
            return ListTile(
              title: Text(type.pageName),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => type.pageWidget));
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}