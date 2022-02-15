import 'package:flutter/material.dart';

import 'package:github_flutter/tutorial/infinite_scrolling_test.dart';
import 'package:github_flutter/tutorial/infinite_lib.dart' as infi;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.indigo)),
      home: InfinitePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class InfinitePage extends StatefulWidget {
  final String title;

  InfinitePage({Key? key, required this.title}) : super(key: key);

  @override
  _InfinitePageState createState() => _InfinitePageState();
}

class _InfinitePageState extends State<InfinitePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Startup Name Generator'))),
      body: InfiniteS().buildSuggestions(),
      // body: CollapsingList(),
    );
  }
}

class Myinfi extends StatefulWidget {
  Myinfi({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyinfiState createState() => _MyinfiState();
}

class _MyinfiState extends State<Myinfi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        //body: InfiniteS().buildSuggestions(),
        // body: CollapsingList(),
        body: infi.buildSuggestions(),
        floatingActionButton: FloatingActionButton(tooltip: 'Increment', onPressed: () {}, child: Icon(Icons.add)));
  }
}
