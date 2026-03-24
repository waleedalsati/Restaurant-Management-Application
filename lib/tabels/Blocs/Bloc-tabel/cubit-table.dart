import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectweather/tabels/Blocs/Bloc-tabel/state-table.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../Auth/token.dart';
class cubittable extends Cubit<statetable>
{
  cubittable():super(inationaltable());
  Future<void> table({
    required String tabletype,
    required int number,
    required String data,
    required String time,
  }) async {
    try {
      emit(loadingtable());
      String? token = await StorageHelper.getToken();

      final response = await http.patch(
        Uri.parse('https://striking-sailfish-severely.ngrok-free.app/api/table/reservations/decision'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          'table_type': tabletype,
          'seats': number.toString(),
          'reservation_date': data,
          'reservation_time': time,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final message = data['message'] ?? 'تم بنجاح';
        emit(successtable(massage: message));
      } else {
        final error = jsonDecode(response.body);
        String message = error['message'] ?? response.body;

        if (error['errors'] != null) {
          final errorsMap = error['errors'] as Map<String, dynamic>;
          message = errorsMap.values
              .map((e) => (e as List).join(', '))
              .join('\n');
          print(errorsMap);
        }

        emit(failertable(massage: message));
      }
    } catch (e) {
      emit(failertable(massage: e.toString()));
    }
  }


}