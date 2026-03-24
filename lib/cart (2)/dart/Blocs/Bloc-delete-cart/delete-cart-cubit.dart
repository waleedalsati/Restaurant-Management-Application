import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../Auth/token.dart';

import 'delete-cart-state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class deletecartcubit extends Cubit<deletecartstate> {
  deletecartcubit() : super(intionaideletecart());

  Future<void> deleteCart(int orderId) async {
    try {
      emit(loadingdeletecart());

String? token=await StorageHelper.getToken();

      final response = await http.delete(
        Uri.parse('https://striking-sailfish-severely.ngrok-free.app/api/del_order/$orderId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final message = data['message'] ?? 'تم الحذف بنجاح';
        emit(successdeletecart(message));
      } else {
        emit(failerdeletlcart('${response.statusCode}'));
      }
    } catch (e) {
      emit(failerdeletlcart('$e'));
    }
  }
}
