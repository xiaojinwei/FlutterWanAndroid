import 'package:flutter/material.dart';
import 'package:flutter_dynamic/redux/models/app_state.dart';
import 'package:flutter_dynamic/utils/i18n_util.dart';
import 'package:flutter_dynamic/utils/navigator_util.dart';
import 'package:flutter_dynamic/utils/theme_util.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = ThemeUtil.getThemeColorWithDark(context);
    bool isDark = ThemeUtil.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(I18nUtil.getS(context).setting),
        centerTitle: true,
      ),
      body: StoreBuilder<AppState>(
        builder: (context,store){
          return ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.color_lens,color: color),
                title: Text(I18nUtil.getS(context).theme),
                onTap: ()=>NavigatorUtil.gotoTheme(context),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(5.0),
                      width: 24.0,
                      height: 24.0,
                      color: isDark ? Theme.of(context).accentColor : Theme.of(context).primaryColor,
                    ),
                    Icon(Icons.keyboard_arrow_right)
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.translate,color: color),
                title: Text(I18nUtil.getS(context).font),
                onTap: ()=>NavigatorUtil.gotoFont(context),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(ThemeUtil.getFontFamily(context),
                      style: TextStyle(fontSize: 14,color:  color),),
                    Icon(Icons.keyboard_arrow_right)
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.language,color: color,),
                title: Text(I18nUtil.getS(context).multi_language),
                onTap: ()=>NavigatorUtil.gotoLanguage(context),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(I18nUtil.getSelectedLanguageModel(context)?.title,
                      style: TextStyle(fontSize: 14,color: color),),
                    Icon(Icons.keyboard_arrow_right)
                  ],
                ),
              ),
              ListTile(
                leading: Icon(!ThemeUtil.isDarkMode(context) ? Icons.brightness_6 : Icons.brightness_2,color: color),
                title: Text(I18nUtil.getS(context).dark_mode),
                onTap: ()=>NavigatorUtil.gotoThemeMode(context),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(ThemeUtil.getSelectedThemeModelLabel(context)?.title,
                      style: TextStyle(fontSize: 14,color: color),),
                    Icon(Icons.keyboard_arrow_right)
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
