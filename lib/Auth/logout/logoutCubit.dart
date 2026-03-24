import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Helper/api.dart';
import '../login/Bloc/Exception.dart';
import '../token.dart';

class logoutCubit extends Cubit<logoutState>{
  api api4;
  logoutCubit(this.api4) : super(initiallogout());
  Future<void>logout({required final token})async {
    try{
     final response=await api4.get(url: "https://striking-sailfish-severely.ngrok-free.app/api/logout",
    token: token,


    );

Map<String,dynamic>data=response;
String message=data["message"];
 emit(successlogout(message: message));
 print("klncjlnxjlzcnljxbmcnbxm   ////////////////////////");
StorageHelper.getToken();
    } on serverexception catch (e) {
  emit(faileur(message: e.toString()));
  print(e.toString());
  }
    

    
  }


    
  }
  
  
  
  
  

 abstract class logoutState{}
class successlogout extends logoutState{
  String  message;
  successlogout({required this.message});

}
class initiallogout extends logoutState{}
class faileur extends logoutState{
  String message;
  faileur({required this.message});
}


