import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectweather/Auth/login/Bloc/sigin-State.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Helper/api.dart';
import '../../token.dart';
import 'Exception.dart';
import 'model-login.dart';

class SiginCubit extends Cubit<siginstate> {
  final api pi;

  SiginCubit(this.pi) : super(loading());

  Future<void> signIn({required String email, required String password}) async {
    try {
      emit(loading());

      final response = await pi.post(
        url: 'https://striking-sailfish-severely.ngrok-free.app/api/login',
        extraHeaders: {
          'Accept': 'application/json',
          'Accept-Language': 'ar',
        },
        body: {
          'email': email,
          'password': password,
        },
      );

   final Map<String, dynamic> data = response;
      final String token = data['token'];
   final int id =data['user']['id'];

   print(id);
   await StorageHelper.save1Token(id);
  final d= await StorageHelper.get1Token();
  print(d);
      print(token);
    await StorageHelper.saveToken(token);
    await StorageHelper.getToken();

      emit(success(massage: 'Login successful'));
    } on serverexception catch (e) {
      emit(failer(massage: e.toString()));
    }
  }
}












