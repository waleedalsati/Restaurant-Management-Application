
import 'package:projectweather/cart%20(2)/dart/Blocs/Bloc-show-all-cart/show-all-cart-model.dart';


abstract class ShowCartState {}

class IntialShowCart extends ShowCartState {}

class LoadingShowCart extends ShowCartState {}

class SuccessShowCart extends ShowCartState {
  final List<ShowCartModel> items;
  final int totalPrice;

  SuccessShowCart( {required this.items, required this.totalPrice});
}
class FailureShowCart extends ShowCartState {
  final String message;
  FailureShowCart(this.message);
}