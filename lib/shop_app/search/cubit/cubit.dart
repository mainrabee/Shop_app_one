import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project1/models/shop_app/search_model.dart';
import 'package:new_project1/shared/components/constants.dart';
import 'package:new_project1/shared/network/end_point/end_point.dart';
import 'package:new_project1/shared/network/shared.network.remote/dio_helper.dart';
import 'package:new_project1/shop_app/search/cubit/states.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit():super (SearchInitialState());

  static SearchCubit get(context)=>BlocProvider.of(context);

late  SearchModel  model;

void search(String text )
{
  emit(SearchLoadingState());
  DioHelper.postData(
      url: SEARCH,
      token: token,
      data: 
      {
        'text':text,
      }).then((value) {
        model=SearchModel.fromJson(value.data);

        emit(SearchSuccessState());
  }).catchError((error){
    emit(SearchErrorState());
        print(error.toString());
  });
}

}
