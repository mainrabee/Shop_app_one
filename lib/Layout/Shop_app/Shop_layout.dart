import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_project1/Layout/Shop_app/cubit/cubit.dart';
import 'package:new_project1/Layout/Shop_app/cubit/states.dart';
import 'package:new_project1/shared/components/components.dart';
import 'package:new_project1/shared/components/constants.dart';
import 'package:new_project1/shared/network/shared.network.local/cache_helper.dart';
import 'package:new_project1/shared/style/colors.dart';
import 'package:new_project1/shop_app/login_screen/Login_screen.dart';
import 'package:new_project1/shop_app/search/search_screen.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit =ShopCubit.get(context);
    return BlocConsumer < ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Text(
                    "SALLA",
                  style: GoogleFonts.aguafinaScript(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),

                ),
                SizedBox(width: 5,),
                Container(
                  height: 35,
                  width: 35,
                  child: Image(image: AssetImage('assets/images/shopping-cart_1f6d2.png',
                  ),),
                ),
              ],
            ),
            actions: [
              IconButton(onPressed: ()
              {
                navegateTo(context, SearchScreen(),);
              },
                icon: Icon(Icons.search),),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar:BottomNavigationBar(
            onTap: (index)
            {
             cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                        Icons.apps,
                    ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                        Icons.category,
                    ),
                  label: "Category",
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                        Icons.favorite,
                    ),
                  label: "Favorite",
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                        Icons.settings,
                    ),
                  label: "Settings",
                ),
              ],) ,

          );

      },
    );
  }
}
