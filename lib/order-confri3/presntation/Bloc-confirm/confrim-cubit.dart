import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart'as http;

import '../../../Auth/token.dart';
import 'confrim-state.dart';
class confrimcubit extends Cubit<confrim>
{
  confrimcubit():super(inationalconfrim());
  Future<void>confim({required int orderid,required String location})async
  {
    String ?token= await StorageHelper.getToken();
    print(token);
   try
   {
     emit(loadingconfrim());
 final response= await  http.post(Uri.parse(
     'https://striking-sailfish-severely.ngrok-free.app/api/confirmOneOrder/$orderid'

 ) ,
   body:
   {
     'current_location':location
   },

   headers:

        {
          'Authorization':'Bearer $token',
          'Accept': 'application/json',
        },


    );
 print(response);
     if (response.statusCode == 200 || response.statusCode == 201) {
       final data = jsonDecode(response.body);
       final message = data['message'] ?? 'تم تاكيد بنجاح';
       emit(successconfrim(message));
     } else {
       emit(faliarconfrim('${jsonDecode(response.body)}'));
     }
    
  }
  catch(e)
    {
emit(faliarconfrim(e.toString()));
    }

}}