import 'package:flutter/material.dart';
import 'package:flutter_learning_project/theme/theme_config.dart';

class ThemeChangePage extends StatefulWidget {
  const ThemeChangePage({super.key});

  @override
  State createState() {
    return _ThemeChangePageState();
  }
}

class _ThemeChangePageState extends State<ThemeChangePage> {
  int whichTheme = 0;

  late ThemeData themeData;

  @override
  void initState() {
    super.initState();
    themeData = ThemeData();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeConfig.themeList[whichTheme],
        child: Scaffold(
          appBar: AppBar(title: const Text("ThemeChangePage")),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Hello,This is the text with theme!",
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: renderColorChip()),
                Card(
                    child: InkWell(
                  splashColor: Colors.limeAccent,
                  onTap: () {},
                  child: const SizedBox(
                      width: 300,
                      height: 300,
                      child: Center(
                          child: Text("This is the card!",style: TextStyle(color: Colors.white)),
                      )),
                ))
              ],
            ),
          ),
        ));
  }

  Widget renderColorChip() {
    List<Widget> children = [];
    for (int i = 0; i < ThemeConfig.themeList.length; i++) {
      var color = ThemeConfig.themeList[i].primaryColor;
      Widget child;
      if (i == whichTheme) {
        child = Container(
            width: 50,
            height: 50,
            color: color,
            child: const Icon(Icons.check));
      } else {
        child = Container(
          width: 50,
          height: 50,
          color: color,
        );
      }
      children.add(GestureDetector(
        onTap: () => tapColor(i),
        child: child,
      ));
    }
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: children,
    );
  }

  tapColor(int which) {
    setState(() {
      whichTheme = which;
    });
  }

  changeTheme() {
    setState(() {
      themeData = ThemeData(
        colorSchemeSeed: Color(0xffff00b7),
        // primaryColor: Colors.amberAccent,
        // primarySwatch: Colors.green,
      );
    });
  }
}
