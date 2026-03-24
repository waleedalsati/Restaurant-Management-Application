import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Auth/token.dart';
import '../../../../Helper/api.dart';
import 'show-all-cart-state.dart';
import 'show-all-cart-model.dart';

class ShowCartCubit extends Cubit<ShowCartState> {
  final api a;
  Map<String, int> availableQuantities = {}; // productId -> quantity in cart

  ShowCartCubit(this.a) : super(IntialShowCart());

  /// جلب بيانات السلة من السيرفر
  Future<void> showcart() async {
    try {
      String? token = await StorageHelper.getToken();
      emit(LoadingShowCart());

      final response = await a.get(
        url: 'https://striking-sailfish-severely.ngrok-free.app/api/shopping-cards-all',
        token: token,
      );

      if (response['items'] == null || response['total_price'] == null) {
        emit(FailureShowCart("السلة فارغة أو غير صالحة"));
        return;
      }

      List items = response['items'];
      int total = response['total_price'];

      List<ShowCartModel> data =
      items.map<ShowCartModel>((item) => ShowCartModel.fromJson(item)).toList();

      // تحديث availableQuantities فقط من السيرفر
      availableQuantities.clear();
      for (var item in data) {
        availableQuantities[item.foodid.toString()] = int.tryParse(item.qunreq) ?? 0;
      }

      emit(SuccessShowCart(items: data, totalPrice: total));
    } catch (e) {
      emit(FailureShowCart(e.toString()));
    }
  }

  /// إرجاع كمية المنتج الموجودة في السلة
  int getQuantityForProduct(String productId) {
    return availableQuantities[productId] ?? 0;
  }

  /// تحديث الكمية على الواجهة بعد تنفيذ العملية على السيرفر
  void refreshAfterOperation() async {
    await showcart(); // نعيد جلب السلة من السيرفر
  }
}