import 'package:flutter/material.dart';
import 'package:flutter_dynamic/event/collect_event.dart';
import 'package:flutter_dynamic/presenter/webview_presenter.dart';
import 'package:flutter_dynamic/ui/widgets/title_bar.dart';
import 'package:flutter_dynamic/utils/bus_util.dart';
import 'package:flutter_dynamic/utils/clipboard_utils.dart';
import 'package:flutter_dynamic/utils/i18n_util.dart';
import 'package:flutter_dynamic/utils/navigator_util.dart';
import 'package:flutter_dynamic/utils/theme_util.dart';
import 'package:flutter_dynamic/utils/util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {

  final String url;
  final String title;
  final int id;
  final bool isCollect;

  WebViewPage(this.url,{Key key,this.title,this.id,this.isCollect = false}):super(key:key);

  @override
  _WebViewPageState createState() => _WebViewPageState(url,title: title,id: id,isCollect: isCollect );
}

class _WebViewPageState extends State<WebViewPage> with TickerProviderStateMixin {

  String url;
  String title;
  int id;
  bool isCollect;

  WebViewController webViewController = null;
  //是否可以后退
  bool canGoBack = false;
  //是否可以前进
  bool canGoForward = false;
  //回到主页
  bool goHome = false;
  //是否正在加载
  bool loading = true;

  AnimationController controller;
  Animation<double> animation;

  var presenter = WebViewPresenter();

  _WebViewPageState(this.url,{this.title,this.id,this.isCollect});

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(false);
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 2000),
        vsync: this
    );
    animation = Tween(begin: 0.0,end: 2.0).animate(controller);
    controller.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        controller.reset();
        if(loading){
          controller.forward();
        }
      }
    });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeUtil.isDarkMode(context);
    return WillPopScope(
        child: Scaffold(
          appBar: TitleBar(
            isShowBack: true,
            title: title,
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                  child:WebView(
                    initialUrl: url,
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController controller){
                      webViewController = controller;
                    },
                    onPageFinished: (String value){
                      if(goHome){
                        if(url != value){
                          webViewController.goBack();
                        }else{
                          goHome = false;
                        }
                      }
                      loading = false;
                      if(controller.isAnimating){
                        controller.reset();
                      }
                      webViewController.canGoBack().then((value){
                        canGoBack = value;
                        setState(() {});
                      });
                      webViewController.canGoForward().then((value) => setState((){
                        canGoForward = value;
                      }));
                    },
                  )
              ),
              Container(
                decoration: BoxDecoration(
                  color: isDark ? Color(0xff323638) : Color(0xfff7f7f7)
                ),
                height: 50,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                        child: InkWell(
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(Icons.close),
                          ),
                          onTap: (){
                            webViewController.canGoBack().then((value){
                              canGoBack = value;
                              if(value){
                                webViewController.goBack();
                              }else{
                                Navigator.of(context).pop();
                              }
                            });
                          },
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: InkWell(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(Icons.arrow_forward),
                          ),
                          onTap: (){
                            webViewController.canGoForward().then((value){
                              canGoForward = value;
                              if(value){
                                webViewController.goForward();
                              }
                            });
                          },
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: InkWell(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(Icons.menu),
                          ),
                          onTap: (){
                            showBottomMenu();
                          },
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: InkWell(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: RotationTransition(
                                turns: animation,
                                child: Icon(Icons.refresh),
                            ),
                          ),
                          onTap: (){
                            loading = true;
                            webViewController.reload();
                            controller.forward();
                          },
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: InkWell(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(Icons.open_in_browser),
                          ),
                          onTap: (){
                            launch(url);
                          },
                        )
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        onWillPop: _requestPop
    );
  }

  void showBottomMenu() {
     showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(
              builder: (context,setBottomSheetState){
                return Container(
                  height: 90,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Column(
                                children: <Widget>[
                                  InkWell(
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.transparent,
                                              width: 0
                                          ),
                                          color: Color(0xfff5f5f5),
                                          shape: BoxShape.circle
                                      ),
                                      width: 40,
                                      height: 40,
                                      child: Center(
                                        child: Icon(Icons.share,size: 30,color: Theme.of(context).primaryColor,),
                                      ),
                                    ),
                                    onTap: (){
                                      _addShareArticle();
                                    },
                                  ),
                                  Text(
                                    I18nUtil.getS(context).share_to_square,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 11.0
                                    ),
                                  )
                                ],
                              )
                          ),
                          Expanded(
                              child: Column(
                                children: <Widget>[
                                  InkWell(
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.transparent,
                                              width: 0
                                          ),
                                          color: Color(0xfff5f5f5),
                                          shape: BoxShape.circle
                                      ),
                                      width: 40,
                                      height: 40,
                                      child: Center(
                                        child:
                                        isCollect ? Icon(Icons.favorite,size: 30,color: Theme.of(context).primaryColor,)
                                            : Icon(Icons.favorite_border,size: 30,color: Theme.of(context).primaryColor,),
                                      ),
                                    ),
                                    onTap: (){
                                      _collect(setBottomSheetState);
                                    },
                                  ),
                                  Text(
                                    I18nUtil.getS(context).collect,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 11.0
                                    ),
                                  )
                                ],
                              )
                          ),
                          Expanded(
                              child: Column(
                                children: <Widget>[
                                  InkWell(
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.transparent,
                                              width: 0
                                          ),
                                          color: Color(0xfff5f5f5),
                                          shape: BoxShape.circle
                                      ),
                                      width: 40,
                                      height: 40,
                                      child: Center(
                                        child: Icon(Icons.content_copy,size: 30,color: Theme.of(context).primaryColor,),
                                      ),
                                    ),
                                    onTap: (){
                                      _copyClipboard();
                                    },
                                  ),
                                  Text(
                                    I18nUtil.getS(context).copy_link,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 11.0
                                    ),
                                  )
                                ],
                              )
                          ),
                          Expanded(
                              child: Column(
                                children: <Widget>[
                                  InkWell(
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.transparent,
                                              width: 0
                                          ),
                                          color: Color(0xfff5f5f5),
                                          shape: BoxShape.circle
                                      ),
                                      width: 40,
                                      height: 40,
                                      child: Center(
                                        child: Icon(Icons.exit_to_app,size: 30,color: Theme.of(context).primaryColor,),
                                      ),
                                    ),
                                    onTap: (){
                                      _exitPage();
                                    },
                                  ),
                                  Text(
                                    I18nUtil.getS(context).exit,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 11.0
                                    ),
                                  )
                                ],
                              )
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }
          );
        }
    );
  }


  _copyClipboard() {
    webViewController.currentUrl().then((value){
      ClipboardUtil.saveData2Clipboard(value);
      Util.toast(I18nUtil.getS(context).copy_success);
      NavigatorUtil.pop(context);
    });
  }

  _collect(Function(VoidCallback fn) setBottomSheetState) {
    !isCollect ? presenter.collect(id, (value){
      setBottomSheetState(() {
        isCollect = !isCollect;
        BusUtil.eventBus.fire(CollectEvent.createPartEvent(widget.id, isCollect));
      });
    }, (e){
      print(e);
    }) : presenter.unCollect(id, (value){
      setBottomSheetState(() {
        isCollect = !isCollect;
        BusUtil.eventBus.fire(CollectEvent.createPartEvent(widget.id, isCollect));
      });
    }, (e){
      print(e);
    });
  }

  void _addShareArticle() {
    presenter.addShare(title, url, (value){
      Fluttertoast.showToast(msg: I18nUtil.getS(context).share_success);
      NavigatorUtil.pop(context);
    }, (e){
      Fluttertoast.showToast(msg: I18nUtil.getS(context).share_failed);
      NavigatorUtil.pop(context);
    });
  }

  void _exitPage() {
    NavigatorUtil.pop(context);
    NavigatorUtil.pop(context);
  }


}
