class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException([this.message]);

  String toString() {
    if (message == null) return "Session has expired, please login!";
    return "Exception: $message";
  }
}
