
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dynamic/net/data/index.dart';

import 'dynamic_flutter_logo.dart';

class UserInfoWidget extends StatelessWidget {

  final LoginData data;

  UserInfoWidget(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //color: Colors.white
      ),
      child:Padding(padding: EdgeInsets.only(left: 24,right: 24),
        child: Column(
        children: <Widget>[
          itemIcon('icon', data.icon),
          item('username', data.username),
          item('nickname', data.nickname),
          item('publicName', data.publicName),
          item('email', data.email),
          item('admin', data.admin?.toString()),
        ],
      ),),
    );
  }

  itemIcon(name,value){
    return Padding(padding: EdgeInsets.only(top: 4,bottom: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 100,
          child:  Text(name,style: TextStyle(fontSize: 14,color: Colors.black54)),
        ),
        Padding(padding: EdgeInsets.only(left: 6),
          child: CachedNetworkImage(
            height: 24.0,
            width: 24.0,
            placeholder: (context, url) =>
                DynamicFlutterLogo(24.0,),
            imageUrl: value,
          ),)

      ],
    ),);
  }

  item(name,value){
    return Padding(padding: EdgeInsets.only(top: 4,bottom: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 100,
          child:  Text(name,style: TextStyle(fontSize: 14,color: Colors.black54)),
        ),
        Padding(padding: EdgeInsets.only(left: 6),child: Text(value,style: TextStyle(fontSize: 14,color: Colors.black87)),)
      ],
    ),);
  }
}
