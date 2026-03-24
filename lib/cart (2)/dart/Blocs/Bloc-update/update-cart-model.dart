class UpdateCartModel {
  final String orderId;
  final String foodsNumber;
  final String price;
  final String foodId;

  UpdateCartModel({
    required this.orderId,
    required this.foodsNumber,
    required this.price,
    required this.foodId,
  });

  factory UpdateCartModel.fromJson(Map<String, dynamic> json) {
    return UpdateCartModel(
      orderId: json['order_id']?.toString()??'',
      foodsNumber: json['Foods_Number']?.toString()??'',
      price: json['price']?.toString()??'',
      foodId: json['Food_id']?.toString()??'',
    );
  }
}
