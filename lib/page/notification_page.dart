import 'package:flutter/material.dart';

class MyNotificationPage extends StatefulWidget {
  const MyNotificationPage({super.key});


  @override
  State createState() {
    return _MyNotificationState();
  }

}

class _MyNotificationState extends State<MyNotificationPage> {

  String _msg = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MyNotification")),
      body: NotificationListener<MyNotification>(
        onNotification: (notification) {
          setState(() {
            _msg += notification.msg;
          });
          return true;
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Builder(
                  builder: (context) {
                    return ElevatedButton(
                        onPressed: () {
                          MyNotification("hi").dispatch(context);
                        }, child: Text("SendNotification!"));
                  }
              ),
              Text(_msg)
            ],
          ),
        ),
      ),
    );
  }
}

class MyNotification extends Notification {
  MyNotification(this.msg);

  final String msg;
}



