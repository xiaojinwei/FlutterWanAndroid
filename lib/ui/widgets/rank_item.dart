import 'package:flutter/material.dart';
import 'package:flutter_dynamic/net/data/index.dart';

class RankItemWidget extends StatelessWidget {

  RankData rankData;
  GestureTapCallback onTap;

  RankItemWidget(this.rankData,{this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        onTap: onTap,
        leading: _Icon(),
        title: Text(rankData?.username,style: TextStyle(fontSize: 16),),
        trailing: Text(rankData?.coinCount?.toString(),style: TextStyle(fontSize: 14),),
      ),
    );
  }

  _Icon() {
    switch(rankData?.rank?.toString()){
      case '1':
        return Icon(Icons.looks_one, color: Colors.red);
      case '2':
        return Icon(Icons.looks_two, color: Colors.green);
      case '3':
        return Icon(Icons.looks_3, color: Colors.blue);
      default :
        return Padding(padding: EdgeInsets.all(8),
        child: Text(rankData?.rank?.toString(),style: TextStyle(fontSize: 14,),)
        );
    }
  }
}

