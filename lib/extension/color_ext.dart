import 'package:flutter/material.dart';

extension ColorExtension on Color {
  /// 因为主题的primarySwatch只支持MaterialColor，而MaterialColor是由体统系统的那么几种，
  /// 自己无法由Color转MaterialColor，所以这里只存Colors.primaries的索引，不存argb
  int toJson() {
    for(int index=0;index < Colors.primaries.length;index++){
      if(this == Colors.primaries[index]){
        return index;
      }
    }
    return -1;
  }
  ///通过索引解析Colors.primaries的位置
  static Color fromJson(int index) =>
    index != null && index >=0 && index < Colors.primaries.length
      ? Colors.primaries[index] : null;

}
