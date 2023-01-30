class HttpException implements Exception {
  final Map<String, dynamic> message;

  HttpException(this.message);

  @override
  String toString() {
    return message.toString();
  }

  Map<String, dynamic> get errors {
    return message;
  }
}
