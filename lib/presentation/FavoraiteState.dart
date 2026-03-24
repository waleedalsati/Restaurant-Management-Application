import 'FavoriteCubit.dart';
import 'modelfavorate.dart';

abstract class ShowFavoriteState {}

class ShowFavoriteLoading extends ShowFavoriteState {}

class ShowFavoriteLoaded extends ShowFavoriteState {
  String message;
  final List<FoodModel> favorites;
  ShowFavoriteLoaded({required this.favorites, required this.message});
}

class ShowFavoriteError extends ShowFavoriteState {
  final String message;
  ShowFavoriteError({required this.message});
}

