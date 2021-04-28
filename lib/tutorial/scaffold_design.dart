import 'package:flutter/material.dart';

class AniSfw extends StatefulWidget {
  @override
  _AniSfwState createState() => _AniSfwState();
}

class _AniSfwState extends State<AniSfw> with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
