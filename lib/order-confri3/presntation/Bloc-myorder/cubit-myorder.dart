import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:projectweather/order-confri3/presntation/Bloc-myorder/state-myorder.dart';

import '../../../Auth/token.dart';
import 'model-myorder.dart';

class ConfirmedOrdersCubit extends Cubit<ConfirmedOrdersState> {
  ConfirmedOrdersCubit() : super(ConfirmedOrdersInitial());


  List<ConfirmedOrderItem> _orders = [];

  Future<void> fetchConfirmedOrders() async {
    String? token = await StorageHelper.getToken();
    emit(ConfirmedOrdersLoading());
    try {
      final url = Uri.parse(
          'https://striking-sailfish-severely.ngrok-free.app/api/showtheOrderThatConfirmed'); // رابطك
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final itemsJson = data['items'] as List<dynamic>;
        _orders = itemsJson
            .map((e) => ConfirmedOrderItem.fromJson(e))
            .toList();

        emit(ConfirmedOrdersSuccess(
            items: List.from(_orders), message: data['message']));
      } else {
        emit(ConfirmedOrdersFailure(
            error:
            'Failed to fetch orders. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(ConfirmedOrdersFailure(error: e.toString()));
    }
  }

  // حذف طلب من الواجهة مباشرة
  void removeOrder(int orderId) {
    _orders.removeWhere((o) => o.orderId == orderId);
    emit(ConfirmedOrdersSuccess(items: List.from(_orders), message: ''));
  }


  void updateOrderStatus(int orderId, String newStatus) {
    final index = _orders.indexWhere((o) => o.orderId == orderId);
    if (index != -1) {
      _orders[index].status = newStatus;
      emit(ConfirmedOrdersSuccess(items: List.from(_orders), message: ''));
    }
  }
}
