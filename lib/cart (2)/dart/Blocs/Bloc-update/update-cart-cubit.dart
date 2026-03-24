import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectweather/cart%20(2)/dart/Blocs/Bloc-update/update-cart-model.dart';
import 'package:projectweather/cart%20(2)/dart/Blocs/Bloc-update/update-cart-state.dart';


import '../../../../Auth/token.dart';
import '../../../../Helper/api.dart';

class UpdateCartCubit extends Cubit<updatecartstate> {
  final api b;
  UpdateCartCubit(this.b) : super(inationupdatecart());

  Future<void> updateCart({
    required int orderId,
    required int newFoodId,
    required int newFoodNumber,
  }) async {
    try {
  String?token=await StorageHelper.getToken();
      emit(loadingupdatecart());

      final response = await b.put(
        url: ' https://striking-sailfish-severely.ngrok-free.app/api/update_order/$orderId',
        body: {
          'new_Food_id': newFoodId.toString(),
          'new_Foods_Number': newFoodNumber.toString(),
        },
        extraHeaders: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('response: $response');

      final rawData = response['data'];
      final updateItem = UpdateCartModel.fromJson(rawData);
      final message = response['message']?.toString() ?? '';

      emit(successupdatecart(massage: message, items: [updateItem]));
    } catch (e, stackTrace) {
      emit(failerupdatecart(massage: e.toString()));
      print(' Error: $e');
      print(' StackTrace: $stackTrace');
    }
  }
}
