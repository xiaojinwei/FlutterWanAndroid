import 'package:flutter/material.dart';
import 'package:flutter_dynamic/net/data/index.dart';
import 'package:flutter_dynamic/presenter/search_presenter.dart';
import 'package:flutter_dynamic/ui/pages/search/search_item_view.dart';

typedef BlankTapCallback = void Function();

class SearchSuggestionView extends StatefulWidget {

  BlankTapCallback blankTap;

  SearchSuggestionView({this.blankTap});

  @override
  _SearchSuggestionViewState createState() => _SearchSuggestionViewState();
}

class _SearchSuggestionViewState extends State<SearchSuggestionView> {

  final presenter = SearchPresenter();
  List<HotKey> hotKeys = [];

  @override
  void initState() {
    requestHotKey();
    super.initState();
  }

  requestHotKey(){
    presenter.getHotKey().then((value){
      setState(() {
        hotKeys.clear();
        hotKeys.addAll(value);
      });
    }).catchError((e){

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              '大家都在搜',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SearchItemView(hotKeys),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              '历史记录',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: (){
                  if(widget.blankTap != null) widget.blankTap();
                },
              )
          )
          //SearchItemView()
        ],
      ),
    );
  }
}
