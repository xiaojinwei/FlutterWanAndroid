import 'package:flutter/widgets.dart';
import 'package:flutter_dynamic/redux/models/app_state.dart';
import 'package:flutter_dynamic/ui/pages/error_page.dart';
import 'package:flutter_dynamic/utils/cookie_util.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:flutter_dynamic/redux/store/store.dart';
import 'package:redux/redux.dart';

typedef WidgetGateBuilder = Widget Function(BuildContext context,Store<AppState> store,bool expired);

/// PersistorGate waits until state is loaded to render the child [builder]
class PersistorGate extends StatefulWidget {
  /// Persistor to gate (wait on).
  final Persistor persistor;

  /// Widget to build once state is loaded.
  final WidgetGateBuilder builder;

  /// widget to show while waiting for state to load.
  final Widget loading;

  PersistorGate({
    this.persistor,
    this.builder,
    Widget loading,
  }) : this.loading = loading ?? Container(width: 0.0, height: 0.0);

  @override
  State<PersistorGate> createState() => _PersistorGateState();
}

class _PersistorGateState extends State<PersistorGate> {
  bool _loaded = false;
  Store _store;
  bool _expired = false;
  bool _error = false;
  Widget _errorWidget;

  @override
  initState() {
    super.initState();

    // Pre-loaded state
    /*widget.persistor.load().then((value){
      CookieUtil.wait().then((t){
        //检测cookie是否过期
        CookieUtil.isExpired().then((b){
          setState(() {
            _store = createStore(value);
            _loaded = true;
            _expired = b;
          });
        });
      });
    });*/

    var asyncWork = [widget.persistor.load(),CookieUtil.wait(),CookieUtil.isExpired()];
    Future.wait<dynamic>(asyncWork).then((List<dynamic> values){
      if(values?.length == asyncWork.length){
        setState(() {
          _store = createStore(values[0]);
          _loaded = true;
          _error = false;
          _expired = values[2];
        });
      }else{
        _processError('初始化出错',"");
      }
    }).catchError((e){
      print(e);
      _processError('初始化出错',e.toString());
    });

  }

  _processError(String msg,String desc){
    _errorWidget = ErrorPage(errMsg: msg,errDesc: desc,);
    setState(() {
      _loaded = true;
      _error = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show [builder] if loaded, else show [loading] if it exist
    return _loaded ? _error ? _errorWidget : widget.builder(context,_store,_expired) : widget.loading;
  }
}
