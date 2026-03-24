class FoodModel {
  final int id;
  final int foodId;
  final String foodName;
  final String description;
  final String foodPrice;
  final int foodQuantity;
  final int likeNumber;
  final String? foodPhoto;

  FoodModel({
    required this.id,
    required this.foodId,
    required this.foodName,
    required this.description,
    required this.foodPrice,
    required this.foodQuantity,
    required this.likeNumber,
    this.foodPhoto,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'] ?? 0,
      foodId: json['food_id'] ?? 0,
      foodName: json['food_name'] ?? '',
      description: json['description'] ?? '',
      foodPrice: json['food_price'] ?? '0',
      foodQuantity: json['food_quantity'] ?? 0,
      likeNumber: json['like_number'] ?? 0,
      foodPhoto: json['food_photo'],
    );
  }
}
