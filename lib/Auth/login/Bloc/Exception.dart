class serverexception implements Exception {
  final String error;

  serverexception({required this.error});

  @override
  String toString() {
    return error;
  }
}
