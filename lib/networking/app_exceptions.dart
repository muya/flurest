class AppException implements Exception {
  final dynamic message;
  final String prefix;

  AppException({this.message, required this.prefix});

  @override
  String toString() {
    return "$prefix: $message";
  }
}

class FetchDataException extends AppException {
  static const String _fetchDataErrorPrefix = "Error during API Call";

  FetchDataException(String message)
      : super(message: message, prefix: _fetchDataErrorPrefix);
}

class BadRequestException extends AppException {
  static const String _badExceptionErrorPrefix = "Invalid Request";

  BadRequestException(String message)
      : super(message: message, prefix: _badExceptionErrorPrefix);
}

class UnauthorizedException extends AppException {
  static const String _unauthorizedErrorPrefix = "Unauthorized";

  UnauthorizedException(String message)
      : super(message: message, prefix: _unauthorizedErrorPrefix);
}
