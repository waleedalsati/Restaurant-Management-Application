class ModelAddCart {
  final String message;
  final Map<String, dynamic> errors;
  ModelAddCart({
    required this.message,
    required this.errors,
  });
  factory ModelAddCart.fromJson(Map<String, dynamic> json) {
    return ModelAddCart(
      message: json['message'] ?? '',
      errors: json['errors'] ?? {},
    );
  }
}
