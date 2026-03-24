import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Helper/api.dart';
import '../../Auth/token.dart';
import 'FavoraiteState.dart';
import 'modelfavorate.dart';



class ShowFavoriteCubit extends Cubit<ShowFavoriteState> {
  final api apiHelper;

  ShowFavoriteCubit( this.apiHelper) : super(ShowFavoriteLoading());

  Future<void> loadFavorites() async {
    emit(ShowFavoriteLoading());
    try {
      String? token = await StorageHelper.getToken();

      final response = await apiHelper.post(
        url: 'https://striking-sailfish-severely.ngrok-free.app/api/favourites',
          extraHeaders: {

      'Authorization':'Bearer $token',

       }
      );


      final List<dynamic> data = response["data"] ?? [];
print(response);
      final favorites = data.map((item) => FoodModel.fromJson(item)).toList();
 String message =response['message'];
      emit(ShowFavoriteLoaded(favorites: favorites,message: message));

    } catch (e) {
      emit(ShowFavoriteError(message: e.toString()));
      print(e.toString());
    }
  }
}


// ================== Model ==================
