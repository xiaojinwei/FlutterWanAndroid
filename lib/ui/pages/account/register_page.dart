import 'package:flutter/material.dart';
import 'package:flutter_dynamic/ui/presentation/platform_adaptive.dart';
import 'package:flutter_dynamic/ui/widgets/dynamic_flutter_logo.dart';
import 'package:flutter_dynamic/ui/widgets/status_views.dart';
import 'package:flutter_dynamic/utils/i18n_util.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_dynamic/redux/models/app_state.dart';
import 'package:flutter_dynamic/redux/actions/auth_actions.dart';

class RegisterPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(I18nUtil.getS(context).sign_up),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.ac_unit), onPressed: ()=>{

          })
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
              new RegisterForm(),
            ],
          ),
        ),
      ),
    );
  }

}

class RegisterForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _RegisterFormState();
  }
}

class _RegisterFormState extends State<RegisterForm>{

  final _formKey = new GlobalKey<FormState>();

  FocusNode _passwordFocusNode;
  FocusNode _repasswordFocusNode;

  String _username;
  String _password;
  String _repassword;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
    _repasswordFocusNode = FocusNode();
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
        return (BuildContext context,String username,String password,String repasspord) =>
              store.dispatch(register(context,username,password,repasspord));
      },
      builder: (context,registerAction){
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
                  onFieldSubmitted: (v) => FocusScope.of(context).requestFocus(_repasswordFocusNode),
                ),
                new TextFormField(
                  decoration: new InputDecoration(labelText:  I18nUtil.getS(context).confirm_password),
                  cursorColor: Theme.of(context).primaryColor,
                  validator: (val) =>
                  val.isEmpty ? I18nUtil.getS(context).confirm_password_error : null,
                  onSaved: (val) => _repassword = val,
                  focusNode: _repasswordFocusNode,
                  obscureText:true,
                  onFieldSubmitted: (value) => _submit(),
                ),
                StoreConnector<AppState,bool>(
                  converter: (Store<AppState> store)=>store.state.authState.isRegistering??false,
                  builder: (context,registering){
                    return new Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: registering ? ProgressView() : PlatformAdaptiveButton(
                              icon: Icon(Icons.done,color: Theme.of(context).primaryColor,),
                              child: new Text(I18nUtil.getS(context).sign_up,style: TextStyle(color: Theme.of(context).primaryColor),),
                              onPressed: (){
                                if(_submit())
                                  registerAction(context,_username,_password,_repassword);
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