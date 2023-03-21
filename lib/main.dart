
// impo'package:untitled/modules/counter/Counter_screen.dart'rt';
// import 'package:untitled/modules/modules.home/Home_screen.dart';
// im'package:untitled/modules/massenger/Massenger_screen.dart'dart';
// import 'package:untitled/modules/users/Users_screen.dart';
// import 'package:untitled/modules/modules.login/login_screen.dart';


import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project1/Layout/Shop_app/Shop_layout.dart';
import 'package:new_project1/Layout/Shop_app/cubit/cubit.dart';
import 'package:new_project1/Layout/Shop_app/cubit/states.dart';
import 'package:new_project1/shared/bloc_observer.dart';
import 'package:new_project1/shared/components/constants.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:new_project1/shared/components/components.dart';
import 'package:new_project1/shared/style/Themes.dart';
import 'package:new_project1/shop_app/login_screen/Cubit/Cubit.dart';
import 'package:new_project1/shop_app/login_screen/Cubit/States.dart';
import 'package:new_project1/shop_app/login_screen/Login_screen.dart';

import 'shared/network/shared.network.local/cache_helper.dart';
import 'shared/network/shared.network.remote/dio_helper.dart';
import 'shop_app/on_bording_screen.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
   Widget ? widget;
 bool ? onBoarding = CacheHelper.getData(key: 'onBoarding')as bool?;
 token = CacheHelper.getData(key: 'token') ;
 if (onBoarding !=null)
 {
   if (token !=null) widget= ShopLayout();
   else widget= ShopLoginScreen();
 } else
 {
   widget= OnBordingScreen();
 }


  runApp(MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {

 final Widget ? startWidget;
 //
  MyApp({this.startWidget, } );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
      child: BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: ThemeMode.light,
              // AppCubit.get(context).isDark ?ThemeMode.dark:ThemeMode.light ,
              debugShowCheckedModeBanner: false,
              // home: onBoarding ? ShopLoginScreen() : OnBordingScreen(),
              home:  startWidget ,
            );
          }
      ),
    );
  }

}

// return MultiBlocProvider(
// providers: [
// BlocProvider(create: (context)=>NewsCubit()..getBusiness()..getSports()..getScience() ,),
// BlocProvider( create: (BuildContext context) =>AppCubit()
//   ..changeAppMode(
//     // fromShared: isDark,),)
//   )) ],
// ],
// child : BlocConsumer<AppCubit,AppStates>(
// listener: (context,state){},
// builder: (context,state){

