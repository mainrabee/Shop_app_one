import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project1/Layout/Shop_app/cubit/cubit.dart';
import 'package:new_project1/Layout/Shop_app/cubit/states.dart';
import 'package:new_project1/models/shop_app/Favorites_model.dart';
import 'package:new_project1/shared/components/components.dart';
import 'package:new_project1/shared/style/colors.dart';

class FavoritsScreen extends StatelessWidget {
  const FavoritsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
        builder: (context,state)
        {
          return ConditionalBuilder(
            condition: state is! ShopLoadingGetFavoritesState,
            builder:(context)=>ListView.separated(
              itemBuilder: (context,index)=> buildListProduct(ShopCubit.get(context).favoritesModel!.data!.data![index].product!,context),
              separatorBuilder: (context,index)=> Divider(height: 0.0001,),
              itemCount:
              ShopCubit.get(context).favoritesModel!.data!.data!.length,
            ) ,
            fallback:(context)=>Center(child: CircularProgressIndicator()) ,

          );
        }
        );

  }

}
