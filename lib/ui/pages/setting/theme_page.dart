import 'package:flutter/material.dart';
import 'package:flutter_dynamic/redux/actions/theme_action.dart';
import 'package:flutter_dynamic/redux/models/app_state.dart';
import 'package:flutter_dynamic/utils/i18n_util.dart';
import 'package:flutter_dynamic/utils/theme_util.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ThemePage extends StatefulWidget {
  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(I18nUtil.getS(context).theme),
        centerTitle: true,
      ),
      body: StoreConnector<AppState,dynamic>(
        converter: (store){
          return (MaterialColor color)=>store.dispatch(changeThemeColor(color));
        },
        builder: (context,changeThemeColor){
          var themeColor = ThemeUtil.getThemeColor(context);
           return ListView.builder(
                itemCount: Colors.primaries.length,
               itemBuilder: (context,index){
                 var element = Colors.primaries[index];
                  return GestureDetector(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  element[50],
                                  element[100],
                                  element[200],
                                  element[300],
                                  element[400],
                                  element[500],
                                  element[600],
                                  element[700],
                                  element[800],
                                  element[900],
                                ]),
                                borderRadius: BorderRadius.circular(6)
                            ),
                            height: 62,
                          ),
                          Positioned(
                            child: Colors.primaries[index] == themeColor ? Radio(
                                value: true,
                                groupValue: true,
                                activeColor: Colors.white,
                                onChanged: (value) {
                                  changeThemeColor(Colors.primaries[index]);
                                }) : Container(),
                            right: 6,
                            top: 0,
                            bottom: 0,
                          )
                        ],
                      ),
                    ),
                    onTap: ()=>changeThemeColor(Colors.primaries[index]),
                  );
               }
           );
        }
      ),
    );
  }
}
