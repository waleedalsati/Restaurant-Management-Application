import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:projectweather/profile/Blocs/Bloc-editprofile/state-editprofile.dart';


import '../../../Auth/token.dart';

class myprofilecubit extends Cubit<myprofilestate> {
  myprofilecubit() : super(loadingmyprofile());
  Future<void> editprofile({
    required String first_name,
    required String last_name,
    required String location,
    required String phone,
    required File photo,
  }) async {
    try {
      final   token = await StorageHelper.getToken();
      print(token);
      emit(loadingmyprofile());
      var uri = Uri.parse('https://striking-sailfish-severely.ngrok-free.app/api/userInfo');
      var request = http.MultipartRequest('POST', uri);
      request.fields['first_name'] = first_name;
      request.fields['last_name'] = last_name;
      request.fields['location'] = location;
      request.fields['phone_number'] = phone.toString() ;
      request.files.add(
        await http.MultipartFile.fromPath(
          'photo',
          photo.path,
          contentType: MediaType('image', 'jpeg'),
        ),
      );
      print(phone);
      request.headers['Accept'] = 'application/json';

      request.headers['Authorization']='Bearer $token';
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      Map<String ,dynamic> data=jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        emit(successmyprofile(message: data['message']));
        print(response.body);
      } else {
        emit(failurmyprofile(message: 'Error ${response.statusCode}: ${response.body}'));
      }
    } catch (e) {
      emit(failurmyprofile(message: e.toString()));
      print(e.toString());
    }
  }
}