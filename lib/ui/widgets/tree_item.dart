import 'package:flutter/material.dart';
import 'package:flutter_dynamic/net/data/base_tree.dart';
import 'package:flutter_dynamic/styles/colors.dart';
import 'package:flutter_dynamic/utils/navigator_util.dart';
import 'package:flutter_dynamic/utils/theme_util.dart';
import 'package:flutter_dynamic/utils/util.dart';

class TreeItem extends StatelessWidget {

  //typedef ValueChanged<T> = void Function(T value);

  BaseTree base;
  //Function(BaseTree value) onClickItem;

  TreeItem(this.base,);



  @override
  Widget build(BuildContext context) {
    var isDark = ThemeUtil.isDarkMode(context);
    Color darkColor = Colours.dark_light_color;
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        //color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 0.33,
            color: Color(0xffe5e5e5)
          )
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            base.showLabel(),
            //style: TextStyle(color: Colors.black87),
          ),
          Wrap(
            spacing: 10,
            children: List.generate(base.getChildrenLength(), (index) =>
                InkWell(
                  child: Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Chip(
                        label: Text(
                          base.getChildren()[index].showLabel(),
                          style: TextStyle(color: isDark ? Util.getRandomColor() : Colors.white),
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        backgroundColor: isDark ? darkColor : Util.getRandomColor(),
                      ),
                  ),
                  onTap: (){
                    var item = base.getChildren()[index];
                    if(item.isNaviWeb()){
                      NavigatorUtil.webView(context, item.link,title: item.showLabel(),id: item.id,isCollect: item.collect);
                    }else{
                      NavigatorUtil.gotoSystemTree(context,base.showLabel(), base.getChildren(), getTreeIndex(base.getChildren(),item));
                    }
                  },
                )
            ),
          )
        ],
      ),
    );

  }

  ///BaseTree is KnowledgeData
  int getTreeIndex(List<BaseTree> baseList,BaseTree base){
    for (int i = 0; i < baseList?.length??0; i++) {
      if(baseList[i].id == base.id) return i;
    }
    return 0;
  }
}
