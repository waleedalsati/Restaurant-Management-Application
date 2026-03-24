class ReservationModel {
  final int id;
  final String tableType;
  final int seats;
  final String reservationDate;
  final String reservationTime;

  ReservationModel({
    required this.id,
    required this.tableType,
    required this.seats,
    required this.reservationDate,
    required this.reservationTime,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      id: json['id'],
      tableType: json['table_type'],
      seats: json['seats'],
      reservationDate: json['reservation_date'],
      reservationTime: json['reservation_time'].substring(0,5), // H:i
    );
  }
}
