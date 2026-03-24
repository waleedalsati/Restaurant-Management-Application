import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:projectweather/tabels/Blocs/Boc-delet-table/state-delete-table.dart';

import '../../../Auth/token.dart';

import 'package:shared_preferences/shared_preferences.dart';

class deletetablecubit extends Cubit<deletetablestate> {
  deletetablecubit() : super(intionaideletetable());

  Future<void> deletetable(int orderId) async {
    try {
      emit(loadingdeletetable());

      String? token=await StorageHelper.getToken();

      final response = await http.delete(
        Uri.parse('https://striking-sailfish-severely.ngrok-free.app/api/table/reservations/$orderId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final message = data['message'] ?? 'تم الحذف بنجاح';
        emit(successdeletetable(message));
      } else {
        emit(failerdeletltable('${response.statusCode}'));
      }
    } catch (e) {
      emit(failerdeletltable('$e'));
    }
  }
}
