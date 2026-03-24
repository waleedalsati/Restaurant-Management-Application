import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Auth/token.dart';
import '../../../../Helper/api.dart';

import '../Bloc-show-all-cart/show-all-cart-cubit.dart';
import 'addcart-model.dart';
import 'addcart-state.dart';

class AddCartCubit extends Cubit<AddCartState> {
  final api pi;
  AddCartCubit(this.pi) : super(InitialAddCart());

  Future<void> addCart({
    required String foodid,
    required String foodnumber,
    ShowCartCubit? showCartCubit, // نمرر cubit السلة لتحديثها بعد العملية
  }) async {
    try {
      emit(LoadingAddCart());
      String? token1 = await StorageHelper.getToken();

      final response = await pi.post(
        url: 'https://striking-sailfish-severely.ngrok-free.app/api/new_order',
        body: {
          'Food_id': foodid,
          'Foods_Number': foodnumber,
        },
        extraHeaders: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token1',
        },
      );

      if (response.containsKey('errors')) {
        final validation = ModelAddCart.fromJson(response);
        emit(ValidationErrorAddCart(validation));
      } else {
        emit(SuccessAddCart(response['message'] ?? 'تمت الإضافة بنجاح'));

        // ✅ إعادة تحميل السلة من السيرفر مباشرة بعد نجاح العملية
        if (showCartCubit != null) {
          await showCartCubit.showcart();
        }
      }
    } catch (e) {
      emit(FailureAddCart(e.toString()));
    }
  }
}
