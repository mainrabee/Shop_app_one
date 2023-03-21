import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project1/shared/components/components.dart';
import 'package:new_project1/shared/style/colors.dart';
import 'package:new_project1/shop_app/search/cubit/cubit.dart';
import 'package:new_project1/shop_app/search/cubit/states.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);

  var searchController=TextEditingController();

  var formKey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            key: formKey,
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  defaultFotmField(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (String value){
                        if(value.isEmpty)
                        {
                          return 'enter text search ';
                        }
                        return 'oh yah';
                      },
                    onSubmit: (String text)
                    {
                      SearchCubit.get(context).search(text);

                    },
                      label: 'Search',
                      prefix: Icons.search,),
                  SizedBox(
                    height: 15,
                  ),
                  if(state is SearchLoadingState)
                  LinearProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  if(state is SearchSuccessState)
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context,index)=> buildListProduct(SearchCubit.get(context).model.data!.data![index],context,isOldPrise:false),
                      separatorBuilder: (context,index)=> Divider(height: 0.0001,),
                      itemCount: SearchCubit.get(context).model.data!.data!.length,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
