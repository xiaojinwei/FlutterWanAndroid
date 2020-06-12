import 'package:flutter/material.dart';
import 'package:flutter_dynamic/net/data/index.dart';
import 'package:flutter_dynamic/utils/date_util.dart';

class CoinItemWidget extends StatelessWidget {

  CoinData coinData;

  CoinItemWidget(this.coinData);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text(coinData?.reason??"",style: TextStyle(fontSize: 14,color: Colors.blue),),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(coinData?.desc??"",style: TextStyle(fontSize: 12),),
            Divider(height: 4,color: Colors.transparent,),
            Text(DateUtil.formatDateMs(coinData?.date??0),style: TextStyle(fontSize: 11,color: Colors.grey),)
          ],
        ),
        trailing: Text("+"+coinData?.coinCount?.toString()??"",style: TextStyle(fontSize: 14,color: Colors.red),),
      ),
    );
  }

}

