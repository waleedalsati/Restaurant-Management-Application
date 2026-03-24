import 'modle-show-table.dart';

abstract class ReservationState {}

class ReservationInitial extends ReservationState {}
class ReservationLoading extends ReservationState {}
class ReservationSuccess extends ReservationState {
  final List<ReservationModel> reservations;
  ReservationSuccess(this.reservations);
}
class ReservationFailure extends ReservationState {
  final String message;
  ReservationFailure(this.message);
}
