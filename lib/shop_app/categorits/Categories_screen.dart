import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project1/Layout/Shop_app/cubit/cubit.dart';
import 'package:new_project1/Layout/Shop_app/cubit/states.dart';
import 'package:new_project1/models/shop_app/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener:(context,state){},
        builder: (context,state){
          return ListView.separated(
              itemBuilder: (context,index)=>buildCategoriesItem(ShopCubit.get(context).categoriesModel!.data!.data[index],),
              separatorBuilder: (context,index)=> Divider(height: 1,),
              itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length,
          );

    }
    );
  }

    Widget buildCategoriesItem(DataModel model)=> Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            height: 80,
            width: 80,
            fit: BoxFit.cover,
            image: NetworkImage(
              model.image!,)
            ,),
          SizedBox(width: 20,),
          Text(
            model.name!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: (){},
            icon: Icon(
              Icons.arrow_forward_ios,
            ),
          ),
        ],
      ),
    );

}
