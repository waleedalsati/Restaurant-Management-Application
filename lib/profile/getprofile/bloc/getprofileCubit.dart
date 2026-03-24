import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../Auth/login/Bloc/Exception.dart';
import '../../../Auth/token.dart';
import '../../../Helper/api.dart';
import 'getprofilestate.dart';
import 'model.dart';

class getuserCubit extends Cubit<getprofilestate>{
  api api5;
  getuserCubit(this.api5):super(loadinggetprofile());

  Future<dynamic>getuser()async{


 try{
   emit(loadinggetprofile());
   final token=await StorageHelper.getToken();
   print(token);
  final response=await api5.get(

       url:'https://striking-sailfish-severely.ngrok-free.app/api/user/profile',

        token:token
   );

  print( response);
  Map<String,dynamic> data=response;
   final message= data['status'];
 final user=  modelgetuser(first_name: data['user']['first_name'],
     last_name: data['user']['last_name'],
     email: data['user']['email'],
photo: data['user']['photo'],

     location:  data['user']['location']!,);
   print("PHOTO: ${user.photo}");


   emit(successgetprofile(message: message,user: user));
 }on serverexception catch(e){
   emit(faileurgetprofile(message: e.toString()));

   print(e.toString());

 }


  }


}








