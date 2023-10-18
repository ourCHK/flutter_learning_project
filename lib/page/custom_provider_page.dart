import 'dart:collection';

import 'package:flutter/material.dart';

class CustomProviderPage extends StatefulWidget {
  const CustomProviderPage({super.key});

  @override
  State createState() {
    return _CustomProviderPageState();
  }
}

class _CustomProviderPageState extends State<CustomProviderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CustomProvider")),
      body: Center(
        child: ChangeNotifierProvider<CartModel>(
          data: CartModel(),
          child: Builder(builder: (context) {
            return Column(
              children: <Widget>[
                // Builder(builder: (context) {
                //   var cart = ChangeNotifierProvider.of<CartModel>(context);
                //   return Text("总价：${cart.price}");
                // }),
                Consumer<CartModel>(builder: (context,cart) {
                  return Text("总价：${cart?.price}");
                }),
                Builder(builder: (context) {
                  print("ElevatedButton build");
                  return ElevatedButton(
                      onPressed: () {
                        ChangeNotifierProvider.of<CartModel>(context, listen: false)
                            .add(Item(20, 1));
                      },
                      child: const Text("添加商品"));
                }),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class InheritedProvider<T> extends InheritedWidget {
  final T data;

  const InheritedProvider(
      {super.key, required this.data, required super.child});

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}

class MyChangeNotifier implements Listenable {
  List listeners = [];

  @override
  void addListener(VoidCallback listener) {
    listeners.add(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    listeners.remove(listener);
  }

  void notifyListeners() {
    for (var item in listeners) {
      item();
    }
  }
}

class ChangeNotifierProvider<T extends MyChangeNotifier>
    extends StatefulWidget {
  final Widget child;
  final T data;

  const ChangeNotifierProvider({super.key, required this.child, required this.data});

  static T of<T>(BuildContext context, {bool listen = true}) {
    final provider = listen
        ? context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>()
        : context.getElementForInheritedWidgetOfExactType<InheritedProvider<T>>()?.widget as InheritedProvider<T>;
    return provider!.data;
  }



  @override
  State createState() {
    return _ChangeNotifierProviderState<T>();
  }
}

class _ChangeNotifierProviderState<T extends MyChangeNotifier>
    extends State<ChangeNotifierProvider<T>> {
  void update() {
    setState(() {});
  }

  @override
  void initState() {
    widget.data.addListener(update);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider(data: widget.data, child: widget.child);
  }

  @override
  void didUpdateWidget(ChangeNotifierProvider<T> oldWidget) {
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.data.removeListener(update);
    super.dispose();
  }
}

class Item {
  double price;
  int count;

  Item(this.price, this.count);
}

class CartModel extends MyChangeNotifier {
  final List<Item> _items = [];

  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  double get price =>
      _items.fold(0, (value, item) => value + item.count * item.price);

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }

}

class Consumer<T> extends StatelessWidget {

  const Consumer({super.key,required this.builder});


  final Widget Function(BuildContext context, T? value) builder;

  @override
  Widget build(BuildContext context) {
    return builder(context,ChangeNotifierProvider.of<T>(context));
  }

}
