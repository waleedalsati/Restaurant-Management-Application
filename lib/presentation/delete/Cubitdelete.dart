import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import '../../../Helper/api.dart';
import '../../../Auth/token.dart';

// ======= States =======
abstract class DeleteFavouriteState {}

class DeleteFavouriteInitial extends DeleteFavouriteState {}

class DeleteFavouriteLoading extends DeleteFavouriteState {}

class DeleteFavouriteSuccess extends DeleteFavouriteState {
  final String message;
  DeleteFavouriteSuccess(this.message);
}

class DeleteFavouriteError extends DeleteFavouriteState {
  final String message;
  DeleteFavouriteError(this.message);
}

// ======= Cubit =======
class DeleteFavouriteCubit extends Cubit<DeleteFavouriteState> {
  final api apiHelper;

  DeleteFavouriteCubit(this.apiHelper) : super(DeleteFavouriteInitial());

  Future<void> deleteFavourite(int id) async {
    emit(DeleteFavouriteLoading());
    try {
      String? token = await StorageHelper.getToken();

      final response = await apiHelper.post(
        url:
        'https://finer-needlessly-sawfish.ngrok-free.app/api/favourite/$id',
          extraHeaders: {

          'Authorization':'Bearer $token',
        }
      );
print(response);

      final message = response["message"] ?? "تم الحذف بنجاح";
      print(message);
      emit(DeleteFavouriteSuccess(message));
    } catch (e) {
      emit(DeleteFavouriteError(e.toString()));
    }
  }
}
