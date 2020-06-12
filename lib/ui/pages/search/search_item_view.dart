import 'package:flutter/material.dart';

import 'search_name.dart';

typedef SearchItemTapCallback = void Function(SearchName item,int index);

class SearchItemView extends StatelessWidget {

  final List<SearchName> items;
  final SearchItemTapCallback onTap;
  SearchItemView(this.items,{this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        spacing: 12,
        runSpacing: 2,
        children: List.generate(
          items.length,(index) => SearchItem(items[index],onTap: (){
            if(onTap != null) onTap(items[index],index);
          },
        )
        ),
      ),
    );
  }
}

class SearchItem extends StatelessWidget {

  final SearchName name;
  final GestureTapCallback onTap;
  SearchItem(this.name,{this.onTap});

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: InkWell(
        child: Chip(
          label: Text(name?.showName()),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
        ),
        onTap: onTap,
      ),
      //color: Colors.white,
    );
  }
}
