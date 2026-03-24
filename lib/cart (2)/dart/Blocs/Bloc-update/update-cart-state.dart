



import 'package:projectweather/cart%20(2)/dart/Blocs/Bloc-update/update-cart-model.dart';

abstract class updatecartstate{}
class inationupdatecart extends updatecartstate{}
class loadingupdatecart extends updatecartstate{}
class successupdatecart extends updatecartstate
{
  final String massage;
 final List<UpdateCartModel>items;
  successupdatecart({required this.massage, required this.items});
}
class failerupdatecart extends updatecartstate
{
final String massage;

  failerupdatecart({required this.massage});
}