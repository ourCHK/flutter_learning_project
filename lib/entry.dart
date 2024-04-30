import 'package:flutter/material.dart';
import 'package:flutter_learning_project/entry_list_type.dart';
import 'package:go_router/go_router.dart';

class Entry extends StatefulWidget {
  static List<GoRoute> routes = EntryListType.values
      .map(
        (e) => GoRoute(
            path: e.name,
            builder: (context, state) => e.getPageWidget(context, state),
            pageBuilder: (context, goRouteState) {
              return CustomTransitionPage<void>(
                  child: e.getPageWidget(context, goRouteState),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    //增加动画切换，目前暂时先这样使用，后续统一起来
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.ease;
                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  });
            }
            ),
      )
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
                context.push("/${type.name}?params1=Params1&params2=Params2");
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
