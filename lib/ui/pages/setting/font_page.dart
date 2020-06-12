import 'package:flutter/material.dart';
import 'package:flutter_dynamic/redux/actions/theme_action.dart';
import 'package:flutter_dynamic/common/const.dart';
import 'package:flutter_dynamic/redux/models/app_state.dart';
import 'package:flutter_dynamic/utils/i18n_util.dart';
import 'package:flutter_dynamic/utils/theme_util.dart';
import 'package:flutter_redux/flutter_redux.dart';

class FontPage extends StatefulWidget {
  @override
  _FontPageState createState() => _FontPageState();
}

class _FontPageState extends State<FontPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(I18nUtil.getS(context).font,),
        centerTitle: true,
      ),
      body: StoreConnector<AppState,dynamic>(
        converter: (store){
          return (String fontFamily) => store.dispatch(changeFontFamily(fontFamily));
        },
        builder: (context,changeFontFamily){
          var fontFamily = ThemeUtil.getFontFamily(context);
          return ListView.builder(
              itemCount: Const.supportFontFamily.length,
              itemBuilder: (context,index){
                var element = Const.supportFontFamily[index];
                return ListTile(
                  title: Text(element,style: TextStyle(color: ThemeUtil.getThemeColorWithDark(context),fontFamily: element),),
                  subtitle: Text(Const.fontChina,style: TextStyle(color: ThemeUtil.getThemeColorWithDark(context),fontFamily: element,)),
                  trailing: Radio(
                      value: true,
                      groupValue: fontFamily == element,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (value) {
                        switchFontFamily(element,changeFontFamily);
                      }),
                  onTap: ()=>switchFontFamily(element,changeFontFamily),
                );
              }
          );
        },
      ),
    );
  }

  switchFontFamily(String fontFamily,changeFontFamily){
    setState(() {
      changeFontFamily(fontFamily);
    });
  }
}
