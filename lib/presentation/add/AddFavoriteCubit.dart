import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Auth/login/Bloc/Exception.dart';
import '../../../Auth/token.dart';
import '../../../Helper/api.dart';
import 'AddFavoiteState.dart';

class AddFavoriteCubit extends Cubit<addFavoriteState> {
  AddFavoriteCubit(this.api9) : super(initialStateF());

  final api api9;

  Future<void> Addfavorite() async {
    try {
    final token=  await StorageHelper.getToken();

      print('تنفيذ الإضافة إلى المفضلة...');
      int? u = await StorageHelper.get1Token();
      int? f = await StorageHelper.get2Token();
print( u);
print(f);
print(token);

      final response = await api9.post(
        url: 'https://striking-sailfish-severely.ngrok-free.app/api/favourite',
        body: {
          'User_id': u.toString(),
          'Food_id': f.toString(),
        },
        extraHeaders: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },

      );

print(response);
//Map<String,dynamic>data=response;
String message =response['message'];
print(message);


      emit(SuccessAdd());
    } on serverexception catch (e) {
      emit(FailAdd(message: e.toString()));
    } catch (e) {
      emit(FailAdd(message: "حدث خطأ غير متوقع: $e"));
    }
  }
}
