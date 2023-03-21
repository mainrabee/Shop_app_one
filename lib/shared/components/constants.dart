//https://newsapi.org/v2/everything?q=tesla&apiKey=2cc53a76ff3b458198d33326ca002058

import 'package:flutter/material.dart';
import 'package:new_project1/Layout/Shop_app/cubit/cubit.dart';
import 'package:new_project1/shared/components/components.dart';
import 'package:new_project1/shared/network/shared.network.local/cache_helper.dart';
import 'package:new_project1/shop_app/login_screen/Login_screen.dart';

void signOut(context){
  CacheHelper.removeData(key: "token").then((value) {
    if(value)
    {
      navegateAndFinish(context, ShopLoginScreen());
    }
  });
}

String?  token='';


void showToast({context,message,backgroundColor} ) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(

      behavior: SnackBarBehavior.floating,
      margin: EdgeInsetsDirectional.all(20) ,
      dismissDirection: DismissDirection.down,
      backgroundColor: backgroundColor,
      content: Text(message),
      action: SnackBarAction(
        label: 'UNDO',
        onPressed: scaffold.hideCurrentSnackBar,
        textColor: Colors.white,),
    ),);
}
