import 'dart:convert';
class errormassage {
  final String message;
  final Map<String, dynamic> errors;
  errormassage({required this.message, required this.errors});
  factory errormassage.fromJeson(String body) {
    final json = jsonDecode(body);
    return errormassage(
      message: json['message'] ?? '',
      errors: json['errors'] ?? {},

    );
  }
  @override
  String toString() {
    String errorDetails = errors.entries.map((e) {
      return "${e.key}: ${(e.value as List).join(', ')}";
    }).join('\n');
    return "$message\n$errorDetails";
  }
}
