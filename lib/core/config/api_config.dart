abstract final class ApiConfig {
  static const baseUrl = "https://localhost:44350/api/";

  static const connectTimeout = Duration(seconds: 120);
  static const receiveTimeout = Duration(seconds: 120);
}