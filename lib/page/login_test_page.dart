
import 'package:flutter/material.dart';
import 'package:flutter_learning_sub_project/key/global.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {

  final GoRouterState goRouterState;

  const LoginPage({super.key,required this.goRouterState});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("LoginPage")),
      body: Center(
        child: ElevatedButton(onPressed: (){
          var prePath = goRouterState.uri.queryParameters["prePath"];
          print("prePath:$prePath");
          if (prePath != null) {
            AppGlobal.isLogin = true;
            context.go(prePath);
          } else {
            context.pop();
          }
        }, child: Text("FinishLogin!")),
      ),
    );
  }
}