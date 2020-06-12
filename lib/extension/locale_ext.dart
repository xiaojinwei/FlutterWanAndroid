import 'package:flutter/material.dart';

extension LocaleExtension on Locale {
  Map<String,dynamic>  toJson() {
    var map = Map<String,dynamic>();
    if(this.languageCode != null && this.languageCode != "")
        map["languageCode"] = this.languageCode;
    if(this.scriptCode != null && this.scriptCode != "")
        map["scriptCode"] = this.scriptCode;
    if(this.countryCode != null && this.countryCode != "")
      map["countryCode"] = this.countryCode;
    return map;
  }
   static Locale fromJson(Map<String,dynamic> json) =>
      json != null ? Locale.fromSubtags(languageCode:json['languageCode'],
      scriptCode:json['scriptCode'],
      countryCode:json['countryCode']) : null;

  int compareTo(Locale other){
    if(other == null) return -1;
    return this.toString().compareTo(other.toString());
  }

}
