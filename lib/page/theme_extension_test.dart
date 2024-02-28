import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/config_provider.dart';
import '../theme/theme_config.dart';

class ThemeExtensionPage extends StatelessWidget {

  const ThemeExtensionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        var theme = ref.watch(themeProvider);
        var themeIndex = ThemeConfig.getThemeIndex(theme);
        return Scaffold(
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
                    child: renderColorChip(themeIndex,ref)),
                Card(
                    child: InkWell(
                      splashColor: Colors.limeAccent,
                      onTap: () {},
                      child: const SizedBox(
                          width: 300,
                          height: 300,
                          child: Center(
                            child: Text("This is the card!",
                                style: TextStyle(color: Colors.white)),
                          )),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }

  Widget renderColorChip(int which, WidgetRef ref) {
    List<Widget> children = [];
    for (int i = 0; i < ThemeConfig.themeList.length; i++) {
      var color = ThemeConfig.themeList[i].primaryColor;
      Widget child;
      if (i == which) {
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
        onTap: () => tapColor(i,ref),
        child: child,
      ));
    }
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: children,
    );
  }

  tapColor(int which, WidgetRef ref) {
    ref.read(themeProvider.notifier).changeTheme(ThemeConfig.themeList[which]);
  }

}