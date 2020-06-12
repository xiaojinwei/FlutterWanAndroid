import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_dynamic/common/const.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Util {
  static int getLoadStatus(bool hasError, List data) {
    if (hasError) return LoadStatus.fail;
    if (data == null) {
      return LoadStatus.loading;
    } else if (data.isEmpty) {
      return LoadStatus.empty;
    } else {
      return LoadStatus.success;
    }
  }

  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/img/$name.$format';
  }

  static toast(String msg){
    Fluttertoast.showToast(msg: msg);
  }

  static Color getRandomColor(){
    return Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }


}