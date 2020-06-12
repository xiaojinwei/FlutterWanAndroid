import 'package:flutter/material.dart';
import 'package:flutter_dynamic/net/data/index.dart';
import 'package:flutter_dynamic/ui/pages/account/login_page.dart';
import 'package:flutter_dynamic/ui/pages/account/register_page.dart';
import 'package:flutter_dynamic/ui/pages/collect/collect_page.dart';
import 'package:flutter_dynamic/ui/pages/rank/coin_page.dart';
import 'package:flutter_dynamic/ui/pages/rank/rank_page.dart';
import 'package:flutter_dynamic/ui/pages/search/search_view_delegate.dart';
import 'package:flutter_dynamic/ui/pages/setting/font_page.dart';
import 'package:flutter_dynamic/ui/pages/setting/language_page.dart';
import 'package:flutter_dynamic/ui/pages/setting/setting_page.dart';
import 'package:flutter_dynamic/ui/pages/setting/theme_mode_page.dart';
import 'package:flutter_dynamic/ui/pages/setting/theme_page.dart';
import 'package:flutter_dynamic/ui/pages/share/share_page.dart';
import 'package:flutter_dynamic/ui/pages/tree/tree_tab_page.dart';
import 'package:flutter_dynamic/ui/pages/webview_page.dart';
import 'package:flutter_dynamic/ui/pages/square/square_page.dart';
import 'package:flutter_dynamic/ui/pages/wenda/wenda_page.dart';

import '../application.dart';

class NavigatorUtil {

  ///跳转到指定页面
  static push(BuildContext context, Widget page) {
    Application.instance.currentContext = context;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => page));
  }

  ///页面关闭
  static pop(BuildContext context){
    Navigator.pop(context);
  }

  ///当可以返回时返回，否则直接强制到主页
  static gotoMainOrBack(BuildContext context){
    if(Navigator.canPop(context)){
      pop(context);
    }else{
      gotoMainRemoveUntil(context);
    }
  }

  ///跳转到主页，并且移除所有页面
  static gotoMainRemoveUntil(BuildContext context){
    Application.instance.currentContext = context;
    Navigator.of(context).pushNamedAndRemoveUntil('/main', (route) => false);
  }

  ///跳转到登录页，并且移除所有页面
  static gotoLoginRemoveUntil(BuildContext context){
    Application.instance.currentContext = context;
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }

  ///WebView
  static webView(BuildContext context,String url,{String title,int id,bool isCollect}){
    push(context,WebViewPage(url,title: title,id: id,isCollect: isCollect,));
  }

  ///设置页
  static gotoSetting(BuildContext context){
    push(context, SettingPage());
  }

  ///主题页
  static gotoTheme(BuildContext context){
    push(context, ThemePage());
  }

  ///字体页
  static gotoFont(BuildContext context){
    push(context, FontPage());
  }

  ///语言页
  static gotoLanguage(BuildContext context){
    push(context, LanguagePage());
  }

  ///登录页
  static gotoLogin(BuildContext context){
    push(context, LoginPage());
  }

  ///知识体系页
  static gotoSystemTree(BuildContext context,String title,List<BaseTree> baseList,int currentIndex){
    push(context, TreeTabPage(title,baseList,currentIndex));
  }

  ///问答页
  static gotoWenDa(BuildContext context){
    push(context, WenDaPage());
  }

  ///广场页
  static gotoSquare(BuildContext context){
    push(context, SquarePage());
  }

  ///注册页
  static gotoRegister(BuildContext context){
    push(context, RegisterPage());
  }

  ///我的收藏
  static gotoCollect(BuildContext context) {
    push(context, CollectPage());
  }

  ///积分排行榜
  static gotoRank(BuildContext context){
    push(context, RankPage());
  }

  ///个人积分获取列表
  static gotoCoin(BuildContext context){
    push(context, CoinPage());
  }

  ///暗黑模式页
  static gotoThemeMode(BuildContext context){
    push(context, ThemeModePage());
  }

  ///我的/分享人分享
  static gotoShare(BuildContext context,{int userId}){
    push(context, SharePage(userId: userId,));
  }
  
  ///搜索
  static gotoSearch(BuildContext context,{String searchKey}){
    showSearch(context: context,delegate: SearchViewDelegate(),query: searchKey);
  }

}