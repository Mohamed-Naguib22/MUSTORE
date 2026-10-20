enum LoginProvider {
  internal('Internal'),
  google('Google'),
  microsoft('Microsoft'),
  outlook('Outlook');

  const LoginProvider(this.value);
  final String value;

  static LoginProvider fromJson(String value) =>
      LoginProvider.values.firstWhere(
            (e) => e.value.toLowerCase() == value.toLowerCase(),
        orElse: () => throw FormatException('Unknown LoginProvider: $value'),
      );
}