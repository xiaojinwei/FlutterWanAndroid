import 'package:flutter/material.dart';
import 'package:flutter_dynamic/ui/presentation/platform_adaptive.dart';
import 'package:flutter_dynamic/ui/widgets/dynamic_flutter_logo.dart';
import 'package:flutter_dynamic/ui/widgets/status_views.dart';
import 'package:flutter_dynamic/utils/i18n_util.dart';
import 'package:flutter_dynamic/utils/navigator_util.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_dynamic/redux/models/app_state.dart';
import 'package:flutter_dynamic/redux/actions/auth_actions.dart';

class LoginPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(I18nUtil.getS(context).log_in),
        centerTitle: true,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            child: Center(
              child: InkWell(
                child: Text(I18nUtil.getS(context).sign_up),
                onTap: ()=>NavigatorUtil.gotoRegister(context),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Center(
              child: InkWell(
                child: Text('Main'),
                onTap: ()=>NavigatorUtil.gotoMainOrBack(context),
              ),
            ),
          )
        ],
      ),
      body: new Container(
        child: new Padding(
            padding: new EdgeInsets.fromLTRB(32, MediaQuery.of(context).padding.top + 32, 32, 32),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Expanded(
                  child: new Center(
                    child: new DynamicFlutterLogo(180),
                  )
              ),
              new LoginForm(),
            ],
          ),
        ),
      ),
    );
  }

}

class LoginForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends State<LoginForm>{

  final _formKey = new GlobalKey<FormState>();

  FocusNode _passwordFocusNode;

  String _username;
  String _password;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
  }

  bool _submit(){
    var formState = _formKey.currentState;
    var validate = formState.validate();
    if(validate){
      formState.save();
    }
    return validate;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState,dynamic>(
      converter: (Store<AppState> store){
        return (BuildContext context,String username,String password) => 
              store.dispatch(login(context,username,password));
      },
      builder: (context,loginAction){
        return new Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                new TextFormField(
                  decoration: new InputDecoration(labelText: I18nUtil.getS(context).enter_username),
                  cursorColor: Theme.of(context).primaryColor,
                  validator: (val) =>
                  val.isEmpty ? I18nUtil.getS(context).enter_username_error : null,
                  onSaved: (val) => _username = val,
                  onFieldSubmitted: (v) => FocusScope.of(context).requestFocus(_passwordFocusNode),
                ),
                new TextFormField(
                  decoration: new InputDecoration(labelText:  I18nUtil.getS(context).enter_password),
                  cursorColor: Theme.of(context).primaryColor,
                  validator: (val) =>
                  val.isEmpty ? I18nUtil.getS(context).enter_password_error : null,
                  onSaved: (val) => _password = val,
                  focusNode: _passwordFocusNode,
                  obscureText:true,
                  onFieldSubmitted: (value) => _submit(),
                ),
                StoreConnector<AppState,bool>(
                  converter: (Store<AppState> store)=>store.state.authState.isAuthenticating??false,
                  builder: (context,logging){
                    return new Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: logging ? ProgressView() : PlatformAdaptiveButton(
                              icon: Icon(Icons.done,color: Theme.of(context).primaryColor,),
                              child: new Text(I18nUtil.getS(context).log_in,style: TextStyle(color: Theme.of(context).primaryColor),),
                              onPressed: (){
                                if(_submit())
                                  loginAction(context,_username,_password);
                              },
                            ),
                          );
                  },
                )
              ],
            )
        );
      },
    );
  }

}