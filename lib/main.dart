import 'package:flutter/material.dart';
import 'package:flutter_dynamic/ui/pages/loading_page.dart';
import 'package:flutter_dynamic/ui/widgets/gate.dart';
import 'package:flutter_dynamic/utils/i18n_util.dart';
import 'package:flutter_dynamic/utils/theme_util.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_dynamic/redux/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_dynamic/redux/middleware/middleware.dart';
import 'package:flutter_dynamic/ui/pages/main_page.dart';
import 'package:flutter_dynamic/ui/pages/account/login_page.dart';
import 'package:flutter_dynamic/generated/i18n.dart';

import 'application.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  bool forceLogin = false;//是否强制登录

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Application.instance.context = context;
    return PersistorGate(
      persistor: persistor,
      loading: LoadingPage(),
      builder: (context,store,expired) => new StoreProvider(store: store, child: StoreBuilder<AppState>(//国际化必须要用StoreBuilder包裹一下
        builder: (context,store){
          Application.instance.currentContext = context;
          return MaterialApp(
            navigatorKey: navigatorKey,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            supportedLocales: S.delegate.supportedLocales,
            localeResolutionCallback: I18nUtil.localeResolutionCallback(),
            locale: store.state.locale,//如果locale设置为null或者不指定，那么会跟随系统的Locale从supportedLocales中找是否支持，不支持可以使用localeResolutionCallback来指定支持的Locale
            title: 'Flutter WanAndroid', //在安卓任务管理列表中显示的名称
            themeMode: ThemeUtil.getThemeMode(context),//如果想支持跟随系统来自动设置暗黑模式，则需要设置themeMode，darkTheme，theme三个属性
            darkTheme: getTheme(store,isDarkMode: true),
            theme: getTheme(store,isDarkMode: false),//如果只设置theme，并且只在ThemeData设置brightness来设置暗黑模式，只有dark和light两种
            /*theme: ThemeData(
              primarySwatch: store.state.themeState.themeColor,
              accentColor: store.state.themeState.themeColor,
              fontFamily: store.state.themeState.fontFamily,
            ),*/
            routes: <String,WidgetBuilder>{
              '/':(BuildContext context) => new StoreConnector<AppState,dynamic>(
                builder: (BuildContext context,dynamic isAuthenticated) =>
                (!forceLogin || isAuthenticated && !expired) ? MainPage() : LoginPage(),
                converter: (Store<AppState> store) => store.state.authState?.isLoginStatus()??false,
              ),
              '/main':(BuildContext context) => MainPage(),
              '/login':(BuildContext context) => LoginPage(),
            },
          );
        },
      )),
    );
  }

  getTheme(store,{bool isDarkMode = false}) {
    return ThemeData(
      primarySwatch: store.state.themeState.themeColor,
      accentColor: store.state.themeState.themeColor,
      fontFamily: store.state.themeState.fontFamily,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
    );
  }

}

