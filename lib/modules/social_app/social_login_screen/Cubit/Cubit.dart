import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project1/models/shop_app/login_models.dart';
import 'package:new_project1/shared/network/end_point/end_point.dart';
import 'package:new_project1/shared/network/shared.network.remote/dio_helper.dart';
import 'package:new_project1/shop_app/login_screen/Cubit/States.dart';


class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit(): super (ShopLoginInitialState());
  static ShopLoginCubit get(context)=>BlocProvider.of(context);

  late ShopLoginModels loginModels;
  void userLogin({
    required String email,
    required String password,
  })
  {
    emit(ShopLoginloadingState());

    DioHelper.postData(
      url: LOGIN,
      data:
      {
        'email':email,
        'password':password,
      } ,
    ).then((value)
    {
      print(value.data);
      loginModels=ShopLoginModels.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModels));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword=true;

  void changePasswordVisibility()
  {
    isPassword ==!isPassword ;
    suffix= isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityState());
  }
}

