import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../entry_list_type.dart';

class GoRouterPage extends StatefulWidget {

  final String? params1;

  final String? params2;

  final GoRouterState goRouterState;

  GoRouterPage({super.key, required this.goRouterState})
      :params1 = goRouterState.uri.queryParameters["params1"],
        params2=goRouterState.uri.queryParameters["params2"];

  @override
  State createState() {
    return _GoRouterState();
  }
}

class _GoRouterState extends State<GoRouterPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("GoRouterState")),
      body: Center(
        child: Column(
          children: [
            Text("This is the Params1:${widget.params1}"),
            Text("This is the Params2:${widget.params2}"),
            ElevatedButton(onPressed: (){
              context.go("/${EntryListType.loginPage.name}");
            }, child: Text("go login"))
          ],
        ),
      ),
    );
  }
}