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
                const ColorWidget(),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: renderColorChip(themeIndex,ref)),
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

class ColorWidget extends StatelessWidget {

  final Color? color;
  const ColorWidget({super.key,this.color});

  @override
  Widget build(BuildContext context) {
    var colorExtension = Theme.of(context).extension<ColorExtension>();
    return Container(
      alignment: Alignment.center,
      color: color ?? colorExtension?.color,
      height: 100,
      width: 100,
      child: const Text("Color Widget",style: TextStyle(color: Colors.black)),
    );
  }
}

class ColorExtension extends ThemeExtension<ColorExtension> {

  Color color;

  ColorExtension(this.color);

  //重写复制的方法
  @override
  ThemeExtension<ColorExtension> copyWith({Color? newColor}) {
    return ColorExtension(newColor ?? color);
  }

  //重写颜色变化时的动画切换
  @override
  ThemeExtension<ColorExtension> lerp(covariant ThemeExtension<ColorExtension>? other, double t) {
    if (other is! ColorExtension) {
      return this;
    }
    return ColorExtension(Color.lerp(color, other.color, t)!);
  }
}