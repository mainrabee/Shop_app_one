import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project1/Layout/Shop_app/cubit/states.dart';
import 'package:new_project1/models/shop_app/Favorites_model.dart';
import 'package:new_project1/models/shop_app/categories_model.dart';
import 'package:new_project1/models/shop_app/changes_favorites_model.dart';
import 'package:new_project1/models/shop_app/home_modes.dart';
import 'package:new_project1/models/shop_app/login_models.dart';
import 'package:new_project1/shared/components/constants.dart';
import 'package:new_project1/shared/network/end_point/end_point.dart';
import 'package:new_project1/shared/network/shared.network.remote/dio_helper.dart';
import 'package:new_project1/shop_app/categorits/Categories_screen.dart';
import 'package:new_project1/shop_app/favorites/favorits_screen.dart';
import 'package:new_project1/shop_app/product/products_screen.dart';
import 'package:new_project1/shop_app/settings/setting_screen.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit():super (ShopInitialState());
  static ShopCubit get(context) =>BlocProvider.of(context);
int currentIndex=0;
List<Widget> bottomScreens=[
  productsScreen(),
  CategoriesScreen(),
  FavoritsScreen(),
  SettingScreen(),
];

void changeBottom(int index)
{
 currentIndex=index;
 emit(ShopChangeBottomState());
}

HomeModel ? homeModel;

Map<int?,bool?> favorites={};
void getHomeData()
{
  emit(ShopLoadingHomeDataState());
  DioHelper.getData(
    url: Home,
    token:token,
  ).then((value)
  {
    homeModel=HomeModel.fromJson(value.data);
    print(homeModel?.status);
    print(homeModel.toString());
    homeModel!.data!.products.forEach((element) {
      favorites.addAll({
        element.id:element.in_favorites,
      });
    });
    emit(ShopSuccessHomeDataState());
  }).catchError((error) {
    print(error.toString());
    emit(ShopErrorHomeDataState());
  });
}


  CategoriesModel ? categoriesModel;
  void getCategories()
  {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token:token,
    ).then((value)
    {
      categoriesModel=CategoriesModel.fromJson(value.data);
      print(homeModel?.status);
      print(homeModel.toString());
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }


  late ChangeFavoritesModel changeFavoritesModel;
  void changeFavorites ( int productId)
  {
    favorites[productId]= ! favorites[productId]!;
    emit(ShopChangeFavoritesState());
  DioHelper.postData(
      url: VAFORITES,
      data:
      {
        'product_id':productId,
      },
    token: token,
  ).then((value) {
    print(token);
    changeFavoritesModel= ChangeFavoritesModel.fromJson(value.data);
    if ( ! changeFavoritesModel.status!)
    {
      favorites[productId]= ! favorites[productId]!;
    }else
    {
      getFavorites();
    }
emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
  }).catchError((error){
    favorites[productId]= ! favorites[productId]!;
    emit(ShopErrorChangeFavoritesState());
  });
  }


  FavoritesModel ? favoritesModel;
  void getFavorites()
  {
    token=token;
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: VAFORITES,
      token:token,
    ).then((value)
    {
      favoritesModel=FavoritesModel.fromJson(value.data);
      print(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }


   ShopLoginModels ?  usermodel;
  void getUserData()
  {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token:token,
    ).then((value)
    {
      usermodel=ShopLoginModels.fromJson(value.data);
      print(value.data);
      emit(ShopSuccessUserDataState(usermodel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }


  void updateUserData({
    required String name,
    required String email,
    required String phone,
})
  {
    emit(ShopLoadingUpdateDataState());
    DioHelper.putData(
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      },
      url:UPDATE_PROFILE,
      token:token,
    ).then((value)
    {
      usermodel=ShopLoginModels.fromJson(value.data);
      emit(ShopSuccessUpdateDataState(usermodel!));
    }).catchError((error) {
      emit(ShopErrorUpdateDataState());
    });
  }
}
