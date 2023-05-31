import 'package:new_project1/models/shop_app/login_models.dart';

abstract class ShopRegisterStates{}

class ShopRegisterInitialState extends ShopRegisterStates{}

class ShopRegisterloadingState extends ShopRegisterStates{}

class ShopRegisterSuccessState extends ShopRegisterStates
{
  final ShopLoginModels loginModels;

  ShopRegisterSuccessState(this.loginModels);

}

class ShopRegisterErrorState extends ShopRegisterStates
{
  final String error;

  ShopRegisterErrorState(this.error);
}

class ShopRegisterChangePasswordVisibilityState extends ShopRegisterStates{}
