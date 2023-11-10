import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_learning_project/model/activity_model.dart';
import 'package:flutter_learning_project/providers/config_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RiverpodTestPage extends ConsumerStatefulWidget {
  @override
  ConsumerState createState() {
    return _RiverpodTestState();
  }
}

class _RiverpodTestState extends ConsumerState<RiverpodTestPage> {

  int? pre;
  int? cur;

  late Random random;


  @override
  void initState() {
    random = Random();
  }

  @override
  Widget build(BuildContext context) {
    final simpleProviderValue = ref.watch(simpleProvider);
    final simpleFamilyProviderValue = ref.watch(simpleFamilyProvider(1));
    final simpleFamilyProviderValue2 = ref.watch(simpleFamilyProvider(2));
    final simpleFamilyProviderRecordsValue = ref.watch(simpleRecordsFamilyProvider((a:1,b:2)));

    //使用listen只会回调监听，但是并不会刷新页面,所以我们需要使用setState
    ref.listen(listenProvider,(preValue,curValue) {
      pre = preValue;
      cur = curValue;
      setState(() {

      });
    });


    final combineAsyncProviderValue = ref.watch(combineAsyncProvider);

    final asyncProviderValue = ref.watch(simpleAsyncProvider);
    final autoDisposeProviderValue = ref.watch(simpleAutoDisposeAsyncProvider);

    final AsyncValue<ActivityModel> activity = ref.watch(httpProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("RiverpodTestPage"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("SimpleProvider:$simpleProviderValue"),
            Text("SimpleFamily1Provider:$simpleFamilyProviderValue"),
            Text("SimpleFamily2Provider:$simpleFamilyProviderValue2"),
            Text("simpleFamilyProviderRecordsValue:$simpleFamilyProviderRecordsValue"),
            renderCombineAsyncProvider(combineAsyncProviderValue),
            renderSimpleProvider(asyncProviderValue),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(onPressed: (){
                    ref.watch(simpleAsyncProvider.notifier).changeValue("I put data into it! and will not be dispose after leave page");
                  }, child: const Text("click to get the async value")),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(onPressed: (){
                    //这里相当于重新执行build作为状态
                    ref.invalidate(simpleAsyncProvider);
                  }, child: const Text("click to invalidate the async value")),
                )
              ],
            ),
            renderAutoDisposeSimpleProvider(autoDisposeProviderValue),
            ElevatedButton(onPressed: (){
              ref.watch(simpleAutoDisposeAsyncProvider.notifier).changeValue("I put data into it! and will auto dispose after leave page");
            }, child: const Text("click to get the auto dispose async value")),
            Text("PreValue:$pre and CurValue:$cur"),
            ElevatedButton(onPressed: (){
              ref.read(listenProvider.notifier).increase(random.nextInt(10));
            }, child: Text("click to add Value"))
            // ElevatedButton(
            //     onPressed: () {
            //       print(ref.watch(httpProvider).value!.activity);
            //     }, child: Text("Click To Get Request")),
            //
            // switch (activity) {
            //   AsyncData(:final value) => Text("value:${value.activity}"),
            //   AsyncError(:final error,:final stackTrace ) => Text("Error:$error, $stackTrace"),
            //   _ => Text("Loading")
            // }
          ],
        ),
      ),
    );
  }

  Widget renderSimpleProvider(AsyncValue<String> asyncValue) {
    return asyncValue.when(
        data: (data) => Text("This value of the AsyncProvider:$data"),
        error: (_, __) => Text("Oh,Error!"),
        loading: () => Text("Loading"));
  }

  Widget renderAutoDisposeSimpleProvider(AsyncValue<String> asyncValue) {
    var resultString =  asyncValue.when(
        data: (data) => data,
        error: (_, __) => "Oh,Error!",
        loading: () => "Loading");

    return Text("This is the value of the AutoDisposeAsyncProvider：$resultString");
  }

  Widget renderCombineAsyncProvider(AsyncValue<String> asyncValue) {
    var resultString =  asyncValue.when(
        data: (data) => data,
        error: (_, __) => "Oh,Error!",
        loading: () => "Loading");

    return Text("This is the value of the CombineAsyncProvider：$resultString");
  }
}
