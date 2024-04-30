import 'dart:convert';

import 'package:flutter/material.dart';

class MultiFlavorsPage extends StatefulWidget {
  const MultiFlavorsPage({super.key});


  @override
  State createState() {
    return _MultiFlavorsState();
  }
}

class _MultiFlavorsState extends State<MultiFlavorsPage> {

  String flavor = const String.fromEnvironment("FLUTTER_APP_FLAVOR",defaultValue: "");
  
  @override
  Widget build(BuildContext context) {
    loadAssets();
    return Scaffold(
      appBar: AppBar(title: Text("MultiFlavors")),
      body: Center(
        child: Image.asset("images/$flavor/image_flavor.png"),
      ),
    );
  }

  Future<void> loadAssets() async {
    var a = const String.fromEnvironment('FLUTTER_APP_FLAVOR');

    print("flavor:${const String.fromEnvironment('FLUTTER_APP_FLAVOR')}");

    final manifestContent = await DefaultAssetBundle.of(context).loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    final imagePaths = manifestMap.keys;
    imagePaths.toList().forEach((element) {
      debugPrint("imagePath:$element");
    });
        // .where((String key) => key.contains('images/'))
        // .where((String key) => key.contains('.png'))
        // .where((String key) => key.contains('.jpeg'))
        // .toList();
  }

}