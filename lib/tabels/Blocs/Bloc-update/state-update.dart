abstract class EditReservationState {}

class EditReservationInitial extends EditReservationState {}

class EditReservationLoading extends EditReservationState {}

class EditReservationSuccess extends EditReservationState {
  final String message;
  EditReservationSuccess(this.message);
}

class EditReservationFailure extends EditReservationState {
  final String message;
  EditReservationFailure(this.message);
}
