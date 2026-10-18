abstract final class ApiConstants {
  static const baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://your-api.example.com',
  );

  static const connectTimeout = Duration(seconds: 120);
  static const receiveTimeout = Duration(seconds: 120);
}