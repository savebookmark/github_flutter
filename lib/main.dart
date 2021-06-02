import 'package:flutter/material.dart';

import 'package:get/get.dart';

//github 사용
void main() => runApp(GetMaterialApp(home: Home()));

class Home extends StatelessWidget {
  // Instantiate your class using Get.put() to make it available for all "child" routes there.
  final Controller c = Get.put(Controller());
  final Controller2 c2 = Get.put(Controller2());

  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(title: Obx(() => Text('Clicks: ${c.count} c2 :${c2.count2}'))),
        body: Center(child: ElevatedButton(onPressed: () => Get.to(Other()), child: Text('Go to Other'))),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: c.increment,
              child: Icon(Icons.add),
            ),
            SizedBox(height: 10),
            FloatingActionButton(
              onPressed: c2.decrament,
              child: Icon(Icons.remove),
            ),
          ],
        ));
  }
}

class Other extends StatelessWidget {
  // You can ask Get to find a Controller that is being used by another page and redirect you to it.
  final Controller c = Get.find();
  final Controller2 c2 = Get.find();

  @override
  Widget build(context) {
    // Access the updated count variable
    return Scaffold(appBar: AppBar(title: Text('Title1')), body: Center(child: Text('c:${c.count} c2:${c2.count2}')));
  }
}

class Other2 extends StatelessWidget {
  final Controller c = Get.find();
  final Controller2 c2 = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Title2')), body: Center(child: Text('c:${c.count} c2:${c2.count2}')));
  }
}

class Controller extends GetxController {
  var count = 0.obs;
  RxInt increment() => count++;
}

class Controller2 extends GetxController {
  RxInt count2 = 100.obs;
  RxInt increment() => count2++;
  RxInt decrament() => count2--;

  RxList<String> list = [''].obs;

  void putNumber(int value) {
    count2(value);
    list.addIf(count2.value == 90, 'ok');
  }

  @override
  void onInit() {
    ever(count2, (_) => print('매번'));
    once(count2, (_) => print('한번만'));
    debounce(count2, (_) => print('마지막 변경에 한번만'), time: Duration(seconds: 1));
    interval(count2, (_) => print('변경되고있는동안 1초마다'), time: Duration(seconds: 1));
    super.onInit();
  }
}
