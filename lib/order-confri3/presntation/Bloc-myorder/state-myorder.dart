
import 'model-myorder.dart';
abstract class ConfirmedOrdersState  {
  @override
  List<Object?> get props => [];
}

class ConfirmedOrdersInitial extends ConfirmedOrdersState {}

class ConfirmedOrdersLoading extends ConfirmedOrdersState {}

class ConfirmedOrdersSuccess extends ConfirmedOrdersState {
  final List<ConfirmedOrderItem> items;
  final String message;

  ConfirmedOrdersSuccess({required this.items, required this.message});

  @override
  List<Object?> get props => [items, message];
}

class ConfirmedOrdersFailure extends ConfirmedOrdersState {
  final String error;

  ConfirmedOrdersFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
