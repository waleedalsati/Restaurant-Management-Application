class ConfirmedOrderItem {
  final int orderId;
  final int userId;
  final int foodId;
  final int quantity;
  final double price;
  late final String status;
  final String createdAt;
  final String updatedAt;
  final Food food;
  ConfirmedOrderItem({
    required this.orderId,
    required this.userId,
    required this.foodId,
    required this.quantity,
    required this.price,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.food,
  });

  factory ConfirmedOrderItem.fromJson(Map<String, dynamic> json) {
    return ConfirmedOrderItem(
      orderId: json['order_id'] ?? 0,
      userId: json['User_id'] ?? 0,
      foodId: json['Food_id'] ?? 0,
      quantity: json['Foods_Number'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
      status: json['Status'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      food: Food.fromJson(json['food']),
    );
  }
}

class Food {
  final int id;
  final String name;
  final String price;

  Food({
    required this.id,
    required this.name,
    required this.price,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'] ?? 0,
      name: json['food_name'] ?? '',
      price: json['food_price'] ?? '0',
    );
  }
}
