import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectweather/Auth/register/Bloc/register-state.dart';



import '../../../Helper/api.dart';
import '../../token.dart';


class registercubit extends Cubit<registerstate> {
  final api pi;
  registercubit(this.pi) : super(loadingregister());

  Future<dynamic> register({
    required String tok,
    required String firstname,
    required String lsatname,
    required String email,
    required String password,
    required String passwordcon,
  }) async {
    try {
      emit(loadingregister());

      final response = await pi.post(
        url: 'https://striking-sailfish-severely.ngrok-free.app/api/register',
        body: {
          'first_name': firstname,
          'last_name': lsatname,
          'email': email,
          'password': password,
          'confirm_password': passwordcon,
          'fcm_token':tok,
        },
        extraHeaders: {
          'Accept': 'application/json',
        }

      );

Map<String,dynamic>data=response;
final token= data['token'];

print(token);
final message=data['message'];
await StorageHelper.saveToken(token);
await StorageHelper.getToken();
print('k////////////////////////////////////////');
      emit(successregister(massage: message));
    } catch (e) {
      emit(failerregister(massage: e.toString()));
      print("Registration error: $e");
    }
  }
}