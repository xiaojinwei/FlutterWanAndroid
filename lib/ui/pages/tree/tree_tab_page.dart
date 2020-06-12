import 'package:flutter/material.dart';
import 'package:flutter_dynamic/net/data/index.dart';
import 'package:flutter_dynamic/ui/pages/tree/tree_list_page.dart';

///知识体系下的文章
class TreeTabPage extends StatefulWidget {

  List<BaseTree> baseList;

  int currentIndex;

  String title;

  TreeTabPage(this.title,this.baseList,int currentIndex) :
        this.currentIndex = (currentIndex >= baseList?.length??0 ? 0 : currentIndex);

  @override
  _TreeTabPageState createState() => _TreeTabPageState();
}

class _TreeTabPageState extends State<TreeTabPage> with TickerProviderStateMixin{

  TabController _controller ;

  @override
  void initState() {
    super.initState();
    _controller = TabController(initialIndex:widget.currentIndex,length: widget.baseList?.length??0, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: DefaultTabController(
          length: _controller.length,
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                child: TabBar(
                  controller: _controller,
                  isScrollable: true,
                  labelColor: Colors.white,
                  labelPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(color: Colors.white,width: 3),
                      insets: EdgeInsets.fromLTRB(0, 0, 0, 0)
                  ),
                  tabs: widget.baseList.map<Tab>((BaseTree tab){
                    return Tab(text: tab.showLabel(),);
                  }).toList(),
                ),
              ),
              Flexible(child: TabBarView(
                controller: _controller,
                children: List.generate(widget.baseList?.length, (index) => TreeListPage(widget.baseList[index]))
              ))
            ],
          )
      ),
    );
  }
}
