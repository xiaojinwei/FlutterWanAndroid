import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FlutterLogo(
            /// 这时持久化的数据还没有加载出来，所以主题色还没有设置，则这里的主题色是系统默认的蓝色
            colors: Theme.of(context).primaryColor,
            size: 120.0,
          ),
        ),
      ),
    );
  }
}
