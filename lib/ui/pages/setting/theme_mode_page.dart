import 'package:flutter/material.dart';
import 'package:flutter_dynamic/redux/actions/theme_action.dart';
import 'package:flutter_dynamic/redux/models/app_state.dart';
import 'package:flutter_dynamic/utils/i18n_util.dart';
import 'package:flutter_dynamic/utils/theme_util.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ThemeModePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ThemeModePageState();
}

class ThemeModePageState extends State<ThemeModePage>{

  List<ThemeModelLabel> models = [];

  @override
  Widget build(BuildContext context) {
      models.clear();
      models.addAll(ThemeUtil.getThemeModelLabels(context));
      return Scaffold(
        appBar: AppBar(
          title: Text(I18nUtil.getS(context).dark_mode),
          centerTitle: true,
        ),
        body: StoreConnector<AppState,dynamic>(
          converter: (store){
            return (int mode)=>store.dispatch(changeThemeMode(mode));
          },
          builder: (context,changeThemeMode){
            return ListView.builder(
              itemCount: models.length,
              itemBuilder: (BuildContext context,int index){
                ThemeModelLabel model = models[index];
                return ListTile(
                  title: Text(model?.title),
                  onTap: ()=>switchThemeMode(model.mode,changeThemeMode),
                  trailing: new Radio(
                      value: true,
                      groupValue: model.isSelected == true,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (value) {
                        switchThemeMode(model.mode,changeThemeMode);
                      }),
                );
              },
            );
          },
        ),
      );
  }

  switchThemeMode(int mode,changeThemeMode){
    setState(() {
      changeThemeMode(mode);
    });
  }

}
