import 'package:flutter/material.dart';
import 'package:flutter_dynamic/generated/i18n.dart';
import 'package:flutter_dynamic/redux/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_dynamic/extension/locale_ext.dart';

class I18nUtil{
  static S getS(BuildContext context) {
    return S.of(context);
  }

  static List<LanguageModel> getSupportLanguages(BuildContext context){
    List<LanguageModel> models = [];
    //auto跟随系统
    models.add(LanguageModel(title:getLanguageTitle(context,null),locale:null,isSelected:isSelectedLanguage(context,null)));
    //本地化支持语言
    S.delegate.supportedLocales.forEach((element) {
      models.add(LanguageModel(title:getLanguageTitle(context,element),locale:element,isSelected:isSelectedLanguage(context,element)));
    });
    return models;
  }

  ///按Locale.toString()排序
  static List<LanguageModel> getSupportLanguagesSort(BuildContext context){
    var supportLanguages = getSupportLanguages(context);
    supportLanguages.sort((a,b)=> a.locale?.compareTo(b.locale)??-1);
    return supportLanguages;
  }

  static String getLanguageTitle(BuildContext context,Locale locale){
    String to = locale?.toString()??'auto';
    switch(to){
      case 'auto':
        return getS(context).language_auto;
      case 'en':
        return getS(context).language_en;
      case 'zh_CN'://zh_Hans_CN
        return getS(context).language_zh_cn;
      case 'zh_HK':
        return getS(context).language_zh_hk;
      default:
        return to;
    }
  }

  static LanguageModel getSelectedLanguageModel(BuildContext context){
    var locale = getSelectedLocale(context);
    return LanguageModel(title:getLanguageTitle(context,locale),locale:locale,isSelected:isSelectedLanguage(context,locale));
  }

  static Locale getSelectedLocale(BuildContext context){
    return StoreProvider.of<AppState>(context).state.locale;
  }

  static bool isSelectedLanguage(BuildContext context,Locale locale){
    return StoreProvider.of<AppState>(context).state.locale == locale;
  }

  static List<LanguageModel> switchSelectedLanguage(List<LanguageModel> supports,Locale selectedLocale){
    supports.forEach((element) {
      element.isSelected = false;
      if(element.locale == selectedLocale){
        element.isSelected = true;
      }
    });
    return supports;
  }

  ///如果指定的Locale不在支持范围内，就指定Locale('en','')
  ///如设置跟随系统时，如果将系统语言切换到不在supported支持内，就指定Locale('en','')，也就是显示English
  static LocaleResolutionCallback localeResolutionCallback(){
    return (Locale locale, Iterable<Locale> supported) {
      if (locale == null || !S.delegate.isSupported(locale)) {
        return Locale('en','');
      }
      for(var element in supported){
        if(element.languageCode == locale.languageCode &&
            element.countryCode == locale.countryCode){
          return element;
        }
      }
      return Locale('en','');
    };
  }

}

class LanguageModel {
  String title;
  Locale locale;
  bool isSelected;

  LanguageModel({this.title,this.locale,this.isSelected});
}