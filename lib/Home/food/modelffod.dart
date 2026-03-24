class foodmodel {
  final String id;
  final String name;
  final String des;
  final String price;
  final String quantity;
  late final String number;
  final String photo;

  foodmodel({
    required this.id,
    required this.name,
    required this.des,
    required this.price,
    required this.quantity,
    required this.number,
    required this.photo,
  });

  factory foodmodel.fromjeson(Map<String, dynamic> jeson) {
    return foodmodel(
      id: jeson['id'].toString(),
      name: jeson['food_name'] ?? '',
      des: jeson['description'] ?? '',
      price: jeson['food_price'].toString(),
      quantity: jeson['food_quantity'].toString(),
      number: jeson['like_number'].toString(),
      photo: jeson['food_photo'] ?? '',
    );
  }
}