import 'package:flutter/material.dart';
import 'package:flutter_dynamic/ui/pages/search/search_result_view.dart';
import 'package:flutter_dynamic/ui/pages/search/search_suggestion_view.dart';
import 'package:flutter_dynamic/utils/theme_util.dart';

class SearchViewDelegate extends SearchDelegate {

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeUtil.getTheme(context,isDarkMode:ThemeUtil.isDarkMode(context));
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    //右侧显示内容 这里放清除按钮
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //左侧显示内容 这里放了返回按钮
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        } else {
          query = "";
          showSuggestions(context);
        }
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //点击了搜索显示的页面
    return SearchResultView(searchKey: query,);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SearchSuggestionView(blankTap: (){
      showResults(context);
    },);
  }

}