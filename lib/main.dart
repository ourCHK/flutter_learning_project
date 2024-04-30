import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_learning_project/localization/custom_localization_delegate.dart';
import 'package:flutter_learning_project/providers/config_provider.dart';
import 'package:flutter_learning_sub_project/key/global.dart';
import 'package:flutter_learning_sub_project/l10n/auto_gen/app_sub_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'entry.dart';
import 'l10n/auto_gen/app_localizations.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(const ProviderScope(
    child: MyRouterApp(),
  ));
}

final GoRouter _route = GoRouter(
  routes: [
    GoRoute(
        path: "/",
        builder: (context, state) => const Entry(),
        // pageBuilder: (context, goRouteState) {
        //   return CustomTransitionPage<void>(
        //       child: page.getPageWidget(context, goRouteState),
        //       transitionsBuilder:
        //           (context, animation, secondaryAnimation, child) {
        //         //增加动画切换，目前暂时先这样使用，后续统一起来
        //         const begin = Offset(1.0, 0.0);
        //         const end = Offset.zero;
        //         const curve = Curves.ease;
        //         var tween = Tween(begin: begin, end: end)
        //             .chain(CurveTween(curve: curve));
        //         return SlideTransition(
        //           position: animation.drive(tween),
        //           child: child,
        //         );
        //       });
        // },
        routes: Entry.routes,
        // redirect: (context, state) {
        //   print("${state.fullPath}");
        //   if (!AppGlobal.isLogin &&
        //       state.fullPath != null &&
        //       state.fullPath!.contains("goRouterPage")) {
        //     return "/LoginPage?prePath=${state.uri.path}";
        //   }
        //   return null;
        // }
        ),
  ],
  navigatorKey: AppGlobal.navigatorKey,
);

class MyRouterApp extends StatefulWidget {
  const MyRouterApp({super.key});

  @override
  State createState() {
    return _MyRouteState();
  }
}

class _MyRouteState extends State<MyRouterApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      var language = ref.watch(languageProvider);
      var theme = ref.watch(themeProvider);
      return MaterialApp.router(
        routerConfig: _route,
        title: "FlutterLearningApp",
        theme: theme,
        localizationsDelegates: [
          ...GlobalMaterialLocalizations.delegates,
          AppLocalizations.delegate,
          AppSubLocalizations.delegate,
          CustomLocalizationDelegate()
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale(language, ''),
      );
    });
  }
}
