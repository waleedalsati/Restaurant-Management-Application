 import 'getprofileCubit.dart';
import 'model.dart';

abstract class getprofilestate {}
 class successgetprofile extends getprofilestate{
  String message;
   final modelgetuser user;

  successgetprofile({required this.message ,required this.user});

 }
 class loadinggetprofile extends getprofilestate{}
 class faileurgetprofile extends getprofilestate{
  String message;
  faileurgetprofile({required this.message});
 }
