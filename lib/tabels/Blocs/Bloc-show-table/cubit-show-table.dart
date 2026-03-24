import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:projectweather/tabels/Blocs/Bloc-show-table/state-show-table.dart';
import 'dart:convert';

import '../../../Auth/token.dart';
import '../../../Helper/api.dart';
import 'modle-show-table.dart';
class ReservationCubit extends Cubit<ReservationState> {

  ReservationCubit() : super(ReservationInitial());
  Future<void> fetchReservations() async {
    try {
      final api api2;
      String? token = await StorageHelper.getToken();
      emit(ReservationLoading());
      final response = await http.get(
        Uri.parse('https://striking-sailfish-severely.ngrok-free.app/api/table/reservations'),
        headers: {
          'Accept': 'application/json',
           'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'] as List;
        final reservations = data.map((e) => ReservationModel.fromJson(e)).toList();
        emit(ReservationSuccess(reservations));
      } else {
        emit(ReservationFailure(response.body));
      }
    } catch (e) {
      emit(ReservationFailure(e.toString()));
    }
  }
}
