import 'package:new_project1/models/shop_app/changes_favorites_model.dart';
import 'package:new_project1/models/shop_app/login_models.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}


class ShopChangeBottomState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates
{
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopChangeFavoritesState extends ShopStates {}

class ShopErrorChangeFavoritesState extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates {}


class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}


class ShopLoadingUserDataState extends ShopStates {}


class ShopSuccessUserDataState extends ShopStates
{
   final ShopLoginModels loginModels;

  ShopSuccessUserDataState(this.loginModels);
}

class ShopErrorUserDataState extends ShopStates {}


class ShopLoadingUpdateDataState extends ShopStates {}


class ShopSuccessUpdateDataState extends ShopStates
{
  final ShopLoginModels loginModels;

  ShopSuccessUpdateDataState(this.loginModels);
}

class ShopErrorUpdateDataState extends ShopStates {}

