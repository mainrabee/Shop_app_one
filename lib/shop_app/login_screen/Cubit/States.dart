import 'package:new_project1/models/shop_app/login_models.dart';

abstract class ShopLoginStates{}

class ShopLoginInitialState extends ShopLoginStates{}

class ShopLoginloadingState extends ShopLoginStates{}

class ShopLoginSuccessState extends ShopLoginStates
{
  final ShopLoginModels loginModels;

  ShopLoginSuccessState(this.loginModels);
}

class ShopLoginErrorState extends ShopLoginStates
{
  final String error;

  ShopLoginErrorState(this.error);
}

class ShopChangePasswordVisibilityState extends ShopLoginStates{}
