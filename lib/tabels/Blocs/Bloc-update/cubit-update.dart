import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:projectweather/tabels/Blocs/Bloc-update/state-update.dart';

import 'dart:convert';

import '../../../Auth/token.dart';


class EditReservationCubit extends Cubit<EditReservationState> {
  EditReservationCubit() : super(EditReservationInitial());

  Future<void> editReservation({
    required int id,
    required String tableType,
    required int seats,
    required String date,
    required String time,
  }) async {
    try {
      String? token = await StorageHelper.getToken();
      emit(EditReservationLoading());

      final response = await http.patch(
        Uri.parse('https://striking-sailfish-severely.ngrok-free.app/api/table/reservations/$id'),
        headers: {
          'Accept': 'application/json',

          'Authorization': 'Bearer $token',
        },
        body: {
          'table_type': tableType,
          'seats': seats.toString(),
          'reservation_date': date,
          'reservation_time': time,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        emit(EditReservationSuccess(data['message'] ?? 'Reservation updated successfully'));
      } else {
        emit(EditReservationFailure('Failed to edit: ${response.body}'));
      }
    } catch (e) {

      emit(EditReservationFailure(e.toString()));
    }
  }
}
