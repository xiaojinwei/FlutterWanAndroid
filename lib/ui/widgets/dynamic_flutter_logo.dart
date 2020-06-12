import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class DynamicFlutterLogo extends StatefulWidget {

  double size;

  DynamicFlutterLogo(this.size);

  @override
  _DynamicFlutterLogoState createState() => _DynamicFlutterLogoState();
}

class _DynamicFlutterLogoState extends State<DynamicFlutterLogo> {

  final _styles = [FlutterLogoStyle.stacked, FlutterLogoStyle.markOnly, FlutterLogoStyle.horizontal];
  final _colors = Colors.primaries;
  final _curves = [
    Curves.ease, Curves.easeIn, Curves.easeInOutCubic, Curves.easeInOut,
    Curves.easeInQuad, Curves.easeInCirc, Curves.easeInBack, Curves.easeInOutExpo,
    Curves.easeInToLinear, Curves.easeOutExpo, Curves.easeInOutSine, Curves.easeOutSine,
  ];

  Timer _countdownTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // 2s定时器
      _countdownTimer = Timer.periodic(Duration(seconds: 2), (timer) {
        // https://www.jianshu.com/p/e4106b829bff
        if (!mounted) {
          return;
        }
        setState(() {

        });
      });
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogo(
      size: widget.size,
      colors: _colors[Random.secure().nextInt(_colors.length)],
      textColor: _colors[Random.secure().nextInt(_colors.length)],
      style: _styles[Random.secure().nextInt(3)],
      curve: _curves[Random.secure().nextInt(12)],
    );
  }
}
