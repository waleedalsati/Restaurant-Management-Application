import 'addcart-model.dart';

abstract class AddCartState {}
class InitialAddCart extends AddCartState {}
class LoadingAddCart extends AddCartState {}
class SuccessAddCart extends AddCartState {
  final String message;
  SuccessAddCart(this.message);
}

class FailureAddCart extends AddCartState {
  final String message;
  FailureAddCart(this.message);
}
class ValidationErrorAddCart extends AddCartState {
  final ModelAddCart validation;

  ValidationErrorAddCart(this.validation);
}
