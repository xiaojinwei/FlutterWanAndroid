import 'package:flutter/material.dart';
import 'package:flutter_dynamic/ui/pages/main_drawer.dart';
import 'package:flutter_dynamic/ui/pages/tab/project_page.dart';
import 'package:flutter_dynamic/ui/pages/tab/home_page.dart';
import 'package:flutter_dynamic/ui/pages/tab/official_account_page.dart';
import 'package:flutter_dynamic/ui/pages/tab/system_page.dart';
import 'package:flutter_dynamic/ui/presentation/platform_adaptive.dart';
import 'package:flutter_dynamic/styles/colors.dart';
import 'package:flutter_dynamic/utils/i18n_util.dart';
import 'package:flutter_dynamic/utils/navigator_util.dart';


class TabNavigator extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator>{

  Color _defaultColor = colorStyles['light_gray'];
  Color _activeColor = colorStyles['primary'];
  final List<String> _titles = [];
  String _title = '';

  int _currentIndex = 0;
  final PageController _controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _defaultColor = Colors.grey;
    _activeColor = Theme.of(context).primaryColor;
    _titles.clear();
    _titles.add(I18nUtil.getS(context).tab_one);
    _titles.add(I18nUtil.getS(context).tab_two);
    _titles.add(I18nUtil.getS(context).tab_three);
    _titles.add(I18nUtil.getS(context).tab_four);
    _title = _titles[_currentIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: ()=>NavigatorUtil.gotoSearch(context))
        ],
      ),
      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomePage(),
          ProjectPage(),
          OfficialAccountPage(),
          SystemPage()
        ],
        onPageChanged: (index){
          _switchTab(index);
        },
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: PlatformAdaptiveBottomBar(
        currentIndex: _currentIndex,
        onTap: (index){
          _controller.jumpToPage(index);
          _switchTab(index);
        },
        items: [
          _itemBar(_currentIndex == 0, Icons.home, _titles[0], _defaultColor, _activeColor),
          _itemBar(_currentIndex == 1, Icons.category, _titles[1], _defaultColor, _activeColor),
          _itemBar(_currentIndex == 2, Icons.person, _titles[2], _defaultColor, _activeColor),
          _itemBar(_currentIndex == 3, Icons.navigation, _titles[3], _defaultColor, _activeColor),
        ],
      ),
      drawer: MainDrawer(),
    );
  }

  _switchTab(int index){
    setState(() {
      _currentIndex = index;
      _title = _titles[index];
    });
  }

  _itemBar(bool active,IconData icon,String title,Color defaultColor,Color activeColor){
    return BottomNavigationBarItem(
      icon: Icon(icon,color: defaultColor,),
      activeIcon: Icon(icon,color: activeColor,),
      title: Text(title,style: TextStyle(color: active ? activeColor : defaultColor),)
    );
  }

}